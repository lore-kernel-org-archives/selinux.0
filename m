Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3RKmMRb001364
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 16:48:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3RKmFYW004172
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 20:48:15 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i3RKmDBf003934 for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 20:48:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: CDSelle@missi.ncsc.mil
Subject: Re: mkinitrd on Debian
Date: Wed, 28 Apr 2004 06:46:55 +1000
Cc: selinux@tycho.nsa.gov
References: <200404271949.i3RJntRK009239@stingray.missi.ncsc.mil>
In-Reply-To: <200404271949.i3RJntRK009239@stingray.missi.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404280646.55180.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Apr 2004 06:23, CDSelle@missi.ncsc.mil wrote:
> We haven't met, but I'm a SELinux user trying to install on a Debian
> system. Is the script you attached to this message in October still
> current, or is there a better way to make a SELinux initrd for Debian sid
> systems now?

The correct procedure now is to do nothing special with an initrd and to use 
the modified sysvinit package from my site which will have /sbin/init loading 
the policy before doing any serious work.  If you add the following 
to /etc/apt/sources.list then an upgrade should take care of this for 
Debian/unstable.

deb http://www.coker.com.au/newselinux/ ./

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
