Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBBLe6bI001336
 for <selinux@tycho.nsa.gov>; Sun, 11 Dec 2016 16:40:07 -0500
Received: by mail-oi0-f41.google.com with SMTP id v84so70498376oie.3
 for <selinux@tycho.nsa.gov>; Sun, 11 Dec 2016 13:39:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481477416-93493-1-git-send-email-nnk@google.com>
References: <1481477416-93493-1-git-send-email-nnk@google.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Sun, 11 Dec 2016 13:39:28 -0800
Message-ID: <CAFftDdqxdn=atdtzP3B+F7SX4CAtccttyZmCMDvdYSSycr3fJg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add O_CLOEXEC
To: Nick Kralevich <nnk@google.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113df3ee70f8cb054368d287
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113df3ee70f8cb054368d287
Content-Type: text/plain; charset=UTF-8

Do you know if "re" poses any Mac issues? I would assume not, but I've
never checked.

On Dec 11, 2016 09:32, "Nick Kralevich" <nnk@google.com> wrote:

Makes libselinux safer and less likely to leak file descriptors when
used as part of a multithreaded program.

Signed-off-by: Nick Kralevich <nnk@google.com>
---
 libselinux/src/audit2why.c                       |  4 ++--
 libselinux/src/booleans.c                        | 14 +++++++-------
 libselinux/src/canonicalize_context.c            |  2 +-
 libselinux/src/check_context.c                   |  2 +-
 libselinux/src/compute_av.c                      |  2 +-
 libselinux/src/compute_create.c                  |  2 +-
 libselinux/src/compute_member.c                  |  2 +-
 libselinux/src/compute_relabel.c                 |  2 +-
 libselinux/src/compute_user.c                    |  2 +-
 libselinux/src/deny_unknown.c                    |  2 +-
 libselinux/src/disable.c                         |  2 +-
 libselinux/src/enabled.c                         |  2 +-
 libselinux/src/get_context_list.c                |  6 +++---
 libselinux/src/get_default_type.c                |  2 +-
 libselinux/src/get_initial_context.c             |  2 +-
 libselinux/src/getenforce.c                      |  2 +-
 libselinux/src/init.c                            |  4 ++--
 libselinux/src/is_customizable_type.c            |  2 +-
 libselinux/src/label.c                           |  2 +-
 libselinux/src/label_backends_android.c          |  2 +-
 libselinux/src/label_file.c                      |  2 +-
 libselinux/src/label_media.c                     |  2 +-
 libselinux/src/label_x.c                         |  2 +-
 libselinux/src/load_policy.c                     |  8 ++++----
 libselinux/src/matchmediacon.c                   |  2 +-
 libselinux/src/policyvers.c                      |  2 +-
 libselinux/src/procattr.c                        |  4 ++--
 libselinux/src/selinux_check_securetty_context.c |  2 +-
 libselinux/src/selinux_config.c                  |  4 ++--
 libselinux/src/selinux_restorecon.c              |  2 +-
 libselinux/src/setenforce.c                      |  2 +-
 libselinux/src/seusers.c                         |  4 ++--
 libselinux/src/stringrep.c                       |  2 +-
 33 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 3135eed..857383a 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -201,7 +201,7 @@ static int __policy_init(const char *init_path)
        path[PATH_MAX-1] = '\0';
        if (init_path) {
                strncpy(path, init_path, PATH_MAX-1);
-               fp = fopen(path, "r");
+               fp = fopen(path, "re");
                if (!fp) {
                        snprintf(errormsg, sizeof(errormsg),
                                 "unable to open %s:  %s\n",
@@ -218,7 +218,7 @@ static int __policy_init(const char *init_path)
                        PyErr_SetString( PyExc_ValueError, errormsg);
                        return 1;
                }
-               fp = fopen(curpolicy, "r");
+               fp = fopen(curpolicy, "re");
                if (!fp) {
                        snprintf(errormsg, sizeof(errormsg),
                                 "unable to open %s:  %s\n",
diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index ba9d934..4a38a78 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -97,7 +97,7 @@ char *selinux_boolean_sub(const char *name)
        if (!name)
                return NULL;

-       cfg = fopen(selinux_booleans_subs_path(), "r");
+       cfg = fopen(selinux_booleans_subs_path(), "re");
        if (!cfg)
                goto out;

@@ -210,7 +210,7 @@ static int get_bool_value(const char *name, char **buf)

        (*buf)[STRBUF_SIZE] = 0;

-       fd = bool_open(name, O_RDONLY);
+       fd = bool_open(name, O_RDONLY | O_CLOEXEC);
        if (fd < 0)
                goto out_err;

@@ -274,7 +274,7 @@ int security_set_boolean(const char *name, int value)
                return -1;
        }

-       fd = bool_open(name, O_WRONLY);
+       fd = bool_open(name, O_WRONLY | O_CLOEXEC);
        if (fd < 0)
                return -1;

@@ -305,7 +305,7 @@ int security_commit_booleans(void)
        }

        snprintf(path, sizeof path, "%s/commit_pending_bools", selinux_mnt);
-       fd = open(path, O_WRONLY);
+       fd = open(path, O_WRONLY | O_CLOEXEC);
        if (fd < 0)
                return -1;

@@ -399,7 +399,7 @@ static int save_booleans(size_t boolcnt, SELboolean *
boollist)

        snprintf(local_bool_file, sizeof(local_bool_file), "%s.local",
                 bool_file);
-       boolf = fopen(local_bool_file, "r");
+       boolf = fopen(local_bool_file, "re");
        if (boolf != NULL) {
                ssize_t ret;
                size_t size = 0;
@@ -518,7 +518,7 @@ int security_load_booleans(char *path)
        int val;
        char name[BUFSIZ];

-       boolf = fopen(path ? path : selinux_booleans_path(), "r");
+       boolf = fopen(path ? path : selinux_booleans_path(), "re");
        if (boolf == NULL)
                goto localbool;

@@ -536,7 +536,7 @@ int security_load_booleans(char *path)
       localbool:
        snprintf(localbools, sizeof(localbools), "%s.local",
                 (path ? path : selinux_booleans_path()));
-       boolf = fopen(localbools, "r");
+       boolf = fopen(localbools, "re");

        if (boolf != NULL) {
                int ret;
diff --git a/libselinux/src/canonicalize_context.c
b/libselinux/src/canonicalize_context.c
index 7cf3139..ba4c9a2 100644
--- a/libselinux/src/canonicalize_context.c
+++ b/libselinux/src/canonicalize_context.c
@@ -23,7 +23,7 @@ int security_canonicalize_context_raw(const char * con,
        }

        snprintf(path, sizeof path, "%s/context", selinux_mnt);
-       fd = open(path, O_RDWR);
+       fd = open(path, O_RDWR | O_CLOEXEC);
        if (fd < 0)
                return -1;

diff --git a/libselinux/src/check_context.c b/libselinux/src/check_context.c
index 52063fa..8a7997f 100644
--- a/libselinux/src/check_context.c
+++ b/libselinux/src/check_context.c
@@ -20,7 +20,7 @@ int security_check_context_raw(const char * con)
        }

        snprintf(path, sizeof path, "%s/context", selinux_mnt);
-       fd = open(path, O_RDWR);
+       fd = open(path, O_RDWR | O_CLOEXEC);
        if (fd < 0)
                return -1;

diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
index 937e5c3..1d05e7b 100644
--- a/libselinux/src/compute_av.c
+++ b/libselinux/src/compute_av.c
@@ -27,7 +27,7 @@ int security_compute_av_flags_raw(const char * scon,
        }

        snprintf(path, sizeof path, "%s/access", selinux_mnt);
-       fd = open(path, O_RDWR);
+       fd = open(path, O_RDWR | O_CLOEXEC);
        if (fd < 0)
                return -1;

diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_
create.c
index 9559d42..0975aea 100644
--- a/libselinux/src/compute_create.c
+++ b/libselinux/src/compute_create.c
@@ -65,7 +65,7 @@ int security_compute_create_name_raw(const char * scon,
        }

        snprintf(path, sizeof path, "%s/create", selinux_mnt);
-       fd = open(path, O_RDWR);
+       fd = open(path, O_RDWR | O_CLOEXEC);
        if (fd < 0)
                return -1;

diff --git a/libselinux/src/compute_member.c b/libselinux/src/compute_
member.c
index 1fc7e41..4e2d221 100644
--- a/libselinux/src/compute_member.c
+++ b/libselinux/src/compute_member.c
@@ -26,7 +26,7 @@ int security_compute_member_raw(const char * scon,
        }

        snprintf(path, sizeof path, "%s/member", selinux_mnt);
-       fd = open(path, O_RDWR);
+       fd = open(path, O_RDWR | O_CLOEXEC);
        if (fd < 0)
                return -1;

diff --git a/libselinux/src/compute_relabel.c b/libselinux/src/compute_
relabel.c
index 4615aee..49f77ef 100644
--- a/libselinux/src/compute_relabel.c
+++ b/libselinux/src/compute_relabel.c
@@ -26,7 +26,7 @@ int security_compute_relabel_raw(const char * scon,
        }

        snprintf(path, sizeof path, "%s/relabel", selinux_mnt);
-       fd = open(path, O_RDWR);
+       fd = open(path, O_RDWR | O_CLOEXEC);
        if (fd < 0)
                return -1;

diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.c
index b37c5d3..7b88121 100644
--- a/libselinux/src/compute_user.c
+++ b/libselinux/src/compute_user.c
@@ -25,7 +25,7 @@ int security_compute_user_raw(const char * scon,
        }

        snprintf(path, sizeof path, "%s/user", selinux_mnt);
-       fd = open(path, O_RDWR);
+       fd = open(path, O_RDWR | O_CLOEXEC);
        if (fd < 0)
                return -1;

diff --git a/libselinux/src/deny_unknown.c b/libselinux/src/deny_unknown.c
index c93998a..77d04e3 100644
--- a/libselinux/src/deny_unknown.c
+++ b/libselinux/src/deny_unknown.c
@@ -21,7 +21,7 @@ int security_deny_unknown(void)
        }

        snprintf(path, sizeof(path), "%s/deny_unknown", selinux_mnt);
-       fd = open(path, O_RDONLY);
+       fd = open(path, O_RDONLY | O_CLOEXEC);
        if (fd < 0)
                return -1;

diff --git a/libselinux/src/disable.c b/libselinux/src/disable.c
index dac0f5b..8d66262 100644
--- a/libselinux/src/disable.c
+++ b/libselinux/src/disable.c
@@ -21,7 +21,7 @@ int security_disable(void)
        }

        snprintf(path, sizeof path, "%s/disable", selinux_mnt);
-       fd = open(path, O_WRONLY);
+       fd = open(path, O_WRONLY | O_CLOEXEC);
        if (fd < 0)
                return -1;

diff --git a/libselinux/src/enabled.c b/libselinux/src/enabled.c
index 2ec6797..dd628fb 100644
--- a/libselinux/src/enabled.c
+++ b/libselinux/src/enabled.c
@@ -36,7 +36,7 @@ int is_selinux_mls_enabled(void)
                return enabled;

        snprintf(path, sizeof path, "%s/mls", selinux_mnt);
-       fd = open(path, O_RDONLY);
+       fd = open(path, O_RDONLY | O_CLOEXEC);
        if (fd < 0)
                return enabled;

diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_
list.c
index f3fa4a9..689e465 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -275,7 +275,7 @@ static int get_failsafe_context(const char *user, char
** newcon)
        size_t plen, nlen;
        int rc;

-       fp = fopen(selinux_failsafe_context_path(), "r");
+       fp = fopen(selinux_failsafe_context_path(), "re");
        if (!fp)
                return -1;

@@ -437,7 +437,7 @@ int get_ordered_context_list(const char *user,
        if (!fname)
                goto failsafe;
        snprintf(fname, fname_len, "%s%s", user_contexts_path, user);
-       fp = fopen(fname, "r");
+       fp = fopen(fname, "re");
        if (fp) {
                __fsetlocking(fp, FSETLOCKING_BYCALLER);
                rc = get_context_order(fp, fromcon, reachable, nreach,
ordering,
@@ -451,7 +451,7 @@ int get_ordered_context_list(const char *user,
                }
        }
        free(fname);
-       fp = fopen(selinux_default_context_path(), "r");
+       fp = fopen(selinux_default_context_path(), "re");
        if (fp) {
                __fsetlocking(fp, FSETLOCKING_BYCALLER);
                rc = get_context_order(fp, fromcon, reachable, nreach,
ordering,
diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_default_
type.c
index 27f2ae5..dd7b5d7 100644
--- a/libselinux/src/get_default_type.c
+++ b/libselinux/src/get_default_type.c
@@ -11,7 +11,7 @@ int get_default_type(const char *role, char **type)
 {
        FILE *fp = NULL;

-       fp = fopen(selinux_default_type_path(), "r");
+       fp = fopen(selinux_default_type_path(), "re");
        if (!fp)
                return -1;

diff --git a/libselinux/src/get_initial_context.c
b/libselinux/src/get_initial_context.c
index 522ed78..5e919f4 100644
--- a/libselinux/src/get_initial_context.c
+++ b/libselinux/src/get_initial_context.c
@@ -25,7 +25,7 @@ int security_get_initial_context_raw(const char * name,
char ** con)

        snprintf(path, sizeof path, "%s%s%s",
                 selinux_mnt, SELINUX_INITCON_DIR, name);
-       fd = open(path, O_RDONLY);
+       fd = open(path, O_RDONLY | O_CLOEXEC);
        if (fd < 0)
                return -1;

diff --git a/libselinux/src/getenforce.c b/libselinux/src/getenforce.c
index 03d3abc..d909dce 100644
--- a/libselinux/src/getenforce.c
+++ b/libselinux/src/getenforce.c
@@ -21,7 +21,7 @@ int security_getenforce(void)
        }

        snprintf(path, sizeof path, "%s/enforce", selinux_mnt);
-       fd = open(path, O_RDONLY);
+       fd = open(path, O_RDONLY | O_CLOEXEC);
        if (fd < 0)
                return -1;

diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index ddf91f8..2690a72 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -61,7 +61,7 @@ int selinuxfs_exists(void)
        size_t len;
        ssize_t num;

-       fp = fopen("/proc/filesystems", "r");
+       fp = fopen("/proc/filesystems", "re");
        if (!fp)
                return 1; /* Fail as if it exists */
        __fsetlocking(fp, FSETLOCKING_BYCALLER);
@@ -101,7 +101,7 @@ static void init_selinuxmnt(void)

        /* At this point, the usual spot doesn't have an selinuxfs so
         * we look around for it */
-       fp = fopen("/proc/mounts", "r");
+       fp = fopen("/proc/mounts", "re");
        if (!fp)
                goto out;

diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_
customizable_type.c
index 0b33edc..92876f4 100644
--- a/libselinux/src/is_customizable_type.c
+++ b/libselinux/src/is_customizable_type.c
@@ -16,7 +16,7 @@ static int get_customizable_type_list(char *** retlist)
        unsigned int ctr = 0, i;
        char **list = NULL;

-       fp = fopen(selinux_customizable_types_path(), "r");
+       fp = fopen(selinux_customizable_types_path(), "re");
        if (!fp)
                return -1;

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 60639cf..5c9d8c1 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -96,7 +96,7 @@ struct selabel_sub *selabel_subs_init(const char *path,
                                            struct selabel_digest *digest)
 {
        char buf[1024];
-       FILE *cfg = fopen(path, "r");
+       FILE *cfg = fopen(path, "re");
        struct selabel_sub *sub = NULL;
        struct stat sb;

diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_
backends_android.c
index 4d6ec86..4ad71f9 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -159,7 +159,7 @@ static int init(struct selabel_handle *rec, const
struct selinux_opt *opts,
                return -1;

        /* Open the specification file. */
-       if ((fp = fopen(path, "r")) == NULL)
+       if ((fp = fopen(path, "re")) == NULL)
                return -1;

        if (fstat(fileno(fp), &sb) < 0)
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index a4dc3cd..0d4029b 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -520,7 +520,7 @@ static FILE *open_file(const char *path, const char
*suffix,
        }

        memcpy(sb, &found->sb, sizeof(*sb));
-       return fopen(save_path, "r");
+       return fopen(save_path, "re");
 }

 static int process_file(const char *path, const char *suffix,
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index 622741b..d202e5d 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -90,7 +90,7 @@ static int init(struct selabel_handle *rec, const struct
selinux_opt *opts,
        /* Open the specification file. */
        if (!path)
                path = selinux_media_context_path();
-       if ((fp = fopen(path, "r")) == NULL)
+       if ((fp = fopen(path, "re")) == NULL)
                return -1;
        __fsetlocking(fp, FSETLOCKING_BYCALLER);

diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index 700def1..9674529 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -117,7 +117,7 @@ static int init(struct selabel_handle *rec, const
struct selinux_opt *opts,
        /* Open the specification file. */
        if (!path)
                path = selinux_x_context_path();
-       if ((fp = fopen(path, "r")) == NULL)
+       if ((fp = fopen(path, "re")) == NULL)
                return -1;
        __fsetlocking(fp, FSETLOCKING_BYCALLER);

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index b7e1a6f..327cc6a 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -34,7 +34,7 @@ int security_load_policy(void *data, size_t len)
        }

        snprintf(path, sizeof path, "%s/load", selinux_mnt);
-       fd = open(path, O_RDWR);
+       fd = open(path, O_RDWR | O_CLOEXEC);
        if (fd < 0)
                return -1;

@@ -173,13 +173,13 @@ checkbool:
       search:
        snprintf(path, sizeof(path), "%s.%d",
                 selinux_binary_policy_path(), vers);
-       fd = open(path, O_RDONLY);
+       fd = open(path, O_RDONLY | O_CLOEXEC);
        while (fd < 0 && errno == ENOENT
               && --vers >= minvers) {
                /* Check prior versions to see if old policy is available */
                snprintf(path, sizeof(path), "%s.%d",
                         selinux_binary_policy_path(), vers);
-               fd = open(path, O_RDONLY);
+               fd = open(path, O_RDONLY | O_CLOEXEC);
        }
        if (fd < 0) {
                fprintf(stderr,
@@ -335,7 +335,7 @@ int selinux_init_load_policy(int *enforce)

        /* Check for an override of the mode via the kernel command line. */
        rc = mount("proc", "/proc", "proc", 0, 0);
-       cfg = fopen("/proc/cmdline", "r");
+       cfg = fopen("/proc/cmdline", "re");
        if (cfg) {
                char *tmp;
                buf = malloc(selinux_page_size);
diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmediacon.c
index 46cba46..23d01af 100644
--- a/libselinux/src/matchmediacon.c
+++ b/libselinux/src/matchmediacon.c
@@ -18,7 +18,7 @@ int matchmediacon(const char *media, char ** con)
        char *ptr, *ptr2 = NULL;
        int found = 0;
        char current_line[PATH_MAX];
-       if ((infile = fopen(path, "r")) == NULL)
+       if ((infile = fopen(path, "re")) == NULL)
                return -1;
        while (!feof_unlocked(infile)) {
                if (!fgets_unlocked(current_line, sizeof(current_line),
infile)) {
diff --git a/libselinux/src/policyvers.c b/libselinux/src/policyvers.c
index 284a7f7..c97dd9d 100644
--- a/libselinux/src/policyvers.c
+++ b/libselinux/src/policyvers.c
@@ -23,7 +23,7 @@ int security_policyvers(void)
        }

        snprintf(path, sizeof path, "%s/policyvers", selinux_mnt);
-       fd = open(path, O_RDONLY);
+       fd = open(path, O_RDONLY | O_CLOEXEC);
        if (fd < 0) {
                if (errno == ENOENT)
                        return vers;
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index 8cd59af..ebc0ade 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -143,7 +143,7 @@ static int getprocattrcon_raw(char ** context,
                return 0;
        }

-       fd = openattr(pid, attr, O_RDONLY);
+       fd = openattr(pid, attr, O_RDONLY | O_CLOEXEC);
        if (fd < 0)
                return -1;

@@ -235,7 +235,7 @@ static int setprocattrcon_raw(const char * context,
            && !strcmp(context, *prev_context))
                return 0;

-       fd = openattr(pid, attr, O_RDWR);
+       fd = openattr(pid, attr, O_RDWR | O_CLOEXEC);
        if (fd < 0)
                return -1;
        if (context) {
diff --git a/libselinux/src/selinux_check_securetty_context.c
b/libselinux/src/selinux_check_securetty_context.c
index 24e5e2c..55d4e03 100644
--- a/libselinux/src/selinux_check_securetty_context.c
+++ b/libselinux/src/selinux_check_securetty_context.c
@@ -14,7 +14,7 @@ int selinux_check_securetty_context(const char *
tty_context)
        ssize_t len;
        int found = -1;
        FILE *fp;
-       fp = fopen(selinux_securetty_types_path(), "r");
+       fp = fopen(selinux_securetty_types_path(), "re");
        if (fp) {
                context_t con = context_new(tty_context);
                if (con) {
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_
config.c
index 88bcc85..d8e140c 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -88,7 +88,7 @@ static const uint16_t file_path_suffixes_idx[NEL] = {
 int selinux_getenforcemode(int *enforce)
 {
        int ret = -1;
-       FILE *cfg = fopen(SELINUXCONFIG, "r");
+       FILE *cfg = fopen(SELINUXCONFIG, "re");
        if (cfg) {
                char *buf;
                int len = sizeof(SELINUXTAG) - 1;
@@ -163,7 +163,7 @@ static void init_selinux_config(void)
        if (selinux_policyroot)
                return;

-       fp = fopen(SELINUXCONFIG, "r");
+       fp = fopen(SELINUXCONFIG, "re");
        if (fp) {
                __fsetlocking(fp, FSETLOCKING_BYCALLER);
                while ((len = getline(&line_buf, &line_len, fp)) > 0) {
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_
restorecon.c
index e38d1d0..7ebfbdc 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -247,7 +247,7 @@ static int exclude_non_seclabel_mounts(void)
        if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") < 0)
                return 0;

-       fp = fopen("/proc/mounts", "r");
+       fp = fopen("/proc/mounts", "re");
        if (!fp)
                return 0;

diff --git a/libselinux/src/setenforce.c b/libselinux/src/setenforce.c
index e5e7612..09cad3c 100644
--- a/libselinux/src/setenforce.c
+++ b/libselinux/src/setenforce.c
@@ -21,7 +21,7 @@ int security_setenforce(int value)
        }

        snprintf(path, sizeof path, "%s/enforce", selinux_mnt);
-       fd = open(path, O_RDWR);
+       fd = open(path, O_RDWR | O_CLOEXEC);
        if (fd < 0)
                return -1;

diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index 09e704b..572a7b0 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -185,7 +185,7 @@ int getseuserbyname(const char *name, char **r_seuser,
char **r_level)

        gid_t gid = get_default_gid(name);

-       cfg = fopen(selinux_usersconf_path(), "r");
+       cfg = fopen(selinux_usersconf_path(), "re");
        if (!cfg)
                goto nomatch;

@@ -278,7 +278,7 @@ int getseuser(const char *username, const char *service,
        FILE *fp = NULL;
        if (asprintf(&path,"%s/logins/%s", selinux_policy_root(), username)
<  0)
                goto err;
-       fp = fopen(path, "r");
+       fp = fopen(path, "re");
        free(path);
        if (fp == NULL) goto err;
        __fsetlocking(fp, FSETLOCKING_BYCALLER);
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index 2dbec2b..2d83f96 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -80,7 +80,7 @@ static struct discover_class_node * discover_class(const
char *s)

        /* load up class index */
        snprintf(path, sizeof path, "%s/class/%s/index", selinux_mnt,s);
-       fd = open(path, O_RDONLY);
+       fd = open(path, O_RDONLY | O_CLOEXEC);
        if (fd < 0)
                goto err3;

--
2.8.0.rc3.226.g39d4020

_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a113df3ee70f8cb054368d287
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Do you know if &quot;re&quot; poses any Mac issues? =
I would assume not, but I&#39;ve never checked.<br><div class=3D"gmail_extr=
a"><br><div class=3D"gmail_quote">On Dec 11, 2016 09:32, &quot;Nick Kralevi=
ch&quot; &lt;<a href=3D"mailto:nnk@google.com">nnk@google.com</a>&gt; wrote=
:<br type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Makes libselinux safer a=
nd less likely to leak file descriptors when<br>
used as part of a multithreaded program.<br>
<br>
Signed-off-by: Nick Kralevich &lt;<a href=3D"mailto:nnk@google.com">nnk@goo=
gle.com</a>&gt;<br>
---<br>
=C2=A0libselinux/src/audit2why.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<br>
=C2=A0libselinux/src/booleans.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 +++++++-------<br>
=C2=A0libselinux/src/canonicalize_<wbr>context.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/check_context.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0libselinux/src/compute_av.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/compute_create.<wbr>c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/compute_member.<wbr>c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/compute_<wbr>relabel.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0libselinux/src/compute_user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/deny_unknown.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/disable.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0libselinux/src/enabled.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0libselinux/src/get_context_<wbr>list.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +++---<br>
=C2=A0libselinux/src/get_default_<wbr>type.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/get_initial_<wbr>context.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0libselinux/src/getenforce.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0libselinux/src/is_<wbr>customizable_type.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/label.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0libselinux/src/label_backends_<wbr>android.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/label_file.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/label_media.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0libselinux/src/label_x.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0libselinux/src/load_policy.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++++----<br>
=C2=A0libselinux/src/matchmediacon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0libselinux/src/policyvers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/procattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0libselinux/src/selinux_check_<wbr>securetty_context.c |=C2=A0 2 +-<br=
>
=C2=A0libselinux/src/selinux_config.<wbr>c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0libselinux/src/selinux_<wbr>restorecon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/setenforce.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0libselinux/src/seusers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<br>
=C2=A0libselinux/src/stringrep.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A033 files changed, 49 insertions(+), 49 deletions(-)<br>
<br>
diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c<br>
index 3135eed..857383a 100644<br>
--- a/libselinux/src/audit2why.c<br>
+++ b/libselinux/src/audit2why.c<br>
@@ -201,7 +201,7 @@ static int __policy_init(const char *init_path)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 path[PATH_MAX-1] =3D &#39;\0&#39;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (init_path) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(path, init_=
path, PATH_MAX-1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(path, =
&quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(path, =
&quot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fp) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 snprintf(errormsg, sizeof(errormsg),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;unable to open %s:=C2=A0=
 %s\n&quot;,<br>
@@ -218,7 +218,7 @@ static int __policy_init(const char *init_path)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 PyErr_SetString( PyExc_ValueError, errormsg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(curpol=
icy, &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(curpol=
icy, &quot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fp) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 snprintf(errormsg, sizeof(errormsg),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;unable to open %s:=C2=A0=
 %s\n&quot;,<br>
diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c<br>
index ba9d934..4a38a78 100644<br>
--- a/libselinux/src/booleans.c<br>
+++ b/libselinux/src/booleans.c<br>
@@ -97,7 +97,7 @@ char *selinux_boolean_sub(const char *name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cfg =3D fopen(selinux_booleans_subs_<wbr>path()=
, &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cfg =3D fopen(selinux_booleans_subs_<wbr>path()=
, &quot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cfg)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
<br>
@@ -210,7 +210,7 @@ static int get_bool_value(const char *name, char **buf)=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*buf)[STRBUF_SIZE] =3D 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D bool_open(name, O_RDONLY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D bool_open(name, O_RDONLY | O_CLOEXEC);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_err;<br>
<br>
@@ -274,7 +274,7 @@ int security_set_boolean(const char *name, int value)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D bool_open(name, O_WRONLY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D bool_open(name, O_WRONLY | O_CLOEXEC);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
@@ -305,7 +305,7 @@ int security_commit_booleans(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/commit_pen=
ding_bools&quot;, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_WRONLY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_WRONLY | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
@@ -399,7 +399,7 @@ static int save_booleans(size_t boolcnt, SELboolean * b=
oollist)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(local_bool_file, sizeof(local_bool_fil=
e), &quot;%s.local&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool_file);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0boolf =3D fopen(local_bool_file, &quot;r&quot;)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0boolf =3D fopen(local_bool_file, &quot;re&quot;=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (boolf !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t size =3D 0;<=
br>
@@ -518,7 +518,7 @@ int security_load_booleans(char *path)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int val;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char name[BUFSIZ];<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0boolf =3D fopen(path ? path : selinux_booleans_=
path(), &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0boolf =3D fopen(path ? path : selinux_booleans_=
path(), &quot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (boolf =3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto localbool;<br>
<br>
@@ -536,7 +536,7 @@ int security_load_booleans(char *path)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0localbool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(localbools, sizeof(localbools), &quot;=
%s.local&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(path ? path =
: selinux_booleans_path()));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0boolf =3D fopen(localbools, &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0boolf =3D fopen(localbools, &quot;re&quot;);<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (boolf !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
diff --git a/libselinux/src/canonicalize_<wbr>context.c b/libselinux/src/ca=
nonicalize_<wbr>context.c<br>
index 7cf3139..ba4c9a2 100644<br>
--- a/libselinux/src/canonicalize_<wbr>context.c<br>
+++ b/libselinux/src/canonicalize_<wbr>context.c<br>
@@ -23,7 +23,7 @@ int security_canonicalize_context_<wbr>raw(const char * c=
on,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/context&qu=
ot;, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/check_<wbr>context.c b/libselinux/src/check_<wb=
r>context.c<br>
index 52063fa..8a7997f 100644<br>
--- a/libselinux/src/check_<wbr>context.c<br>
+++ b/libselinux/src/check_<wbr>context.c<br>
@@ -20,7 +20,7 @@ int security_check_context_raw(<wbr>const char * con)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/context&qu=
ot;, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c<br>
index 937e5c3..1d05e7b 100644<br>
--- a/libselinux/src/compute_av.c<br>
+++ b/libselinux/src/compute_av.c<br>
@@ -27,7 +27,7 @@ int security_compute_av_flags_raw(<wbr>const char * scon,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/access&quo=
t;, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/compute_<wbr>create.c b/libselinux/src/compute_=
<wbr>create.c<br>
index 9559d42..0975aea 100644<br>
--- a/libselinux/src/compute_<wbr>create.c<br>
+++ b/libselinux/src/compute_<wbr>create.c<br>
@@ -65,7 +65,7 @@ int security_compute_create_name_<wbr>raw(const char * sc=
on,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/create&quo=
t;, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/compute_<wbr>member.c b/libselinux/src/compute_=
<wbr>member.c<br>
index 1fc7e41..4e2d221 100644<br>
--- a/libselinux/src/compute_<wbr>member.c<br>
+++ b/libselinux/src/compute_<wbr>member.c<br>
@@ -26,7 +26,7 @@ int security_compute_member_raw(<wbr>const char * scon,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/member&quo=
t;, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/compute_<wbr>relabel.c b/libselinux/src/compute=
_<wbr>relabel.c<br>
index 4615aee..49f77ef 100644<br>
--- a/libselinux/src/compute_<wbr>relabel.c<br>
+++ b/libselinux/src/compute_<wbr>relabel.c<br>
@@ -26,7 +26,7 @@ int security_compute_relabel_raw(<wbr>const char * scon,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/relabel&qu=
ot;, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/compute_user.<wbr>c b/libselinux/src/compute_us=
er.<wbr>c<br>
index b37c5d3..7b88121 100644<br>
--- a/libselinux/src/compute_user.<wbr>c<br>
+++ b/libselinux/src/compute_user.<wbr>c<br>
@@ -25,7 +25,7 @@ int security_compute_user_raw(<wbr>const char * scon,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/user&quot;=
, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/deny_unknown.<wbr>c b/libselinux/src/deny_unkno=
wn.<wbr>c<br>
index c93998a..77d04e3 100644<br>
--- a/libselinux/src/deny_unknown.<wbr>c<br>
+++ b/libselinux/src/deny_unknown.<wbr>c<br>
@@ -21,7 +21,7 @@ int security_deny_unknown(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof(path), &quot;%s/deny_unkn=
own&quot;, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/disable.c b/libselinux/src/disable.c<br>
index dac0f5b..8d66262 100644<br>
--- a/libselinux/src/disable.c<br>
+++ b/libselinux/src/disable.c<br>
@@ -21,7 +21,7 @@ int security_disable(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/disable&qu=
ot;, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_WRONLY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_WRONLY | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/enabled.c b/libselinux/src/enabled.c<br>
index 2ec6797..dd628fb 100644<br>
--- a/libselinux/src/enabled.c<br>
+++ b/libselinux/src/enabled.c<br>
@@ -36,7 +36,7 @@ int is_selinux_mls_enabled(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return enabled;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/mls&quot;,=
 selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return enabled;<br>
<br>
diff --git a/libselinux/src/get_context_<wbr>list.c b/libselinux/src/get_co=
ntext_<wbr>list.c<br>
index f3fa4a9..689e465 100644<br>
--- a/libselinux/src/get_context_<wbr>list.c<br>
+++ b/libselinux/src/get_context_<wbr>list.c<br>
@@ -275,7 +275,7 @@ static int get_failsafe_context(const char *user, char =
** newcon)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t plen, nlen;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(selinux_failsafe_<wbr>context_path=
(), &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(selinux_failsafe_<wbr>context_path=
(), &quot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
@@ -437,7 +437,7 @@ int get_ordered_context_list(const char *user,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fname)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto failsafe;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(fname, fname_len, &quot;%s%s&quot;, us=
er_contexts_path, user);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(fname, &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(fname, &quot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __fsetlocking(fp, F=
SETLOCKING_BYCALLER);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D get_context_=
order(fp, fromcon, reachable, nreach, ordering,<br>
@@ -451,7 +451,7 @@ int get_ordered_context_list(const char *user,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(fname);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(selinux_default_context_<wbr>path(=
), &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(selinux_default_context_<wbr>path(=
), &quot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __fsetlocking(fp, F=
SETLOCKING_BYCALLER);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D get_context_=
order(fp, fromcon, reachable, nreach, ordering,<br>
diff --git a/libselinux/src/get_default_<wbr>type.c b/libselinux/src/get_de=
fault_<wbr>type.c<br>
index 27f2ae5..dd7b5d7 100644<br>
--- a/libselinux/src/get_default_<wbr>type.c<br>
+++ b/libselinux/src/get_default_<wbr>type.c<br>
@@ -11,7 +11,7 @@ int get_default_type(const char *role, char **type)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE *fp =3D NULL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(selinux_default_type_<wbr>path(), =
&quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(selinux_default_type_<wbr>path(), =
&quot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/get_initial_<wbr>context.c b/libselinux/src/get=
_initial_<wbr>context.c<br>
index 522ed78..5e919f4 100644<br>
--- a/libselinux/src/get_initial_<wbr>context.c<br>
+++ b/libselinux/src/get_initial_<wbr>context.c<br>
@@ -25,7 +25,7 @@ int security_get_initial_context_<wbr>raw(const char * na=
me, char ** con)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s%s%s&quot;,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selinux_mnt, =
SELINUX_INITCON_DIR, name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/getenforce.c b/libselinux/src/getenforce.c<br>
index 03d3abc..d909dce 100644<br>
--- a/libselinux/src/getenforce.c<br>
+++ b/libselinux/src/getenforce.c<br>
@@ -21,7 +21,7 @@ int security_getenforce(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/enforce&qu=
ot;, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/init.c b/libselinux/src/init.c<br>
index ddf91f8..2690a72 100644<br>
--- a/libselinux/src/init.c<br>
+++ b/libselinux/src/init.c<br>
@@ -61,7 +61,7 @@ int selinuxfs_exists(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t num;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(&quot;/proc/filesystems&quot;, &qu=
ot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(&quot;/proc/filesystems&quot;, &qu=
ot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1; /* Fail a=
s if it exists */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __fsetlocking(fp, FSETLOCKING_BYCALLER);<br>
@@ -101,7 +101,7 @@ static void init_selinuxmnt(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* At this point, the usual spot doesn&#39;t ha=
ve an selinuxfs so<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* we look around for it */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(&quot;/proc/mounts&quot;, &quot;r&=
quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(&quot;/proc/mounts&quot;, &quot;re=
&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
<br>
diff --git a/libselinux/src/is_<wbr>customizable_type.c b/libselinux/src/is=
_<wbr>customizable_type.c<br>
index 0b33edc..92876f4 100644<br>
--- a/libselinux/src/is_<wbr>customizable_type.c<br>
+++ b/libselinux/src/is_<wbr>customizable_type.c<br>
@@ -16,7 +16,7 @@ static int get_customizable_type_list(<wbr>char *** retli=
st)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int ctr =3D 0, i;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char **list =3D NULL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(selinux_customizable_<wbr>types_pa=
th(), &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(selinux_customizable_<wbr>types_pa=
th(), &quot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/label.c b/libselinux/src/label.c<br>
index 60639cf..5c9d8c1 100644<br>
--- a/libselinux/src/label.c<br>
+++ b/libselinux/src/label.c<br>
@@ -96,7 +96,7 @@ struct selabel_sub *selabel_subs_init(const char *path,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct selabel_digest *digest)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char buf[1024];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0FILE *cfg =3D fopen(path, &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0FILE *cfg =3D fopen(path, &quot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct selabel_sub *sub =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct stat sb;<br>
<br>
diff --git a/libselinux/src/label_<wbr>backends_android.c b/libselinux/src/=
label_<wbr>backends_android.c<br>
index 4d6ec86..4ad71f9 100644<br>
--- a/libselinux/src/label_<wbr>backends_android.c<br>
+++ b/libselinux/src/label_<wbr>backends_android.c<br>
@@ -159,7 +159,7 @@ static int init(struct selabel_handle *rec, const struc=
t selinux_opt *opts,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Open the specification file. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fp =3D fopen(path, &quot;r&quot;)) =3D=3D =
NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fp =3D fopen(path, &quot;re&quot;)) =3D=3D=
 NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fstat(fileno(fp), &amp;sb) &lt; 0)<br>
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c<br>
index a4dc3cd..0d4029b 100644<br>
--- a/libselinux/src/label_file.c<br>
+++ b/libselinux/src/label_file.c<br>
@@ -520,7 +520,7 @@ static FILE *open_file(const char *path, const char *su=
ffix,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(sb, &amp;found-&gt;sb, sizeof(*sb));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return fopen(save_path, &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return fopen(save_path, &quot;re&quot;);<br>
=C2=A0}<br>
<br>
=C2=A0static int process_file(const char *path, const char *suffix,<br>
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c<br=
>
index 622741b..d202e5d 100644<br>
--- a/libselinux/src/label_media.c<br>
+++ b/libselinux/src/label_media.c<br>
@@ -90,7 +90,7 @@ static int init(struct selabel_handle *rec, const struct =
selinux_opt *opts,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Open the specification file. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!path)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D selinux_me=
dia_context_path();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fp =3D fopen(path, &quot;r&quot;)) =3D=3D =
NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fp =3D fopen(path, &quot;re&quot;)) =3D=3D=
 NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __fsetlocking(fp, FSETLOCKING_BYCALLER);<br>
<br>
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c<br>
index 700def1..9674529 100644<br>
--- a/libselinux/src/label_x.c<br>
+++ b/libselinux/src/label_x.c<br>
@@ -117,7 +117,7 @@ static int init(struct selabel_handle *rec, const struc=
t selinux_opt *opts,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Open the specification file. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!path)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D selinux_x_=
context_path();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fp =3D fopen(path, &quot;r&quot;)) =3D=3D =
NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fp =3D fopen(path, &quot;re&quot;)) =3D=3D=
 NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __fsetlocking(fp, FSETLOCKING_BYCALLER);<br>
<br>
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c<br=
>
index b7e1a6f..327cc6a 100644<br>
--- a/libselinux/src/load_policy.c<br>
+++ b/libselinux/src/load_policy.c<br>
@@ -34,7 +34,7 @@ int security_load_policy(void *data, size_t len)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/load&quot;=
, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
@@ -173,13 +173,13 @@ checkbool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0search:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof(path), &quot;%s.%d&quot;,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selinux_binar=
y_policy_path(), vers);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (fd &lt; 0 &amp;&amp; errno =3D=3D ENOENT=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; --vers &g=
t;=3D minvers) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check prior vers=
ions to see if old policy is available */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, size=
of(path), &quot;%s.%d&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0selinux_binary_policy_path(), vers);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O=
_RDONLY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O=
_RDONLY | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>
@@ -335,7 +335,7 @@ int selinux_init_load_policy(int *enforce)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check for an override of the mode via the ke=
rnel command line. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D mount(&quot;proc&quot;, &quot;/proc&quot=
;, &quot;proc&quot;, 0, 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cfg =3D fopen(&quot;/proc/cmdline&quot;, &quot;=
r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cfg =3D fopen(&quot;/proc/cmdline&quot;, &quot;=
re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cfg) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *tmp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf =3D malloc(seli=
nux_page_size);<br>
diff --git a/libselinux/src/<wbr>matchmediacon.c b/libselinux/src/<wbr>matc=
hmediacon.c<br>
index 46cba46..23d01af 100644<br>
--- a/libselinux/src/<wbr>matchmediacon.c<br>
+++ b/libselinux/src/<wbr>matchmediacon.c<br>
@@ -18,7 +18,7 @@ int matchmediacon(const char *media, char ** con)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *ptr, *ptr2 =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int found =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char current_line[PATH_MAX];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((infile =3D fopen(path, &quot;r&quot;)) =3D=
=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((infile =3D fopen(path, &quot;re&quot;)) =
=3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (!feof_unlocked(infile)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fgets_unlocked=
(current_line, sizeof(current_line), infile)) {<br>
diff --git a/libselinux/src/policyvers.c b/libselinux/src/policyvers.c<br>
index 284a7f7..c97dd9d 100644<br>
--- a/libselinux/src/policyvers.c<br>
+++ b/libselinux/src/policyvers.c<br>
@@ -23,7 +23,7 @@ int security_policyvers(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/policyvers=
&quot;, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D EN=
OENT)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return vers;<br>
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c<br>
index 8cd59af..ebc0ade 100644<br>
--- a/libselinux/src/procattr.c<br>
+++ b/libselinux/src/procattr.c<br>
@@ -143,7 +143,7 @@ static int getprocattrcon_raw(char ** context,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D openattr(pid, attr, O_RDONLY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D openattr(pid, attr, O_RDONLY | O_CLOEXEC=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
@@ -235,7 +235,7 @@ static int setprocattrcon_raw(const char * context,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; !strcmp(context, *prev=
_context))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D openattr(pid, attr, O_RDWR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D openattr(pid, attr, O_RDWR | O_CLOEXEC);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (context) {<br>
diff --git a/libselinux/src/selinux_<wbr>check_securetty_context.c b/libsel=
inux/src/selinux_<wbr>check_securetty_context.c<br>
index 24e5e2c..55d4e03 100644<br>
--- a/libselinux/src/selinux_<wbr>check_securetty_context.c<br>
+++ b/libselinux/src/selinux_<wbr>check_securetty_context.c<br>
@@ -14,7 +14,7 @@ int selinux_check_securetty_<wbr>context(const char * tty=
_context)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t len;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int found =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE *fp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(selinux_securetty_types_<wbr>path(=
), &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(selinux_securetty_types_<wbr>path(=
), &quot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 context_t con =3D c=
ontext_new(tty_context);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (con) {<br>
diff --git a/libselinux/src/selinux_<wbr>config.c b/libselinux/src/selinux_=
<wbr>config.c<br>
index 88bcc85..d8e140c 100644<br>
--- a/libselinux/src/selinux_<wbr>config.c<br>
+++ b/libselinux/src/selinux_<wbr>config.c<br>
@@ -88,7 +88,7 @@ static const uint16_t file_path_suffixes_idx[NEL] =3D {<b=
r>
=C2=A0int selinux_getenforcemode(int *enforce)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret =3D -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0FILE *cfg =3D fopen(SELINUXCONFIG, &quot;r&quot=
;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0FILE *cfg =3D fopen(SELINUXCONFIG, &quot;re&quo=
t;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cfg) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D sizeof(=
SELINUXTAG) - 1;<br>
@@ -163,7 +163,7 @@ static void init_selinux_config(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (selinux_policyroot)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(SELINUXCONFIG, &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(SELINUXCONFIG, &quot;re&quot;);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __fsetlocking(fp, F=
SETLOCKING_BYCALLER);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while ((len =3D get=
line(&amp;line_buf, &amp;line_len, fp)) &gt; 0) {<br>
diff --git a/libselinux/src/selinux_<wbr>restorecon.c b/libselinux/src/seli=
nux_<wbr>restorecon.c<br>
index e38d1d0..7ebfbdc 100644<br>
--- a/libselinux/src/selinux_<wbr>restorecon.c<br>
+++ b/libselinux/src/selinux_<wbr>restorecon.c<br>
@@ -247,7 +247,7 @@ static int exclude_non_seclabel_mounts(<wbr>void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (uname(&amp;uts) =3D=3D 0 &amp;&amp; strvers=
cmp(uts.release, &quot;2.6.30&quot;) &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(&quot;/proc/mounts&quot;, &quot;r&=
quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(&quot;/proc/mounts&quot;, &quot;re=
&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
diff --git a/libselinux/src/setenforce.c b/libselinux/src/setenforce.c<br>
index e5e7612..09cad3c 100644<br>
--- a/libselinux/src/setenforce.c<br>
+++ b/libselinux/src/setenforce.c<br>
@@ -21,7 +21,7 @@ int security_setenforce(int value)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/enforce&qu=
ot;, selinux_mnt);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDWR | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c<br>
index 09e704b..572a7b0 100644<br>
--- a/libselinux/src/seusers.c<br>
+++ b/libselinux/src/seusers.c<br>
@@ -185,7 +185,7 @@ int getseuserbyname(const char *name, char **r_seuser, =
char **r_level)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gid_t gid =3D get_default_gid(name);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cfg =3D fopen(selinux_usersconf_path()<wbr>, &q=
uot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cfg =3D fopen(selinux_usersconf_path()<wbr>, &q=
uot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cfg)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto nomatch;<br>
<br>
@@ -278,7 +278,7 @@ int getseuser(const char *username, const char *service=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE *fp =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (asprintf(&amp;path,&quot;%s/logins/%s&quot;=
<wbr>, selinux_policy_root(), username) &lt;=C2=A0 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(path, &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(path, &quot;re&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(path);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp =3D=3D NULL) goto err;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __fsetlocking(fp, FSETLOCKING_BYCALLER);<br>
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c<br>
index 2dbec2b..2d83f96 100644<br>
--- a/libselinux/src/stringrep.c<br>
+++ b/libselinux/src/stringrep.c<br>
@@ -80,7 +80,7 @@ static struct discover_class_node * discover_class(const =
char *s)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* load up class index */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(path, sizeof path, &quot;%s/class/%s/i=
ndex&quot;, selinux_mnt,s);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY | O_CLOEXEC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err3;<br>
<font color=3D"#888888"><br>
--<br>
2.8.0.rc3.226.g39d4020<br>
<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</font></blockquote></div><br></div></div></div>

--001a113df3ee70f8cb054368d287--
