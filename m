Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3RNwZRb002657
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 19:58:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3RNuNZx028470
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 23:56:23 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id i3RNuNJv028467
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 23:56:23 GMT
Date: Wed, 28 Apr 2004 00:58:15 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: CDSelle@missi.ncsc.mil, selinux@tycho.nsa.gov
Subject: Re: mkinitrd on Debian
Message-ID: <20040427235815.GF741@vnl.com>
References: <200404271949.i3RJntRK009239@stingray.missi.ncsc.mil> <200404280646.55180.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200404280646.55180.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 28, 2004 at 06:46:55AM +1000, Russell Coker wrote:
> The correct procedure now is to do nothing special with an initrd and to use 
> the modified sysvinit package from my site which will have /sbin/init loading 
> the policy before doing any serious work.  If you add the following 
> to /etc/apt/sources.list then an upgrade should take care of this for 
> Debian/unstable.
> 
> deb http://www.coker.com.au/newselinux/ ./

BTW Russell... tell Faye (if she isn't on the list) 
that she did an excellent job with her HowTo's. I
printed a copy out the other day just for fun. Very
clear description of the new way of doing things
and it might be helpful for this fellow too if you've
the links handy.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
