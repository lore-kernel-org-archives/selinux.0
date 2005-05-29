From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: dhcpc_t and privuser
Date: Mon, 30 May 2005 02:09:47 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200505300209.51414.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why does the domain dhcpc_t have the privuser attribute?

It doesn't seem to have any use as dhcpc_t can't transition to any user 
domains anyway.  dhclient works well on both strict and targeted without it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
