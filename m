Message-Id: <seb8c072.014@atlas.snu.edu>
Date: Wed, 07 May 2003 08:14:35 -0500
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <jiadejiade@hotmail.com>, <SELinux@tycho.nsa.gov>
Subject: Re: Questions about arp storm.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>I got arp storm in my network(30 PCs and some WLAN devices),
>
>about 10,000 arp requests per second, no responses, lasting for
several minutes,
>
>all these arp requests have the same content which looks very
strange:
>
>SRC             DST                info
>0060e0017d96    0060f0017d96       who has 192.168.1.188? tell
192.168.1.188
>
>it's an arp request but the DST is not a broadcast, 
>
>and the DST is a real MAC address of one of my netcards while the SRC
is a fake one.
>
>This happens several times a day but not regularly.
>
>Who will send millions of this kind of arp requests?
>
>Need your help, thanks.
>

maybe someone trying to use an arp poisoner like ettercap
(http://ettercap.sf.net) 
ettercap provides tools to track this sort of thing, arp storms are
pretty suspicious, 
I'd check to see if someone was up to no good.

Joshua Brindle
UNIX Administrator
Southern Nazarene University

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
