From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <SELinux@tycho.nsa.gov>
Subject: please remove devfsd policy
Date: Wed, 29 Sep 2004 21:51:03 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200409292151.03017.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With the increasing support of udev we are getting even further away from the 
possibility of ever supporting devfsd again.  I think that the devfsd policy 
should be removed from cvs, both devfsd.te and devfsd.fc should go.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
