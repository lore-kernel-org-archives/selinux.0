Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kADGhKos022056
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 11:43:20 -0500
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kADGgZOD025646
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 16:42:36 GMT
Date: Mon, 13 Nov 2006 11:43:25 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        Chad Sellers <csellers@tresys.com>
Subject: Re: Flask headers (Was: RE: [PATCH RFC] SELinux support for DCCP)
In-Reply-To: <1163435927.24635.23.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <XMMS.LNX.4.64.0611131143010.6287@d.namei>
References: <6FE441CD9F0C0C479F2D88F959B015885C76FB@exchange.columbia.tresys.com>
  <XMMS.LNX.4.64.0611111302030.30219@d.namei>  <1163424508.24635.14.camel@moss-spartans.epoch.ncsc.mil>
  <1163435402.18181.121.camel@sgc.columbia.tresys.com>
 <1163435927.24635.23.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 13 Nov 2006, Stephen Smalley wrote:

> flask.h.  We would need a way of marking holes in the class_to_string.h
> table for the kernel to tell the validation code to skip them, e.g. we
> could use S_("null") for userspace classes, and have the validation code
> skip all such entries.  The kernel policy loading validation code
> shouldn't check userspace classes or permissions at all.

Referencing these in the kernel should also be a BUG_ON().


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
