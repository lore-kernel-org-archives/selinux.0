Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hATFC2Rb000634
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 10:12:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hATFBOp5003246
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 15:11:25 GMT
Received: from unicorn.lemuria.org (c152152.adsl.hansenet.de [213.39.152.152])
	by jazzswing.ncsc.mil  with ESMTP id hATFBOt0003243
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 15:11:24 GMT
Date: Sat, 29 Nov 2003 16:05:07 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: policy under version control
Message-ID: <20031129160507.A9332@lemuria.org>
References: <20031129132619.GE26960@lukas.schuldei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031129132619.GE26960@lukas.schuldei.com>; from andreas@schuldei.org on Sat, Nov 29, 2003 at 02:26:19PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Nov 29, 2003 at 02:26:19PM +0100, Andreas Schuldei wrote:
> I find it tiresom and uneffective to make changes to policy
> without and easy way to feed my effords upstream. Actually i feel
> selinux stands and falls with a smoothly working policy. this
> needs attention and time of many, not just one.

I second that. I get frightened every time I update the policy because
I know it'll break half my local changes.

Also, the update process needs refinement. For one, I find it very
tiresome (and error-prone!) to not bundle packages.

For example, there are many policy files that we can be reasonably sure
will be part of EVERY system. I don't know many Linux systems that
wouldn't want the rules for mount and init, for example.

Why not just lump them into one bundle? Not one .te file, but one
installer question.


> i would therefor suggest to create a public readabel repository
> against which one can update and also some scripts for mailing
> back/submitting to the repository(?) the changes needed to make
> the subsystems work.

Some of the more modern cvs replacements seem suited for this. Arch and
Subversion both might work great with a proper setup.


Also, whatever happened to Collins attempt to automate the install?


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
