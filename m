Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7IAstrT019290
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 06:54:56 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7IAsrRq014581
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 10:54:54 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: policy for k3b (and cdrecord)
Date: Wed, 18 Aug 2004 20:54:46 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040817183311.GR18321@lkcl.net>
In-Reply-To: <20040817183311.GR18321@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408182054.46451.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 18 Aug 2004 04:33, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> i'm writing a policy for k3b (kde cd burner) and cdrecord because
> write access by users to /dev/hdc is banned (policy violation) and
> because, well, because.

Why not change the type of /dev/hdc to removable_device_t and define 
user_rw_noexattrfile when compiling the policy?  That should be all that the 
CD burner needs.

If you have a special policy for burning CDs then that policy needs to be 
limited to only files that the user can access.

> - for more generic use, obviously k3b must be allowed to access pretty
>   much anything on / so what should i put in place of all the
>   dontaudits and allow k3b_t user_home_t etc. stuff?

If you have a domain k3b_t which is entered from any user domain then user_t 
can use it to write files from a staff_r home directory to a CD...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
