Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7DKjJIY002136
 for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2018 16:45:20 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so16307357itf.2
 for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2018 13:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180813194214.20929-1-hollis_blanchard@mentor.com>
In-Reply-To: <20180813194214.20929-1-hollis_blanchard@mentor.com>
From: Tom Cherry <tomcherry@google.com>
Date: Mon, 13 Aug 2018 13:45:02 -0700
Message-ID: <CAPc65ax7Dz_niNOxypfds2hLCdiP=x8C2_KFWShVpBnWP62fFg@mail.gmail.com>
To: hollis_blanchard@mentor.com
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] Fix build break around __atomic_*() with GCC<4.7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Aug 13, 2018 at 12:43 PM Hollis Blanchard
<hollis_blanchard@mentor.com> wrote:
>
> The __atomic_* GCC primitives were introduced in GCC 4.7, but Red Hat
> Enterprise Linux 6.x (for example) provides GCC 4.4. Tweak the current code to
> use the (most conservative) __sync_synchronize() primitive provided by those
> older GCC versions.
>
> Fixes https://github.com/SELinuxProject/selinux/issues/97
>
> (Really, no __atomic or __sync operations are needed here at all, since POSIX
> 4.12 "Memory Synchronization" says pthread_mutex_lock() and
> pthread_mutex_unlock() "synchronize memory with respect to other threads"...)

That section means that pthread_mutex_lock() and
pthread_mutex_unlock() will perform an acquire / release operation
respectively, so if you're guarding shared data with them, you don't
need additional memory synchronization.

In this case however, the fast path does not call pthread_mutex_lock()
and thus there is no acquire operation.  pthread_mutex_unlock() will
perform a release operation in the thread that actually compiled the
regex (so technically, we don't actually need the __atomic_store_n),
but we still need an acquire operation on the fast path, which is why
we need the atomic.

It's a common pattern,
https://en.wikipedia.org/wiki/Double-checked_locking, and always uses
atomics.

The rest of the change looks fine to me though.

Tom

Tom

>
> ---
>  libselinux/src/label_file.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 2fa85474..47859baf 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -351,8 +351,14 @@ static inline int compile_regex(struct saved_data *data, struct spec *spec,
>          * init_routine does not take a parameter, it's not possible
>          * to use, so we generate the same effect with atomics and a
>          * mutex */
> +#ifdef __ATOMIC_RELAXED
>         regex_compiled =
>                 __atomic_load_n(&spec->regex_compiled, __ATOMIC_ACQUIRE);
> +#else
> +       /* GCC <4.7 */
> +       __sync_synchronize();
> +       regex_compiled = spec->regex_compiled;
> +#endif
>         if (regex_compiled) {
>                 return 0; /* already done */
>         }
> @@ -360,8 +366,14 @@ static inline int compile_regex(struct saved_data *data, struct spec *spec,
>         __pthread_mutex_lock(&spec->regex_lock);
>         /* Check if another thread compiled the regex while we waited
>          * on the mutex */
> +#ifdef __ATOMIC_RELAXED
>         regex_compiled =
>                 __atomic_load_n(&spec->regex_compiled, __ATOMIC_ACQUIRE);
> +#else
> +       /* GCC <4.7 */
> +       __sync_synchronize();
> +       regex_compiled = spec->regex_compiled;
> +#endif
>         if (regex_compiled) {
>                 __pthread_mutex_unlock(&spec->regex_lock);
>                 return 0;
> @@ -404,7 +416,13 @@ static inline int compile_regex(struct saved_data *data, struct spec *spec,
>         }
>
>         /* Done. */
> +#ifdef __ATOMIC_RELAXED
>         __atomic_store_n(&spec->regex_compiled, true, __ATOMIC_RELEASE);
> +#else
> +       /* GCC <4.7 */
> +       spec->regex_compiled = true;
> +       __sync_synchronize();
> +#endif
>         __pthread_mutex_unlock(&spec->regex_lock);
>         return 0;
>  }
> --
> 2.13.0
>
