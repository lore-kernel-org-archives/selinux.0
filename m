Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0LJH7FX014588
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 14:17:08 -0500 (EST)
Subject: Re: run_init and interactive scripts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87fz0ufwz0.fsf@glaurung.internal.golden-gryphon.com>
References: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
	 <1106246926.26753.196.camel@moss-spartans.epoch.ncsc.mil>
	 <87fz0ufwz0.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1106333491.28551.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 21 Jan 2005 13:51:31 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-01-21 at 13:39, Manoj Srivastava wrote:
>         This is because I was putting the users terminal into raw
>  mode, and that also turns off output processing.  So, in the
>  following patch I introduce a function called tty_semi_raw, which is
>  just like raw mode, except we retain output processing. This is still
>  fine for things like aptitude and dselect, and makes the non-curses
>  applicationss look OK (like so)
> ======================================================================
> Shutting down mimedefang: [  OK  ]
> Shutting down mimedefang-multiplexor: [  OK  ]
>  ....
> ======================================================================
> 
>         This is an incremental patch in addition to the one I sent 12
>  hours or so ago, which had the fflush stderr fixes. Please apply.

Hmmm...I now get erratic behavior, sometimes only getting the first line
of output (Stopping sshd: [ OK ]), sometimes getting the first line and
the prefix of the second line, but still not the complete output.  And
this behavior occurs under permissive mode as well, so it isn't related
to any permissions.  Reverting this latest patch, I at least get
consistent output, only losing the final OK status.
> 
> ______________________________________________________________________
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
