Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GDBAL9015205
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 08:11:11 -0500 (EST)
Subject: Re: sshd transition points
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050215205728.GC26294@lkcl.net>
References: <20050215155323.GC23765@lkcl.net>
	 <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215191640.GA26294@lkcl.net>
	 <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215200355.GB26294@lkcl.net>  <20050215205728.GC26294@lkcl.net>
Content-Type: text/plain
Message-Id: <1108558973.19756.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 16 Feb 2005 08:02:53 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 15:57, Luke Kenneth Casson Leighton wrote:
>  and, sorry for asking a second question in this fashion, but
>  if so, how would i derive the context which to dynamically
>  transition to?
> 
>  i couldn't use get_default_context() ... or could i?
> 
>  it'd involve calling the new lovely setcon(), i know that.

At present, you can't use get_default_context() because it only returns
contexts for which 'transition' permission has been allowed, not
'dyntransition'.  Whether or not we should change the internal logic
(which ultimately goes down to the kernel's /selinux/user interface) to
also return contexts for dynamic transitions or instead introduce a
separate interface for this purpose is not clear.

Further, get_default_context() is only suitable when getting a default
context for a user session.  In this case, you want domains for the
monitor process and the unprivileged child process, neither of which are
associated with a user.  Hence, I'd just pull them out of a config file.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
