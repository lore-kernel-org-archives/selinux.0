Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFEufIi023358
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 09:56:41 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFEtFvq023503
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 14:55:15 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041115143420.GB5492@lkcl.net>
References: <20041114202332.GO5031@lkcl.net>
	 <1100525144.31773.30.camel@moss-spartans.epoch.ncsc.mil>
	 <20041115143420.GB5492@lkcl.net>
Content-Type: text/plain
Message-Id: <1100530357.31773.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 15 Nov 2004 09:52:37 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-15 at 09:34, Luke Kenneth Casson Leighton wrote:
>  just to make absolutely sure: my fears about A being able to
>  transition to anydomainatall would be true if someone [explicitly]
>  did this:
> 
> 	allow A domain:process dyntransition;
> 
>  is that correct?

Yes, or even something less direct, e.g.
	allow A B:process dyntransition;
	allow B C:process dyntransition;
	allow C domain:process dyntransition;

But this specific issue (bounding the set of reachable domains) is not
particularly different than the equivalent rule for exec-based
transitions, e.g.
	allow A domain:process transition;
would be just as bad, given that at least one privileged domain (i.e.
sysadm_t) has the shell as its entrypoint.  The exec-based transitions
can apply entrypoint restrictions in most cases and can apply
inheritance controls, but you still want to bound reachability there as
well.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
