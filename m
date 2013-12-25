MIME-Version: 1.0
In-Reply-To: <52B84CDF.7020508@redhat.com>
References: <CAJfZ7=myQGgMdJ3NWZHUPvSTpOA-mfJUFLGQLvVdCz7a3N5evQ@mail.gmail.com>
 <CAPJdAQBu3=ZyEqUqn_eq4HagfGZZP3-9u_Taimozkkt4EjGfZg@mail.gmail.com>
 <CAJfZ7=m0BoejRQsbTU+5+YLyid8tb1r9tTzeQSR7ZJS1ZmkFsQ@mail.gmail.com>
 <52B84CDF.7020508@redhat.com>
Date: Wed, 25 Dec 2013 15:36:21 +0100
Message-ID: <CAJfZ7=mZCdh7_Mh9kng-pOHx3RAJ6Qn2W5VvmoVVJy7tUMRtag@mail.gmail.com>
Subject: Re: Bug in libselinux/src/setrans_client.c
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: Daniel J Walsh <dwalsh@redhat.com>, selinux <Selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2013/12/23 Daniel J Walsh wrote:
>
> On 12/21/2013 09:27 AM, Nicolas Iooss wrote:
> > My first message was not so clear. The check in
> > libselinux/src/lsetfilecon.c line 35 [1] doesn't work because
> > selinux_trans_to_raw_context(context, &rcontext) returns 0 and sets
> > rcontext to NULL. This is why I'm asking to change the return value to
> > something else if you want "cp -a" working. This fix is not to introduce a
> > new feature but to fix an existing one.
> >
> > Nicolas
> >
>
> How about if we add a check on lsetfilecon_raw?  Changing the behaviour on
> selinux_trans_to_raw_context might cause other problems.

I agree. I've found
http://selinuxproject.org/page/LibselinuxAPISummary which says
precisely for selinux_trans_to_raw_context: "If passed NULL, sets the
returned context to NULL and returns 0." As this feature is
documented, callers may rely on it and changing this behavior is
likely to break things.

Moreover setfilecon_raw and fsetfilecon_raw have the same NULL-pointer
dereference issue. Do these functions need a patch too?

By the way, other callers of selinux_trans_to_raw_context may also
share this bug: avc_context_to_sid, security_canonicalize_context,
security_check_context, etc. Is doing a segmentation fault the
expected way to tell the caller it used a NULL pointer and should have
manually checked every parameter before calling any libselinux
function?

Thanks and merry Christmas!

Nicolas

>
>
> diff --git a/libselinux/src/lsetfilecon.c b/libselinux/src/lsetfilecon.c
> index 461e3f7..af3775e 100644
> - --- a/libselinux/src/lsetfilecon.c
> +++ b/libselinux/src/lsetfilecon.c
> @@ -9,6 +9,10 @@
>
>  int lsetfilecon_raw(const char *path, const security_context_t context)
>  {
> +       if (! context) {
> +               errno=EINVAL;
> +               return -1;
> +       }
>         return lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1
>                          0);
>  }
