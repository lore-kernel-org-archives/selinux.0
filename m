Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJIrLIi022808
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 13:53:21 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJIpr3F023773
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 18:51:53 GMT
Subject: Re: using procmail under SE-Linux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: Greg Norris <haphazard@kc.rr.com>, SE-Linux <selinux@tycho.nsa.gov>,
   Jim Carter <jwcart2@epoch.ncsc.mil>
In-Reply-To: <1100837214.23707.15.camel@nexus.verbum.private>
References: <20041119013811.GA21001@yggdrasil.localdomain>
	 <1100837214.23707.15.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1100889824.15944.195.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 19 Nov 2004 13:43:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-11-18 at 23:06, Colin Walters wrote:
> However, I've learned a lot about SELinux since then, and I think a
> better approach would be to use security_compute_relabel.  Then the
> policy itself can specify the type to use, via type_transition.  For
> example:
> 
> type_transition postfix_local_t user_home_dir_t:dir user_procmail_t.
> 
> So procmail would compute the domain to use like this, in pseudocode:
> 
> newcon = security_compute_relabel (getcon (), 
>                                    getfilecon (getpwent (getuid ())->pw_dir))
> setexeccon(newcon)
> 
> To do this right, you create a postfix_user_domain($1) macro, call it
> from base_user_macros.te (and probably ifdef(`procmail.te')).
> 
> I think this is arguably cleaner than having another config file
> in /etc.

Nit:  That would be security_compute_create(), which internally consults
type_transition rules.  security_compute_relabel() is for relabeling and
consults type_change rules.

However, I think you would actually just use get_default_context(), and
define appropriate entries in default_contexts for procmail.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
