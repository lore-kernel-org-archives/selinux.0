Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m24IfAm2023857
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 13:41:11 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m24If32k001028
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 18:41:03 GMT
Subject: Re: [refpolicy] loadkeys and init fds
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Martin Orr <martin@martinorr.name>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <47C2D1EE.7060309@martinorr.name>
References: <47C2D1EE.7060309@martinorr.name>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 13:38:16 -0500
Message-Id: <1204655896.14217.14.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-02-25 at 14:34 +0000, Martin Orr wrote:
> Prevent audit messages on boot:
> 
> Feb 25 13:52:47 caligula kernel: audit(1203947566.566:9): avc:  denied  {
> use } for  pid=2900 comm="loadkeys" path="/dev/console" dev=tmpfs ino=311
> context=system_u:system_r:loadkeys_t:s0 tcontext=system_u:system_r:init_t:s0
> tclass=fd

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
