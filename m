Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j06BnkIi008076
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 06:49:46 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j06BnloP007164
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 11:49:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Greg Norris <haphazard@kc.rr.com>
Subject: Re: [patch] types.fc
Date: Thu, 6 Jan 2005 22:49:41 +1100
Cc: SELinux <selinux@tycho.nsa.gov>
References: <20050104025950.GA5321@yggdrasil.localdomain> <200501050032.29370.russell@coker.com.au> <20050104151703.GA8223@yggdrasil.localdomain>
In-Reply-To: <20050104151703.GA8223@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200501062249.44651.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 05 January 2005 02:17, Greg Norris <haphazard@kc.rr.com> wrote:
> > But I have been considering just moving to the locations that are used in
> > Fedora.
>
> This seems like a good idea to me.  If nothing else, it would make it
> easier to support multiple policies in the future... should we decide to
> do something similar to Fedora's strict/targeted scheme.  Personally, I
> rather like their approach.

The way things currently work in Debian is that the policy source files are 
copied to locations under /etc/selinux.  This means that you can have either 
strict or targeted policy and just choose a different source for copying.  My 
design for Debian always supported multiple policies, it's just that I never 
had time to write more than one policy and no-one else wrote one for Debian.

The advantage of the Fedora method is that you can quickly and easily switch 
between different policies by just changing one config file, creating a flag 
file, and rebooting.  This allows you to easily change policies and then 
change back if you wish.  With Debian changing policies is a significant 
matter to undertake and not something that you want to do often.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
