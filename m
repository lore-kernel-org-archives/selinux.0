Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i67KlvrT008814
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 16:47:58 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i67KluaX008888
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 20:47:56 GMT
Subject: Re: policy patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200407041504.48924.russell@coker.com.au>
References: <200407041504.48924.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1089233264.1774.264.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 07 Jul 2004 16:47:44 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-07-04 at 01:04, Russell Coker wrote:
> The attached patch fixes a problem with LVM on Fedora, some annoying audit 
> messages from rpm, and has some of the stuff that's needed for Postgresql (NB 
> it's not enough to make Postgresql fully functional but it's a definite 
> improvement over what's currently there so it's worth having).
> 
> Steve, please put this into Sourceforge.

Thanks, merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
