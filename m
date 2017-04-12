Message-ID: <1492023263.3881.26.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: add O_CLOEXEC
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nick Kralevich <nnk@google.com>, selinux@tycho.nsa.gov
Date: Wed, 12 Apr 2017 14:54:23 -0400
In-Reply-To: <1481477416-93493-1-git-send-email-nnk@google.com>
References: <1481477416-93493-1-git-send-email-nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, 2016-12-11 at 09:30 -0800, Nick Kralevich wrote:
> Makes libselinux safer and less likely to leak file descriptors when
> used as part of a multithreaded program.

Thanks, applied.  This one got deferred on the discussion around MacOS
support and implications for meta-selinux, and I lost track of it.

> 
> Signed-off-by: Nick Kralevich <nnk@google.com>
> ---
>  libselinux/src/audit2why.c                       |  4 ++--
>  libselinux/src/booleans.c                        | 14 +++++++-------
>  libselinux/src/canonicalize_context.c            |  2 +-
>  libselinux/src/check_context.c                   |  2 +-
>  libselinux/src/compute_av.c                      |  2 +-
>  libselinux/src/compute_create.c                  |  2 +-
>  libselinux/src/compute_member.c                  |  2 +-
>  libselinux/src/compute_relabel.c                 |  2 +-
>  libselinux/src/compute_user.c                    |  2 +-
>  libselinux/src/deny_unknown.c                    |  2 +-
>  libselinux/src/disable.c                         |  2 +-
>  libselinux/src/enabled.c                         |  2 +-
>  libselinux/src/get_context_list.c                |  6 +++---
>  libselinux/src/get_default_type.c                |  2 +-
>  libselinux/src/get_initial_context.c             |  2 +-
>  libselinux/src/getenforce.c                      |  2 +-
>  libselinux/src/init.c                            |  4 ++--
>  libselinux/src/is_customizable_type.c            |  2 +-
>  libselinux/src/label.c                           |  2 +-
>  libselinux/src/label_backends_android.c          |  2 +-
>  libselinux/src/label_file.c                      |  2 +-
>  libselinux/src/label_media.c                     |  2 +-
>  libselinux/src/label_x.c                         |  2 +-
>  libselinux/src/load_policy.c                     |  8 ++++----
>  libselinux/src/matchmediacon.c                   |  2 +-
>  libselinux/src/policyvers.c                      |  2 +-
>  libselinux/src/procattr.c                        |  4 ++--
>  libselinux/src/selinux_check_securetty_context.c |  2 +-
>  libselinux/src/selinux_config.c                  |  4 ++--
>  libselinux/src/selinux_restorecon.c              |  2 +-
>  libselinux/src/setenforce.c                      |  2 +-
>  libselinux/src/seusers.c                         |  4 ++--
>  libselinux/src/stringrep.c                       |  2 +-
>  33 files changed, 49 insertions(+), 49 deletions(-)
> 
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index 3135eed..857383a 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -201,7 +201,7 @@ static int __policy_init(const char *init_path)
>  	path[PATH_MAX-1] = '\0';
>  	if (init_path) {
>  		strncpy(path, init_path, PATH_MAX-1);
> -		fp = fopen(path, "r");
> +		fp = fopen(path, "re");
>  		if (!fp) {
>  			snprintf(errormsg, sizeof(errormsg), 
>  				 "unable to open %s:  %s\n",
> @@ -218,7 +218,7 @@ static int __policy_init(const char *init_path)
>  			PyErr_SetString( PyExc_ValueError,
> errormsg);
>  			return 1;
>  		}
> -		fp = fopen(curpolicy, "r");
> +		fp = fopen(curpolicy, "re");
>  		if (!fp) {
>  			snprintf(errormsg, sizeof(errormsg), 
>  				 "unable to open %s:  %s\n",
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index ba9d934..4a38a78 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -97,7 +97,7 @@ char *selinux_boolean_sub(const char *name)
>  	if (!name)
>  		return NULL;
>  
> -	cfg = fopen(selinux_booleans_subs_path(), "r");
> +	cfg = fopen(selinux_booleans_subs_path(), "re");
>  	if (!cfg)
>  		goto out;
>  
> @@ -210,7 +210,7 @@ static int get_bool_value(const char *name, char
> **buf)
>  
>  	(*buf)[STRBUF_SIZE] = 0;
>  
> -	fd = bool_open(name, O_RDONLY);
> +	fd = bool_open(name, O_RDONLY | O_CLOEXEC);
>  	if (fd < 0)
>  		goto out_err;
>  
> @@ -274,7 +274,7 @@ int security_set_boolean(const char *name, int
> value)
>  		return -1;
>  	}
>  
> -	fd = bool_open(name, O_WRONLY);
> +	fd = bool_open(name, O_WRONLY | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> @@ -305,7 +305,7 @@ int security_commit_booleans(void)
>  	}
>  
>  	snprintf(path, sizeof path, "%s/commit_pending_bools",
> selinux_mnt);
> -	fd = open(path, O_WRONLY);
> +	fd = open(path, O_WRONLY | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> @@ -399,7 +399,7 @@ static int save_booleans(size_t boolcnt,
> SELboolean * boollist)
>  
>  	snprintf(local_bool_file, sizeof(local_bool_file),
> "%s.local",
>  		 bool_file);
> -	boolf = fopen(local_bool_file, "r");
> +	boolf = fopen(local_bool_file, "re");
>  	if (boolf != NULL) {
>  		ssize_t ret;
>  		size_t size = 0;
> @@ -518,7 +518,7 @@ int security_load_booleans(char *path)
>  	int val;
>  	char name[BUFSIZ];
>  
> -	boolf = fopen(path ? path : selinux_booleans_path(), "r");
> +	boolf = fopen(path ? path : selinux_booleans_path(), "re");
>  	if (boolf == NULL)
>  		goto localbool;
>  
> @@ -536,7 +536,7 @@ int security_load_booleans(char *path)
>        localbool:
>  	snprintf(localbools, sizeof(localbools), "%s.local",
>  		 (path ? path : selinux_booleans_path()));
> -	boolf = fopen(localbools, "r");
> +	boolf = fopen(localbools, "re");
>  
>  	if (boolf != NULL) {
>  		int ret;
> diff --git a/libselinux/src/canonicalize_context.c
> b/libselinux/src/canonicalize_context.c
> index 7cf3139..ba4c9a2 100644
> --- a/libselinux/src/canonicalize_context.c
> +++ b/libselinux/src/canonicalize_context.c
> @@ -23,7 +23,7 @@ int security_canonicalize_context_raw(const char *
> con,
>  	}
>  
>  	snprintf(path, sizeof path, "%s/context", selinux_mnt);
> -	fd = open(path, O_RDWR);
> +	fd = open(path, O_RDWR | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/libselinux/src/check_context.c
> b/libselinux/src/check_context.c
> index 52063fa..8a7997f 100644
> --- a/libselinux/src/check_context.c
> +++ b/libselinux/src/check_context.c
> @@ -20,7 +20,7 @@ int security_check_context_raw(const char * con)
>  	}
>  
>  	snprintf(path, sizeof path, "%s/context", selinux_mnt);
> -	fd = open(path, O_RDWR);
> +	fd = open(path, O_RDWR | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/libselinux/src/compute_av.c
> b/libselinux/src/compute_av.c
> index 937e5c3..1d05e7b 100644
> --- a/libselinux/src/compute_av.c
> +++ b/libselinux/src/compute_av.c
> @@ -27,7 +27,7 @@ int security_compute_av_flags_raw(const char *
> scon,
>  	}
>  
>  	snprintf(path, sizeof path, "%s/access", selinux_mnt);
> -	fd = open(path, O_RDWR);
> +	fd = open(path, O_RDWR | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/libselinux/src/compute_create.c
> b/libselinux/src/compute_create.c
> index 9559d42..0975aea 100644
> --- a/libselinux/src/compute_create.c
> +++ b/libselinux/src/compute_create.c
> @@ -65,7 +65,7 @@ int security_compute_create_name_raw(const char *
> scon,
>  	}
>  
>  	snprintf(path, sizeof path, "%s/create", selinux_mnt);
> -	fd = open(path, O_RDWR);
> +	fd = open(path, O_RDWR | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/libselinux/src/compute_member.c
> b/libselinux/src/compute_member.c
> index 1fc7e41..4e2d221 100644
> --- a/libselinux/src/compute_member.c
> +++ b/libselinux/src/compute_member.c
> @@ -26,7 +26,7 @@ int security_compute_member_raw(const char * scon,
>  	}
>  
>  	snprintf(path, sizeof path, "%s/member", selinux_mnt);
> -	fd = open(path, O_RDWR);
> +	fd = open(path, O_RDWR | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/libselinux/src/compute_relabel.c
> b/libselinux/src/compute_relabel.c
> index 4615aee..49f77ef 100644
> --- a/libselinux/src/compute_relabel.c
> +++ b/libselinux/src/compute_relabel.c
> @@ -26,7 +26,7 @@ int security_compute_relabel_raw(const char * scon,
>  	}
>  
>  	snprintf(path, sizeof path, "%s/relabel", selinux_mnt);
> -	fd = open(path, O_RDWR);
> +	fd = open(path, O_RDWR | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/libselinux/src/compute_user.c
> b/libselinux/src/compute_user.c
> index b37c5d3..7b88121 100644
> --- a/libselinux/src/compute_user.c
> +++ b/libselinux/src/compute_user.c
> @@ -25,7 +25,7 @@ int security_compute_user_raw(const char * scon,
>  	}
>  
>  	snprintf(path, sizeof path, "%s/user", selinux_mnt);
> -	fd = open(path, O_RDWR);
> +	fd = open(path, O_RDWR | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/libselinux/src/deny_unknown.c
> b/libselinux/src/deny_unknown.c
> index c93998a..77d04e3 100644
> --- a/libselinux/src/deny_unknown.c
> +++ b/libselinux/src/deny_unknown.c
> @@ -21,7 +21,7 @@ int security_deny_unknown(void)
>  	}
>  
>  	snprintf(path, sizeof(path), "%s/deny_unknown",
> selinux_mnt);
> -	fd = open(path, O_RDONLY);
> +	fd = open(path, O_RDONLY | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/libselinux/src/disable.c b/libselinux/src/disable.c
> index dac0f5b..8d66262 100644
> --- a/libselinux/src/disable.c
> +++ b/libselinux/src/disable.c
> @@ -21,7 +21,7 @@ int security_disable(void)
>  	}
>  
>  	snprintf(path, sizeof path, "%s/disable", selinux_mnt);
> -	fd = open(path, O_WRONLY);
> +	fd = open(path, O_WRONLY | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/libselinux/src/enabled.c b/libselinux/src/enabled.c
> index 2ec6797..dd628fb 100644
> --- a/libselinux/src/enabled.c
> +++ b/libselinux/src/enabled.c
> @@ -36,7 +36,7 @@ int is_selinux_mls_enabled(void)
>  		return enabled;
>  
>  	snprintf(path, sizeof path, "%s/mls", selinux_mnt);
> -	fd = open(path, O_RDONLY);
> +	fd = open(path, O_RDONLY | O_CLOEXEC);
>  	if (fd < 0)
>  		return enabled;
>  
> diff --git a/libselinux/src/get_context_list.c
> b/libselinux/src/get_context_list.c
> index f3fa4a9..689e465 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -275,7 +275,7 @@ static int get_failsafe_context(const char *user,
> char ** newcon)
>  	size_t plen, nlen;
>  	int rc;
>  
> -	fp = fopen(selinux_failsafe_context_path(), "r");
> +	fp = fopen(selinux_failsafe_context_path(), "re");
>  	if (!fp)
>  		return -1;
>  
> @@ -437,7 +437,7 @@ int get_ordered_context_list(const char *user,
>  	if (!fname)
>  		goto failsafe;
>  	snprintf(fname, fname_len, "%s%s", user_contexts_path,
> user);
> -	fp = fopen(fname, "r");
> +	fp = fopen(fname, "re");
>  	if (fp) {
>  		__fsetlocking(fp, FSETLOCKING_BYCALLER);
>  		rc = get_context_order(fp, fromcon, reachable,
> nreach, ordering,
> @@ -451,7 +451,7 @@ int get_ordered_context_list(const char *user,
>  		}
>  	}
>  	free(fname);
> -	fp = fopen(selinux_default_context_path(), "r");
> +	fp = fopen(selinux_default_context_path(), "re");
>  	if (fp) {
>  		__fsetlocking(fp, FSETLOCKING_BYCALLER);
>  		rc = get_context_order(fp, fromcon, reachable,
> nreach, ordering,
> diff --git a/libselinux/src/get_default_type.c
> b/libselinux/src/get_default_type.c
> index 27f2ae5..dd7b5d7 100644
> --- a/libselinux/src/get_default_type.c
> +++ b/libselinux/src/get_default_type.c
> @@ -11,7 +11,7 @@ int get_default_type(const char *role, char **type)
>  {
>  	FILE *fp = NULL;
>  
> -	fp = fopen(selinux_default_type_path(), "r");
> +	fp = fopen(selinux_default_type_path(), "re");
>  	if (!fp)
>  		return -1;
>  
> diff --git a/libselinux/src/get_initial_context.c
> b/libselinux/src/get_initial_context.c
> index 522ed78..5e919f4 100644
> --- a/libselinux/src/get_initial_context.c
> +++ b/libselinux/src/get_initial_context.c
> @@ -25,7 +25,7 @@ int security_get_initial_context_raw(const char *
> name, char ** con)
>  
>  	snprintf(path, sizeof path, "%s%s%s", 
>  		 selinux_mnt, SELINUX_INITCON_DIR, name);
> -	fd = open(path, O_RDONLY);
> +	fd = open(path, O_RDONLY | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/libselinux/src/getenforce.c
> b/libselinux/src/getenforce.c
> index 03d3abc..d909dce 100644
> --- a/libselinux/src/getenforce.c
> +++ b/libselinux/src/getenforce.c
> @@ -21,7 +21,7 @@ int security_getenforce(void)
>  	}
>  
>  	snprintf(path, sizeof path, "%s/enforce", selinux_mnt);
> -	fd = open(path, O_RDONLY);
> +	fd = open(path, O_RDONLY | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/libselinux/src/init.c b/libselinux/src/init.c
> index ddf91f8..2690a72 100644
> --- a/libselinux/src/init.c
> +++ b/libselinux/src/init.c
> @@ -61,7 +61,7 @@ int selinuxfs_exists(void)
>  	size_t len;
>  	ssize_t num;
>  
> -	fp = fopen("/proc/filesystems", "r");
> +	fp = fopen("/proc/filesystems", "re");
>  	if (!fp)
>  		return 1; /* Fail as if it exists */
>  	__fsetlocking(fp, FSETLOCKING_BYCALLER);
> @@ -101,7 +101,7 @@ static void init_selinuxmnt(void)
>  
>  	/* At this point, the usual spot doesn't have an selinuxfs
> so
>  	 * we look around for it */
> -	fp = fopen("/proc/mounts", "r");
> +	fp = fopen("/proc/mounts", "re");
>  	if (!fp)
>  		goto out;
>  
> diff --git a/libselinux/src/is_customizable_type.c
> b/libselinux/src/is_customizable_type.c
> index 0b33edc..92876f4 100644
> --- a/libselinux/src/is_customizable_type.c
> +++ b/libselinux/src/is_customizable_type.c
> @@ -16,7 +16,7 @@ static int get_customizable_type_list(char ***
> retlist)
>  	unsigned int ctr = 0, i;
>  	char **list = NULL;
>  
> -	fp = fopen(selinux_customizable_types_path(), "r");
> +	fp = fopen(selinux_customizable_types_path(), "re");
>  	if (!fp)
>  		return -1;
>  
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 60639cf..5c9d8c1 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -96,7 +96,7 @@ struct selabel_sub *selabel_subs_init(const char
> *path,
>  					    struct selabel_digest
> *digest)
>  {
>  	char buf[1024];
> -	FILE *cfg = fopen(path, "r");
> +	FILE *cfg = fopen(path, "re");
>  	struct selabel_sub *sub = NULL;
>  	struct stat sb;
>  
> diff --git a/libselinux/src/label_backends_android.c
> b/libselinux/src/label_backends_android.c
> index 4d6ec86..4ad71f9 100644
> --- a/libselinux/src/label_backends_android.c
> +++ b/libselinux/src/label_backends_android.c
> @@ -159,7 +159,7 @@ static int init(struct selabel_handle *rec, const
> struct selinux_opt *opts,
>  		return -1;
>  
>  	/* Open the specification file. */
> -	if ((fp = fopen(path, "r")) == NULL)
> +	if ((fp = fopen(path, "re")) == NULL)
>  		return -1;
>  
>  	if (fstat(fileno(fp), &sb) < 0)
> diff --git a/libselinux/src/label_file.c
> b/libselinux/src/label_file.c
> index a4dc3cd..0d4029b 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -520,7 +520,7 @@ static FILE *open_file(const char *path, const
> char *suffix,
>  	}
>  
>  	memcpy(sb, &found->sb, sizeof(*sb));
> -	return fopen(save_path, "r");
> +	return fopen(save_path, "re");
>  }
>  
>  static int process_file(const char *path, const char *suffix,
> diff --git a/libselinux/src/label_media.c
> b/libselinux/src/label_media.c
> index 622741b..d202e5d 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -90,7 +90,7 @@ static int init(struct selabel_handle *rec, const
> struct selinux_opt *opts,
>  	/* Open the specification file. */
>  	if (!path)
>  		path = selinux_media_context_path();
> -	if ((fp = fopen(path, "r")) == NULL)
> +	if ((fp = fopen(path, "re")) == NULL)
>  		return -1;
>  	__fsetlocking(fp, FSETLOCKING_BYCALLER);
>  
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index 700def1..9674529 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -117,7 +117,7 @@ static int init(struct selabel_handle *rec, const
> struct selinux_opt *opts,
>  	/* Open the specification file. */
>  	if (!path)
>  		path = selinux_x_context_path();
> -	if ((fp = fopen(path, "r")) == NULL)
> +	if ((fp = fopen(path, "re")) == NULL)
>  		return -1;
>  	__fsetlocking(fp, FSETLOCKING_BYCALLER);
>  
> diff --git a/libselinux/src/load_policy.c
> b/libselinux/src/load_policy.c
> index b7e1a6f..327cc6a 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -34,7 +34,7 @@ int security_load_policy(void *data, size_t len)
>  	}
>  
>  	snprintf(path, sizeof path, "%s/load", selinux_mnt);
> -	fd = open(path, O_RDWR);
> +	fd = open(path, O_RDWR | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> @@ -173,13 +173,13 @@ checkbool:
>        search:
>  	snprintf(path, sizeof(path), "%s.%d",
>  		 selinux_binary_policy_path(), vers);
> -	fd = open(path, O_RDONLY);
> +	fd = open(path, O_RDONLY | O_CLOEXEC);
>  	while (fd < 0 && errno == ENOENT
>  	       && --vers >= minvers) {
>  		/* Check prior versions to see if old policy is
> available */
>  		snprintf(path, sizeof(path), "%s.%d",
>  			 selinux_binary_policy_path(), vers);
> -		fd = open(path, O_RDONLY);
> +		fd = open(path, O_RDONLY | O_CLOEXEC);
>  	}
>  	if (fd < 0) {
>  		fprintf(stderr,
> @@ -335,7 +335,7 @@ int selinux_init_load_policy(int *enforce)
>  
>  	/* Check for an override of the mode via the kernel command
> line. */
>  	rc = mount("proc", "/proc", "proc", 0, 0);
> -	cfg = fopen("/proc/cmdline", "r");
> +	cfg = fopen("/proc/cmdline", "re");
>  	if (cfg) {
>  		char *tmp;
>  		buf = malloc(selinux_page_size);
> diff --git a/libselinux/src/matchmediacon.c
> b/libselinux/src/matchmediacon.c
> index 46cba46..23d01af 100644
> --- a/libselinux/src/matchmediacon.c
> +++ b/libselinux/src/matchmediacon.c
> @@ -18,7 +18,7 @@ int matchmediacon(const char *media, char ** con)
>  	char *ptr, *ptr2 = NULL;
>  	int found = 0;
>  	char current_line[PATH_MAX];
> -	if ((infile = fopen(path, "r")) == NULL)
> +	if ((infile = fopen(path, "re")) == NULL)
>  		return -1;
>  	while (!feof_unlocked(infile)) {
>  		if (!fgets_unlocked(current_line,
> sizeof(current_line), infile)) {
> diff --git a/libselinux/src/policyvers.c
> b/libselinux/src/policyvers.c
> index 284a7f7..c97dd9d 100644
> --- a/libselinux/src/policyvers.c
> +++ b/libselinux/src/policyvers.c
> @@ -23,7 +23,7 @@ int security_policyvers(void)
>  	}
>  
>  	snprintf(path, sizeof path, "%s/policyvers", selinux_mnt);
> -	fd = open(path, O_RDONLY);
> +	fd = open(path, O_RDONLY | O_CLOEXEC);
>  	if (fd < 0) {
>  		if (errno == ENOENT)
>  			return vers;
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index 8cd59af..ebc0ade 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -143,7 +143,7 @@ static int getprocattrcon_raw(char ** context,
>  		return 0;
>  	}
>  
> -	fd = openattr(pid, attr, O_RDONLY);
> +	fd = openattr(pid, attr, O_RDONLY | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> @@ -235,7 +235,7 @@ static int setprocattrcon_raw(const char *
> context,
>  	    && !strcmp(context, *prev_context))
>  		return 0;
>  
> -	fd = openattr(pid, attr, O_RDWR);
> +	fd = openattr(pid, attr, O_RDWR | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  	if (context) {
> diff --git a/libselinux/src/selinux_check_securetty_context.c
> b/libselinux/src/selinux_check_securetty_context.c
> index 24e5e2c..55d4e03 100644
> --- a/libselinux/src/selinux_check_securetty_context.c
> +++ b/libselinux/src/selinux_check_securetty_context.c
> @@ -14,7 +14,7 @@ int selinux_check_securetty_context(const char *
> tty_context)
>  	ssize_t len;
>  	int found = -1;
>  	FILE *fp;
> -	fp = fopen(selinux_securetty_types_path(), "r");
> +	fp = fopen(selinux_securetty_types_path(), "re");
>  	if (fp) {
>  		context_t con = context_new(tty_context);
>  		if (con) {
> diff --git a/libselinux/src/selinux_config.c
> b/libselinux/src/selinux_config.c
> index 88bcc85..d8e140c 100644
> --- a/libselinux/src/selinux_config.c
> +++ b/libselinux/src/selinux_config.c
> @@ -88,7 +88,7 @@ static const uint16_t file_path_suffixes_idx[NEL] =
> {
>  int selinux_getenforcemode(int *enforce)
>  {
>  	int ret = -1;
> -	FILE *cfg = fopen(SELINUXCONFIG, "r");
> +	FILE *cfg = fopen(SELINUXCONFIG, "re");
>  	if (cfg) {
>  		char *buf;
>  		int len = sizeof(SELINUXTAG) - 1;
> @@ -163,7 +163,7 @@ static void init_selinux_config(void)
>  	if (selinux_policyroot)
>  		return;
>  
> -	fp = fopen(SELINUXCONFIG, "r");
> +	fp = fopen(SELINUXCONFIG, "re");
>  	if (fp) {
>  		__fsetlocking(fp, FSETLOCKING_BYCALLER);
>  		while ((len = getline(&line_buf, &line_len, fp)) >
> 0) {
> diff --git a/libselinux/src/selinux_restorecon.c
> b/libselinux/src/selinux_restorecon.c
> index e38d1d0..7ebfbdc 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -247,7 +247,7 @@ static int exclude_non_seclabel_mounts(void)
>  	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") <
> 0)
>  		return 0;
>  
> -	fp = fopen("/proc/mounts", "r");
> +	fp = fopen("/proc/mounts", "re");
>  	if (!fp)
>  		return 0;
>  
> diff --git a/libselinux/src/setenforce.c
> b/libselinux/src/setenforce.c
> index e5e7612..09cad3c 100644
> --- a/libselinux/src/setenforce.c
> +++ b/libselinux/src/setenforce.c
> @@ -21,7 +21,7 @@ int security_setenforce(int value)
>  	}
>  
>  	snprintf(path, sizeof path, "%s/enforce", selinux_mnt);
> -	fd = open(path, O_RDWR);
> +	fd = open(path, O_RDWR | O_CLOEXEC);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
> index 09e704b..572a7b0 100644
> --- a/libselinux/src/seusers.c
> +++ b/libselinux/src/seusers.c
> @@ -185,7 +185,7 @@ int getseuserbyname(const char *name, char
> **r_seuser, char **r_level)
>  
>  	gid_t gid = get_default_gid(name);
>  
> -	cfg = fopen(selinux_usersconf_path(), "r");
> +	cfg = fopen(selinux_usersconf_path(), "re");
>  	if (!cfg)
>  		goto nomatch;
>  
> @@ -278,7 +278,7 @@ int getseuser(const char *username, const char
> *service,
>  	FILE *fp = NULL;
>  	if (asprintf(&path,"%s/logins/%s", selinux_policy_root(),
> username) <  0)
>  		goto err;
> -	fp = fopen(path, "r");
> +	fp = fopen(path, "re");
>  	free(path);
>  	if (fp == NULL) goto err;
>  	__fsetlocking(fp, FSETLOCKING_BYCALLER);
> diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
> index 2dbec2b..2d83f96 100644
> --- a/libselinux/src/stringrep.c
> +++ b/libselinux/src/stringrep.c
> @@ -80,7 +80,7 @@ static struct discover_class_node *
> discover_class(const char *s)
>  
>  	/* load up class index */
>  	snprintf(path, sizeof path, "%s/class/%s/index",
> selinux_mnt,s);
> -	fd = open(path, O_RDONLY);
> +	fd = open(path, O_RDONLY | O_CLOEXEC);
>  	if (fd < 0)
>  		goto err3;
>  
