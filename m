Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JFwkgA015372
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 11:58:46 -0400 (EDT)
Received: from rproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4JFsbDf000593
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 15:54:37 GMT
Received: by rproxy.gmail.com with SMTP id c16so345430rne
        for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 08:54:53 -0700 (PDT)
Message-ID: <46ce702f05051908547025fbeb@mail.gmail.com>
Date: Thu, 19 May 2005 10:54:53 -0500
From: Serge Hallyn <serge.hallyn@gmail.com>
Reply-To: Serge Hallyn <serge.hallyn@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: targeted policy patch
In-Reply-To: <1116516582.7682.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46ce702f050519081136af356@mail.gmail.com>
	 <1116516582.7682.70.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ah, ok, thanks.

What about the strict policy?  Should I use that out of fc as well?

thanks,
-serge

On 5/19/05, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2005-05-19 at 10:11 -0500, Serge Hallyn wrote:
> > Hi,
> >
> > In order to compile the sf.net targeted policy on a gentoo system with
> > the sf.net checkpolicy, I needed the following patch.  It does several
> > small things, the last of which I expect is actually wrong, but at
> > least gets me a compiling policy:
> >
> > 1. preserves kernel.te to get its type declaration.
> > 2. fixes what i assume is a type, 'rm -rf domains/misc/used' instead of unused
> > 3. deletes setfiles.fc, since setfiles_exec_t is not declared in the policy
> > 4. adds the unrestricted attribute to the insmod_t domain.  This stops
> > a conflict with the neverallow rule for ~signal -> unconfined_t.
> 
> I'd advise using the targeted policy spec file from the Fedora Core CVS
> tree instead; we only update our spec files occasionally (e.g. prior to
> an updated release on nsa.gov) and they are only intended as examples.
> FC4 targeted policy includes many more domains.
> 
> --
> Stephen Smalley
> National Security Agency
> 
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
