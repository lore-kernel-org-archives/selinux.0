Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6RHXjrT004145
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 13:33:45 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6RHXFmJ029346
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 17:33:16 GMT
Subject: Re: [idea] multiple contexts.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040727160605.GG3392@lkcl.net>
References: <20040724231154.GE3437@lkcl.net>
	 <1090858323.24945.116.camel@moss-spartans.epoch.ncsc.mil>
	 <20040727160605.GG3392@lkcl.net>
Content-Type: text/plain
Message-Id: <1090949595.2448.180.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 27 Jul 2004 13:33:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-07-27 at 12:06, Luke Kenneth Casson Leighton wrote:
>  well, not entirely - not dynamically, anyway: at least i do not
>  believe so.
> 
>  i thought originally that it would be possible to do what i envisaged
>  with m4, by extending the policy language.

There are already plenty of cases where derived domains are defined via
macros, so that the new domain expresses information about both the
caller and the newly executed program.  Even in your example, kde_user_t
is an example of a derived domain that can implicitly indicate that the
caller was user_t, without needing multiple contexts at all.

Introducing multiple contexts per process would have a significant
impact on the security model and analysis of a policy.

>  i also seek to limit the programs that a KDE user may run.
> 
>  if there is a simple way to do that which does not involve writing
>  policy files for each and every single KDE program i intend to restrict
>  users to use, i would be interested to hear it.

I'm not sure why this is a problem; you can already define what program
types can be executed by a given domain.  Possibly I just don't
understand, as I haven't used KDE myself.

With regard to the exim4 example, it would seem to make sense to have
exim4 use the policy API to compute contexts based on a configuration
and setexeccon() to these contexts explicitly to avoid having to
maintain all of the different wrapper programs.  But it isn't that it is
picking up an extra context; it is changing to a new context, one that
has its own particular set of permissions in the policy.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
