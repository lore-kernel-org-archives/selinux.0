Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3KIvspN001426
	for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2006 14:57:54 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3KIvr63016479
	for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2006 18:57:53 GMT
Message-ID: <36282A1733C57546BE392885C0618592011A227E@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh
	 <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        "Klaus Weidner (E-mail)"
	 <klaus@atsec.com>
Subject: RE: Latest diffs
Date: Thu, 20 Apr 2006 14:57:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


It is definitely desirable to a have an audit role where another user can
log onto the analyze the audit trail of a system to determine if there has
been malicous activity on the system by users or administrators.

This approach is follows the traditional seperation of duty concept.

-Chad

> -----Original Message-----
> From: Christopher J. PeBenito [mailto:cpebenito@tresys.com]
> Sent: Thursday, April 20, 2006 1:18 PM
> To: Daniel J Walsh
> Cc: SE Linux
> Subject: Re: Latest diffs
> 
> 
> On Thu, 2006-04-20 at 14:06 -0400, Daniel J Walsh wrote:
> > Added and fixed Russells patch to add auditadm_r.
> 
> Why do we need an auditadm in addition to secadm?
> 
> -- 
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
> 
> 
> --
> This message was distributed to subscribers of the selinux 
> mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
