Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JCZ6Rb009626
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 08:35:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JCZ4AR003269
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 12:35:04 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4JCZ3Hn003266 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 12:35:03 GMT
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040519074242.GK7348@lkcl.net>
References: <20040519074242.GK7348@lkcl.net>
Content-Type: text/plain
Message-Id: <1084970063.30873.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 19 May 2004 08:34:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-05-19 at 03:42, Luke Kenneth Casson Leighton wrote:
> +#ifdef WITH_SELINUX
> +   if (is_selinux_enabled())

Should be if (is_selinux_enabled() > 0)

> +        if (get_default_context(name,NULL,&scontext))
> +             LogError("Failed to get default security context for %s.", name);

Does LogError exit?  If not, you need to return here.

> +        Debug("setting security context to %s", scontext);
> +        if (setexeccon(scontext)) {
> +             freecon(scontext);
> +             LogError("Failed to set exec security context %s for %s.", scontext, name);

As above, does LogError exit?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
