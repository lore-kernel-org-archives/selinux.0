From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux@tycho.nsa.gov
Subject: df and getattr
Date: Mon, 14 Apr 2003 14:32:46 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200304141432.46560.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In a recent version of coreutils (I suspect it was 4.5.9 from the changelog) 
the actions of df changed.  It used to do a stat() of each mount point, and 
now it appears not to do so.

This is a change of note because df is something that gets run hundreds of 
times per day, and everything it does must be covered by an allow or 
dontaudit rule.

In my current policy tree I am not allowing user_t usbdevfs_t:dir getattr 
access.  df from coreutils 4.5.7 requests this (although it runs fine without 
it), df from coreutils 4.5.10 does not request this.  There are probably 
other situations where similar things can arise.

IMHO  Upgrading coreutils/df is a better option than granting extra access 
(but if you can't upgrade then it's not a difficult change to make in the 
policy).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
