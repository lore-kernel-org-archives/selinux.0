Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2DLmq36018599
	for <selinux@tycho.nsa.gov>; Mon, 13 Mar 2006 16:48:52 -0500
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2DLml2d013434
	for <selinux@tycho.nsa.gov>; Mon, 13 Mar 2006 21:48:50 GMT
Message-ID: <36282A1733C57546BE392885C0618592010BB70E@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>,
        Stephen Smalley <sds@epoch.ncsc.mil>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: RE: [PATCH] MLS interface update
Date: Mon, 13 Mar 2006 16:48:42 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Christopher J. PeBenito [mailto:cpebenito@tresys.com]
> Sent: Monday, March 13, 2006 9:34 AM
> To: Chad Hanson; Stephen Smalley
> Cc: SELinux List
> Subject: Re: [PATCH] MLS interface update
> 
> 
> The interface additions would be ok, but upon
> closer examination of the constraints, why are the reads 
> traditional BLP
> (l1 dom l2), but the writes aren't (l1 eq l2 for { file lnk_file
> fifo_file }, and (l1 dom l2 and l1 domby h2) for { dir 
> chr_file blk_file
> sock_file })?  In fact, the (l1 dom l2 and l1 domby h2) doesn't look
> correct to me; (l1 domby l2) seems right.  It appears the write
> constraints are being used for integrity (at least for file, lnk_file
> and fifo_file), but we already have TE for this purpose.

The MLS BLP write policy has been modified to write equality, instead of
allowing unrestricted writeup. Unrestricted writeup is usually not desired
and is not even allowed by DCID 6/3. DCID 6/3 requires at least write
limitation to the user's clearance. We have the *toclr attributes to achieve
the clearance restrictions if desired. The { dir chr_file blk_file sock_file
} case is to handle ranged objects whereas { file lnk_file fifo_file } have
constraints to disallow them from being ranged.

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
