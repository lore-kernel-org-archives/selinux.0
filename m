Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA43bgXZ020606
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 22:37:42 -0500 (EST)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA43aK4w001568
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 03:36:21 GMT
Subject: Re: Updated SELinux Release
From: Colin Walters <walters@verbum.org>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87vfcmqvi5.fsf@glaurung.internal.golden-gryphon.com>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <87vfcmqvi5.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Date: Wed, 03 Nov 2004 22:37:42 -0500
Message-Id: <1099539462.5018.2.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 18:59 -0600, Manoj Srivastava wrote:
> On Wed, 03 Nov 2004 10:39:40 -0500, Stephen Smalley <sds@epoch.ncsc.mil> said: 
> 
> > An updated SELinux release is available from the NSA SELinux web
> > site; see http://www.nsa.gov/selinux/news.cfm#R041102.  
> 
> 	I have been looking at the changes in libsepol, and I see
>  these changes to the API:
> ======================================================================
> -int mls_sid_to_context(context_struct_t * context,
> +int mls_sid_to_context(policydb_t *policydb,
> +                      context_struct_t * context,

[...]

> 	Unfortunately, this has not been accompanied with an soname
>  change, this can't be a good thing.  I would suggest bumping up the
>  soname to match the version (libsepol.so.1.2), to minimize confusion.

I don't think anyone has actually been using these functions up until
now.  Neither Debian or Fedora enabled MLS, and I don't think Gentoo did
either.  So it's probably safe to continue using the existing soname;
but we should certainly be careful about this in the future.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
