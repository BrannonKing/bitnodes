from collections import defaultdict
import json
import pprint
import protocol
import requests
import sys


def main():

    addr_to_scan = set()
    addr_done = set()
    agents = defaultdict(list)

    # to_addr = ("88.99.167.175", PORT)
    addr_to_scan.add(("192.241.159.75", 9246))
    addr_to_scan.add(("139.59.132.163", 9246))
    addr_to_scan.add(("34.231.101.5", 9246))

    while any(addr_to_scan):
        try:
            to_addr = addr_to_scan.pop()
            addr_done.add(to_addr)
            print 'opening', to_addr  # fae4aaf1
            conn = protocol.Connection(to_addr, to_services=1, from_services=0, protocol_version=70011,
                                       magic_number="\xFA\xE4\xAA\xF1", user_agent="LBRYcrawler:0.1", height=532866)
            conn.open()
            print 'opened', to_addr, '; now getting version'
            handshake_msgs = conn.handshake()
            # pprint.pprint(handshake_msgs)
            agent = handshake_msgs[0]['user_agent']
            print 'got handshake with agent', agent, '; now getting addresses for', to_addr
            conn.getaddr(block=False)
            obj = json.loads(requests.get('http://ipinfo.io/' + to_addr[0]).text)
            agents[agent].append(obj)
            while True:
                conn.sleep1()
                addr_msgs = conn.get_messages(commands='addr')
                if len(addr_msgs):
                    for msg in addr_msgs:
                        hits = 0
                        for address in msg['addr_list']:
                            if address['onion']:
                                print 'not following', address
                            entry = (address['ipv4'] or address['ipv6'], address['port'])
                            if entry not in addr_done:
                                addr_to_scan.add(entry)
                                hits += 1
                        print 'added', hits, 'of', len(msg['addr_list'])
                    break
            conn.close()

        except (protocol.ProtocolError, protocol.ConnectionError, protocol.socket.error, KeyboardInterrupt) as err:
            print "{}: {}".format(err, to_addr)
            if err is KeyboardInterrupt:
                break

    pprint.pprint(agents)

    return 0


if __name__ == '__main__':
    sys.exit(main())