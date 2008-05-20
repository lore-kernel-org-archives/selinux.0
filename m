Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4KEoYVA005492
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2008 10:50:34 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4KEoX9D024777
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2008 14:50:33 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id m4KEm3wf024949
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2008 10:48:03 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id m4KEm3KG024948
	for selinux@tycho.nsa.gov; Tue, 20 May 2008 10:48:03 -0400
Subject: Re: should GNU install call matchpathcon by default?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: SE Linux <selinux@tycho.nsa.gov>, bug-coreutils@gnu.org
In-Reply-To: <87mytjy51a.fsf@rho.meyering.net>
References: <87k5ou9trs.fsf@rho.meyering.net>
	 <87fxzh7kww.fsf@rho.meyering.net>  <87mytjy51a.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Tue, 20 May 2008 10:37:30 -0400
Message-Id: <1211294250.7486.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2007-11-12 at 14:20 +0100, Jim Meyering wrote:
> Jim Meyering <jim@meyering.net> wrote:
> > Jim Meyering <jim@meyering.net> wrote:
> >> This morning I noticed a flagrant difference in the speed of
> >> "make install" for the just-released gettext-0.17.  It took 12(!)
> >> times longer on a rawhide system than on a usually-slower debian
> >> unstable system. (3min vs. 15s)
> >
> > FYI,
> >
> > Dan Walsh suggested to use
> > matchpathcon_init_prefix (NULL, "/first_component_of_abs_dest/");
> > to limit the number of regular expressions matchpathcon will have to
> > compile.  That works very well, as long as you're not installing into
> > /usr, in which case it's still better than nothing.  When installing
> > into /tmp, the example above takes 21-22 seconds, rather than 180.
> > Much better.  However, installing into /usr/tmp still required about 70
> > seconds, so there's room for improvement.
> 
> I've implemented it like this:
> 
> 	install+SELinux: reduce a 12x performance hit to ~1.5x
> 	* src/install.c (setdefaultfilecon): Call matchpathcon_init_prefix,
> 	to mitigate what would otherwise be a large performance hit due to
> 	the use of matchpathcon.
> 	Dan Walsh suggested the use of matchpathcon_init_prefix.
> 	* gl/lib/se-selinux.in.h (matchpathcon_init_prefix): Define.
> 
> ---
>  gl/lib/se-selinux.in.h |    3 +++
>  src/install.c          |   32 ++++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 0 deletions(-)
> 
> diff --git a/gl/lib/se-selinux.in.h b/gl/lib/se-selinux.in.h
> index 7bfe4c5..7be1e70 100644
> --- a/gl/lib/se-selinux.in.h
> +++ b/gl/lib/se-selinux.in.h
> @@ -51,4 +51,7 @@ static inline int security_compute_create (security_context_t scon,
>  					   security_class_t tclass,
>  					   security_context_t *newcon)
>    { errno = ENOTSUP; return -1; }
> +static inline int matchpathcon_init_prefix (char const *path,
> +					    char const *prefix)
> +  { errno = ENOTSUP; return -1; }
>  #endif
> diff --git a/src/install.c b/src/install.c
> index 34f61ff..216715f 100644
> --- a/src/install.c
> +++ b/src/install.c
> @@ -213,6 +213,38 @@ setdefaultfilecon (char const *file)
>    if (lstat (file, &st) != 0)
>      return;
> 
> +  if (IS_ABSOLUTE_FILE_NAME (file))
> +    {
> +      /* Calling matchpathcon_init_prefix (NULL, "/first_component/")
> +	 is an optimization to minimize the expense of the following
> +	 matchpathcon call.  */
> +      char const *p0;
> +      char const *p = file + 1;
> +      while (ISSLASH (*p))
> +	++p;
> +
> +      /* Record final leading slash, for when FILE starts with two or more.  */
> +      p0 = p - 1;
> +
> +      if (*p)
> +	{
> +	  char *prefix;
> +	  do
> +	    {
> +	      ++p;
> +	    }
> +	  while (*p && !ISSLASH (*p));
> +
> +	  prefix = malloc (p - p0 + 2);
> +	  if (prefix)
> +	    {
> +	      stpcpy (stpncpy (prefix, p0, p - p0), "/");
> +	      matchpathcon_init_prefix (NULL, prefix);
> +	      free (prefix);
> +	    }
> +	}
> +    }
> +
>    /* If there's an error determining the context, or it has none,
>       return to allow default context */
>    if ((matchpathcon (file, st.st_mode, &scontext) != 0) ||

This issue came up recently again, see:
https://bugzilla.redhat.com/show_bug.cgi?id=447410

It appears that the patch that was merged into coreutils ends up calling
matchpathcon_init_prefix() for each file being installed rather than
once upon startup, and without calling matchpathcon_fini() to free the
memory allocated by each matchpathcon_init_prefix() call.

That makes it slower than necessary and leaks memory.

See the bug report for the discussion.

Can we get this corrected in the upstream coreutils?  Thanks.

-- 
Stephen Smalley
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
