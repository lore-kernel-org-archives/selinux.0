From: "jiade" <jiadejiade@hotmail.com>
To: <SELinux@tycho.nsa.gov>
Subject: Questions about arp storm.
Date: Wed, 7 May 2003 10:33:51 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-ID: <Sea2-DAV68e4fDGCl9F00000373@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I got arp storm in my network(30 PCs and some WLAN devices),

about 10,000 arp requests per second, no responses, lasting for several minutes,

all these arp requests have the same content which looks very strange:

SRC             DST                info
0060e0017d96    0060f0017d96       who has 192.168.1.188? tell 192.168.1.188

it's an arp request but the DST is not a broadcast, 

and the DST is a real MAC address of one of my netcards while the SRC is a fake one.

This happens several times a day but not regularly.

Who will send millions of this kind of arp requests?

Need your help, thanks.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
