Message-ID: <46B7531A.5000705@redhat.com>
Date: Mon, 06 Aug 2007 12:58:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux Patch to prevent segfault from un-initialized print
 statement
References: <46B38F7B.70409@redhat.com> <46B39A27.8010307@tycho.nsa.gov>
In-Reply-To: <46B39A27.8010307@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Please use the following instead, this is a result of the new
> labeling interface having its own logging callback.  I tried to use
> the value of the function pointer to decide compatibility mode;
> this introduces a separate flag variable.
>
> How did you find this bug?  Was it from running an old setfiles
> using a new libselinux?
>
No I believe the Anaconda team found this by using some chroot 
environments.  Don't remember the exact cause.
As long as it is initialized.
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
>
> label_internal.h |    3 ++-
> matchpathcon.c   |    9 ++++-----
> 2 files changed, 6 insertions(+), 6 deletions(-)
>
>
> Index: libselinux/src/matchpathcon.c
> ===================================================================
> --- libselinux/src/matchpathcon.c    (revision 2508)
> +++ libselinux/src/matchpathcon.c    (working copy)
> @@ -65,14 +65,13 @@
> #ifdef __GNUC__
>     __attribute__ ((format(printf, 1, 2)))
> #endif
> -    (*myprintf) (const char *fmt,...);
> +    (*myprintf) (const char *fmt,...) = &default_printf;
> +int myprintf_compat = 0;
>
> void set_matchpathcon_printf(void (*f) (const char *fmt, ...))
> {
> -    if (f)
> -        myprintf = f;
> -    else
> -        myprintf = &default_printf;
> +    myprintf = f ? f : &default_printf;
> +    myprintf_compat = 1;
> }
>
> static int (*myinvalidcon) (const char *p, unsigned l, char *c) = NULL;
> Index: libselinux/src/label_internal.h
> ===================================================================
> --- libselinux/src/label_internal.h    (revision 2508)
> +++ libselinux/src/label_internal.h    (working copy)
> @@ -58,10 +58,11 @@
> /*
>  * Compatibility support
>  */
> +extern int myprintf_compat;
> extern void __attribute__ ((format(printf, 1, 2)))
> (*myprintf) (const char *fmt,...);
>
> -#define COMPAT_LOG(type, fmt...) if (myprintf)          \
> +#define COMPAT_LOG(type, fmt...) if (myprintf_compat)      \
>         myprintf(fmt);                  \
>     else                          \
>         selinux_log(type, fmt);
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
