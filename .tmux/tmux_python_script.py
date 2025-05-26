import socket
import psutil

EXCLUDED_INTERFACES = {"lo", "docker0"}

def get_ipv4_addresses():
    interfaces = psutil.net_if_addrs()
    ips = []

    for iface, addrs in interfaces.items():
        if iface in EXCLUDED_INTERFACES:
            continue
        for addr in addrs:
            if addr.family == socket.AF_INET:
                ips.append(addr.address)

    return ips

def main():
    ipv4_list = get_ipv4_addresses()
    print(",".join(ipv4_list))

if __name__ == "__main__":
    main()
