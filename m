From: "jiade" <jiadejiade@hotmail.com>
To: <SELinux@tycho.nsa.gov>
Subject: Source MAC Address DoS
Date: Thu, 8 May 2003 16:34:10 +0800
Message-ID: <Sea2-DAV62M19VMczi9000012c6@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(For those who have read the first part, there are new
content added, thanks!)

I got arp storm in my network(30 PCs and some WLAN devices),
about 10,000 arp requests per second, no responses,lasting
for severalminutes,all these arp requests have the same content
which looks very strange:

SRC             DST                info
0060e0017d96    0060f0017d96       who has 192.168.1.188? tell 192.168.1.188

it's an arp request but the DST is not a broadcast,
and the DST is a real MAC address of one of my netcards
while the SRC is a fake one.
This happens several times a day but not regularly.
Who will send millions of this kind of arp requests?

Later I captured these packets and replayed this storm at 10000packets/s,
no matter what kind of upper level protocol stuff (ARP,UDP or somethingelse)
I filled in these packets ,they will jam up the Linux box whose MAC address
is the same as the SOURCE (not the destination) MAC address of these
packets.
When I change the packets'source MAC address with the destination MAC
address,the Linux box works well.I don't know the reason.

Need your help, thanks.








--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
