Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0LJx8FX015045
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 14:59:08 -0500 (EST)
Subject: Re: run_init and interactive scripts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <877jm7e2v6.fsf@glaurung.internal.golden-gryphon.com>
References: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
	 <1106247919.26753.207.camel@moss-spartans.epoch.ncsc.mil>
	 <877jm7e2v6.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1106337159.28551.186.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 21 Jan 2005 14:52:39 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-01-21 at 01:02, Manoj Srivastava wrote:
> 	What follows is an incremental patch relative to the changes
>  already accepted.

BTW, this was merged into sourceforge CVS as of policycoreutils 1.21.2,
including the audit2allow man page, revised genhomedircon script and man
page, and the open_init_pty helper for run_init (with stderr flushing,
but not the latest patch that introduced erratic output).
> 
> ______________________________________________________________________
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
