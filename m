Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QJEul4017174
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 14:14:56 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1QJGGPM001948
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 19:16:17 GMT
Subject: Re: Changes to init for policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB2920.6000709@redhat.com>
References: <45DB2920.6000709@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 14:16:30 -0500
Message-Id: <1172517390.22224.12.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 12:00 -0500, Daniel J Walsh wrote:
> Added init_exec to init_telinit interface

I added init_exec(); the patch had can_exec($1,init_exec_t).

> Added daemon attribute so we can add general rules around daemons.  Like 
> allowing/disallowing
> daemons to talk to terminals.

I think we want a slightly broader one that can cover services from
inetd too.  I suspect this and the application concept could potentially
be put in the same module.

> ricci_modservice needs to be able to manipulate initrc_exec_t scripts.

These interfaces should be grouped with that change.

> Remove strict policy ifdef.

Not sure what this refers to.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
