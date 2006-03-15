Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2FEtgPZ025112
	for <selinux@tycho.nsa.gov>; Wed, 15 Mar 2006 09:55:42 -0500
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2FErw1t023187
	for <selinux@tycho.nsa.gov>; Wed, 15 Mar 2006 14:54:05 GMT
Message-ID: <36282A1733C57546BE392885C0618592010BB8A8@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>,
        Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: RE: [PATCH] MLS interface update
Date: Wed, 15 Mar 2006 09:55:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Well, can we we at least get the new interfaces added to start with :)

-Chad

> -----Original Message-----
> From: Christopher J. PeBenito [mailto:cpebenito@tresys.com]
> Sent: Monday, March 13, 2006 9:34 AM
> To: Chad Hanson; Stephen Smalley
> Cc: SELinux List
> Subject: Re: [PATCH] MLS interface update
> 
> 
> On Fri, 2006-03-10 at 10:23 -0600, Chad Hanson wrote:
> > This patch updates existing mls interfaces and summaries to reflect
> > the current mls constraints.  Also, there are also new interface
> > definitions for some mls attributes which were lacking interfaces.
> 
> Now that refpolicy is in a release OS (FC5 final), the interfaces have
> to be stabilized, so we can't change interface names without
> compatibility interfaces.  The interface additions would be 
> ok, but upon
> closer examination of the constraints, why are the reads 
> traditional BLP
> (l1 dom l2), but the writes aren't (l1 eq l2 for { file lnk_file
> fifo_file }, and (l1 dom l2 and l1 domby h2) for { dir 
> chr_file blk_file
> sock_file })?  In fact, the (l1 dom l2 and l1 domby h2) doesn't look
> correct to me; (l1 domby l2) seems right.  It appears the write
> constraints are being used for integrity (at least for file, lnk_file
> and fifo_file), but we already have TE for this purpose.
> 
> -- 
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
