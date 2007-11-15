Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAFNSQ9o031756
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 18:28:26 -0500
Received: from web32210.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lAFNSN7U025969
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 23:28:23 GMT
Date: Thu, 15 Nov 2007 15:28:08 -0800 (PST)
From: Hal <hal_bg@yahoo.com>
Subject: Trouble with mounted /home
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <216051.28052.qm@web32210.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi all
I have problem with Selinux targeted policy and mounted user home dirs on F8.

What I did was:
# mkfs -t ext3 /dev/sdb1
# mount /dev/sdb1 /home

# useradd test1
# passwd test1

# useradd -Z xguest_u test2 
# passwd test2

# vi /etc/fstab 
and added /dev/sdb1 as /home

from the GUI I have set targeted/enforcing and checked relabel on reboot.

# reboot

In the gdm I tried to login as test1 and test2 with no success. A message pops
up on the screen saying that /home/test1 or /home/test2 does not exist
respectively.

when I set permissive no problems at all despite of some avc denials about
tomboy and /tmp...

It seems there are no messaages in /var/log/messages in enforcing mode...

So can anybody tell me how to use selinux with a mounted home?

By the way /home/test1 and /home/test2 have the correct labeling.

Thanks in advance!  


Rumen


      ____________________________________________________________________________________
Get easy, one-click access to your favorites. 
Make Yahoo! your homepage.
http://www.yahoo.com/r/hs 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
