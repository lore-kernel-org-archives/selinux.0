Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98HXPrT023745
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 13:33:25 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98HWGBk014038
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 17:32:16 GMT
Subject: Re: fuse
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1097256081.16641.179.camel@moss-spartans.epoch.ncsc.mil>
References: <20040922005509.GD14303@lkcl.net>
	 <200409230424.55524.russell@coker.com.au>  <20040922192225.GE7308@lkcl.net>
	 <1097256081.16641.179.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1097256633.16641.194.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 08 Oct 2004 13:30:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-08 at 13:21, Stephen Smalley wrote:
> No special interface for that, just passes the option string via the
> data parameter to mount(2).  So if you are using the patched mount
> program, and fuse takes the typical string representation of mount
> options, then nothing special required to use fscontext=.  Only
> filesystems that use a binary struct to pass the data require special
> handling, like NFS.

Actually, you don't even need the patched mount program; that is only
required for the NFS case.  Unpatched mount will happily pass the
context= or fscontext= options down for you.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
