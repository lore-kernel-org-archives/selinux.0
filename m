Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0LKPHFX015355
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 15:25:17 -0500 (EST)
Subject: Re: run_init and interactive scripts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87brbiftip.fsf@glaurung.internal.golden-gryphon.com>
References: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
	 <1106246926.26753.196.camel@moss-spartans.epoch.ncsc.mil>
	 <87fz0ufwz0.fsf@glaurung.internal.golden-gryphon.com>
	 <1106333491.28551.159.camel@moss-spartans.epoch.ncsc.mil>
	 <87brbiftip.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1106338749.28551.203.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 21 Jan 2005 15:19:09 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-01-21 at 14:53, Manoj Srivastava wrote:
> 	That is strange, seeing that the only changes in that patch
>  were _adding_ fflush statements.

No, I'm referring to the tty semi raw patch.  With it applied, I get
erratic output on sshd restart, always losing at least the last OK
status but sometimes losing the entire final line.  With it reverted
(but including the fflush patch), I get stable output, but it always
clips the last OK status.

> 	I am attaching the full open_init_pty.c file below; I've
>  tested this as extensively as I can on a number of Debian machines.

Yes, this matches what I would have if I apply the tty semi raw patch to
what is already committed, which induces the erratic output.  I'm using
FC3 here.
> 
> ______________________________________________________________________
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
