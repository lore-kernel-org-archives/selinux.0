Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JCo1Rb009778
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 08:50:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JCnxAR004341
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 12:49:59 GMT
Received: from smtp801.mail.ukl.yahoo.com (smtp801.mail.ukl.yahoo.com [217.12.12.138])
        by jazzband.ncsc.mil  with SMTP id i4JCnwHn004338 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 12:49:58 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 19 May 2004 12:49:57 -0000
Date: Wed, 19 May 2004 12:47:16 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
Message-ID: <20040519124715.GC4221@lkcl.net>
References: <20040519074242.GK7348@lkcl.net> <1084970063.30873.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1084970063.30873.22.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 08:34:24AM -0400, Stephen Smalley wrote:
> On Wed, 2004-05-19 at 03:42, Luke Kenneth Casson Leighton wrote:
> > +#ifdef WITH_SELINUX
> > +   if (is_selinux_enabled())
> 
> Should be if (is_selinux_enabled() > 0)

 ah, oops, then the wdm patch needs likewise mods.

> > +        if (get_default_context(name,NULL,&scontext))
> > +             LogError("Failed to get default security context for %s.", name);
> 
> Does LogError exit?  If not, you need to return here.

 no, it's just a printf wrapper.

> > +        Debug("setting security context to %s", scontext);
> > +        if (setexeccon(scontext)) {
> > +             freecon(scontext);
> > +             LogError("Failed to set exec security context %s for %s.", scontext, name);
> 
> As above, does LogError exit?
 
 hm, then does the wdm patch need the same attention?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
