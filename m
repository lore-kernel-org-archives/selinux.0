Date: Sat, 29 Aug 2015 19:02:16 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, eparis@redhat.com
Subject: Re: [PATCH] libselinux: simplify procattr cache
Message-ID: <20150829170214.GA15275@x250>
References: <1437412266-6462-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <1437412266-6462-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Mon, Jul 20, 2015 at 01:11:06PM -0400, Stephen Smalley wrote:
> https://github.com/systemd/systemd/issues/475 identified a problem
> in libselinux with using getpid(3) rather than getpid(2) due to direct
> use of the clone() system call by systemd.  We could change libselinux
> to use getpid(2) instead, but this would impose a getpid(2) system call
> overhead on each get*con() or set*con() call.  Rather than do this,
> we can instead simplify the procattr cache and get rid of the
> caching of the pid and tid entirely, along with the atfork handler.
> With commit 3430519109c0423a49b9350aa8444beec798d5a7 ("use
> /proc/thread-self when available"), we only need the tid when
> on Linux < 3.17, so we can just always call gettid() in that case (as
> done prior to the procattr cache) and drop the cached tid. The cached
> pid and atfork handlers were only needed to reset the cached tid, so
> those can also be dropped. The rest of the cached attributes are not
> reset by the kernel on fork, only on exec, so we do not need to
> flush them upon fork/clone.

Today i tried out these two patches (I basically updated the procattr.c
in Fedoras' libselinux myself because It took them too long) However, this seems to not
fix the systemd-nspawn issue for me (at least not by itself). I do not know whether that is due to
libselinux or to systemd-nspawn, but the error message is still exactly
the same.

> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  libselinux/src/procattr.c | 34 +++-------------------------------
>  1 file changed, 3 insertions(+), 31 deletions(-)
> 
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index e444571..527a0a5 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -11,8 +11,6 @@
>  
>  #define UNSET (char *) -1
>  
> -static __thread pid_t cpid;
> -static __thread pid_t tid;
>  static __thread char *prev_current = UNSET;
>  static __thread char * prev_exec = UNSET;
>  static __thread char * prev_fscreate = UNSET;
> @@ -24,15 +22,6 @@ static pthread_key_t destructor_key;
>  static int destructor_key_initialized = 0;
>  static __thread char destructor_initialized;
>  
> -extern void *__dso_handle __attribute__ ((__weak__, __visibility__ ("hidden")));
> -extern int __register_atfork (void (*) (void), void (*) (void), void (*) (void), void *);
> -
> -static int __selinux_atfork (void (*prepare) (void), void (*parent) (void), void (*child) (void))
> -{
> -  return __register_atfork (prepare, parent, child,
> -                            &__dso_handle == NULL ? NULL : __dso_handle);
> -}
> -
>  static pid_t gettid(void)
>  {
>  	return syscall(__NR_gettid);
> @@ -52,14 +41,6 @@ static void procattr_thread_destructor(void __attribute__((unused)) *unused)
>  		free(prev_sockcreate);
>  }
>  
> -static void free_procattr(void)
> -{
> -	procattr_thread_destructor(NULL);
> -	tid = 0;
> -	cpid = getpid();
> -	prev_current = prev_exec = prev_fscreate = prev_keycreate = prev_sockcreate = UNSET;
> -}
> -
>  void __attribute__((destructor)) procattr_destructor(void);
>  
>  void hidden __attribute__((destructor)) procattr_destructor(void)
> @@ -79,7 +60,6 @@ static inline void init_thread_destructor(void)
>  static void init_procattr(void)
>  {
>  	if (__selinux_key_create(&destructor_key, procattr_thread_destructor) == 0) {
> -		__selinux_atfork(NULL, NULL, free_procattr);
>  		destructor_key_initialized = 1;
>  	}
>  }
> @@ -88,9 +68,7 @@ static int openattr(pid_t pid, const char *attr, int flags)
>  {
>  	int fd, rc;
>  	char *path;
> -
> -	if (cpid != getpid())
> -		free_procattr();
> +	pid_t tid;
>  
>  	if (pid > 0)
>  		rc = asprintf(&path, "/proc/%d/attr/%s", pid, attr);
> @@ -101,8 +79,8 @@ static int openattr(pid_t pid, const char *attr, int flags)
>  		fd = open(path, flags | O_CLOEXEC);
>  		if (fd >= 0 || errno != ENOENT)
>  			goto out;
> -		if (!tid)
> -			tid = gettid();
> +		free(path);
> +		tid = gettid();
>  		rc = asprintf(&path, "/proc/self/task/%d/attr/%s", tid, attr);
>  	}
>  	if (rc < 0)
> @@ -127,9 +105,6 @@ static int getprocattrcon_raw(char ** context,
>  	__selinux_once(once, init_procattr);
>  	init_thread_destructor();
>  
> -	if (cpid != getpid())
> -		free_procattr();
> -
>  	switch (attr[0]) {
>  		case 'c':
>  			prev_context = prev_current;
> @@ -227,9 +202,6 @@ static int setprocattrcon_raw(const char * context,
>  	__selinux_once(once, init_procattr);
>  	init_thread_destructor();
>  
> -	if (cpid != getpid())
> -		free_procattr();
> -
>  	switch (attr[0]) {
>  		case 'c':
>  			prev_context = &prev_current;
> -- 
> 2.1.0
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV4eWSAAoJENAR6kfG5xmc6EgL/02rifa4do5K4z1dQfloq7T6
mPG7DUBOkwiE1K6GA7qBQ13yKdgKmYwBoisKITy15FlACyWyVJfx2YkcTojdq0OD
Gl4kzcR57USk6DmJ1d3EAcxUjFrcZLqlhSrXexyq/uF4XRikBjGRyq1TP9fuIMLI
IcZ9eNLHQdGOj2mxMgwnvv4B15d19VhzzLbBJJJnsaUw+4yiM+LSK2fqAQxs9ERr
FA3Phv/ZkJzk2bWvU3EShVwzm70HXkkHgqoVu/EEbncEaLOr2ACu3sU/lAv7hEcZ
lWFM5WRy0RG0SAI2vQgKMWoUPuioLNFFDo7iQRINh2Z03O2pHfEe+jTpbuo3Ecoy
vOcq2410dXDZf2K/f7YMZkLl5mtcGl4fjAnIPUI1wqJr99M7Hs9BI0PeyGKLMKkY
m2b+XMnAvZx4T3FvQ6jZ1W+egwgVOX3feD9r2BRNjeqplNzmyTxHH8FhNmgC2Nev
j/Z1i5UjpUhLejN9Mfun/+pSKFL8pk/uC8sr91cJpA==
=CBla
-----END PGP SIGNATURE-----
