Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2DFWvuh009841
	for <selinux@tycho.nsa.gov>; Mon, 13 Mar 2006 10:32:57 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2DFWo2d008400
	for <selinux@tycho.nsa.gov>; Mon, 13 Mar 2006 15:32:55 GMT
Subject: Re: [PATCH] MLS interface update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Chad Hanson <chanson@TrustedCS.com>, Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <20060310162359.GC2949@dhcp-225.il.tcs-sec.com>
References: <20060310162359.GC2949@dhcp-225.il.tcs-sec.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 10:33:31 -0500
Message-Id: <1142264011.30819.241.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-10 at 10:23 -0600, Chad Hanson wrote:
> This patch updates existing mls interfaces and summaries to reflect
> the current mls constraints.  Also, there are also new interface
> definitions for some mls attributes which were lacking interfaces.

Now that refpolicy is in a release OS (FC5 final), the interfaces have
to be stabilized, so we can't change interface names without
compatibility interfaces.  The interface additions would be ok, but upon
closer examination of the constraints, why are the reads traditional BLP
(l1 dom l2), but the writes aren't (l1 eq l2 for { file lnk_file
fifo_file }, and (l1 dom l2 and l1 domby h2) for { dir chr_file blk_file
sock_file })?  In fact, the (l1 dom l2 and l1 domby h2) doesn't look
correct to me; (l1 domby l2) seems right.  It appears the write
constraints are being used for integrity (at least for file, lnk_file
and fifo_file), but we already have TE for this purpose.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
