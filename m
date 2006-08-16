Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7GEleYo032491
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 10:47:40 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7GElFXM020474
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 14:47:15 GMT
Subject: Re: trouble with a transition to verify access to a printer
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Matt Anderson <mra@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <44E1E215.30602@hp.com>
References: <44E1E215.30602@hp.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 10:48:27 -0400
Message-Id: <1155739708.6780.41.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-15 at 11:02 -0400, Matt Anderson wrote:
> I'm having some trouble verifying a user has access to a given printer.
>  In the CUPS architecture a user submits their job over a socket
> connection to the server which queues it and eventually prints it.  The
> server can get the client's context via getpeercon() and that
> information is stored as metadata with the job.  Often the context is
> user_u:user_r:user_lpr_t:SystemLow  and the context of the running cupsd
> is system_u:system_r:cupsd_t:SystemLow-SystemHigh.
> 
> In order to keep the security decisions out of cupsd it was suggested
> that a helper program be used.  The cupsd server could setexeccon() this
> program with the job's stored context and the helper would use access()
> to determine if it could write to the printer device (typically
> /dev/parport0 with context system_u:object_r:printer_device_t:SystemLow)
> 
> When run in enforcing mode however I get the following AVC deny message:
> 
> type=AVC msg=audit(1155470231.462:11179): avc:  denied  { transition }
> for  pid=3046 comm="cupsd" name="lspp-access" dev=sda4 ino=420583
> scontext=system_u:system_r:cupsd_t:s0-s15:c0.c255
> tcontext=user_u:user_r:user_lpr_t:s0 tclass=process

> pebenito suggested on #selinux that since cupsd was switching identities
> and roles that was causing the deny.  If thats the case, is there anyway
> around that?

You would either have to use the unconditional exemption for role and
identity changes, which has no constraint (except having a valid
context) on the roles and identities it can set, or alter the
constraints to allow this combination.

> Is there a better way to solve this problem?

Another way would be for the helper to just getfilecon() the device, and
then use that context and the getpeercon() context to do a
security_compute_av().  This has an advantage of not requiring a
setexeccon() in cups, as the context could be passed on the command
line.  The down side is that it doesn't do a DAC check, but that doesn't
appear to be relevant in this case.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
