From: Patrick Steinhardt <ps@pks.im>
To: selinux@tycho.nsa.gov
Cc: Patrick Steinhardt <ps@pks.im>, Stephen Smalley <sds@tycho.nsa.gov>,
 Jason Zaman <jason@perfinion.com>, Petr Lautrbach <plautrba@redhat.com>,
 Daniel J Walsh <dwalsh@redhat.com>
Subject: [PATCH v2 0/2] Portability improvements
Date: Thu, 22 Jun 2017 11:45:56 +0200
Message-Id: <cover.1498124363.git.ps@pks.im>
In-Reply-To: <cover.1497967444.git.ps@pks.im>
References: <cover.1497967444.git.ps@pks.im>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

this is the second version of my portability fixes. Changes
include applying proposed changes (thanks Stephen and Jason) as
well as improved commit messages. The interdiff is attached
below.

I've dropped the first patch as it's already been applied.

Patrick

Patrick Steinhardt (2):
  libselinux: avoid redefining _FORTIFY_SOURCE
  genhomedircon: avoid use of non-standard `getpwent_r`

 libselinux/src/Makefile         |  2 +-
 libselinux/utils/Makefile       |  2 +-
 libsemanage/src/genhomedircon.c | 34 +++++++---------------------------
 3 files changed, 9 insertions(+), 29 deletions(-)

-- 
2.13.1

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 010b7ffe..ea912609 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -59,8 +59,7 @@ ifeq ($(COMPILER), gcc)
 EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
-	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const \
-	-Wp,-U_FORTIFY_SOURCE -Wp,-D_FORTIFY_SOURCE=2
+	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE
 else
 EXTRA_CFLAGS = -Wunused-command-line-argument
 endif
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index eb28120d..eb4851a9 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -32,8 +32,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
           -Woverflow -Wpointer-to-int-cast -Wpragmas \
           -Wno-missing-field-initializers -Wno-sign-compare \
-          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) \
-          -Wp,-U_FORTIFY_SOURCE -Wp,-D_FORTIFY_SOURCE=2 \
+          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
           -Werror -Wno-aggregate-return -Wno-redundant-decls \
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index f58c17ce..b9a74b73 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -290,9 +290,7 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 	semanage_list_t *homedir_list = NULL;
 	semanage_list_t *shells = NULL;
 	fc_match_handle_t hand;
-	char *rbuf = NULL;
 	char *path = NULL;
-	long rbuflen;
 	uid_t temp, minuid = 500, maxuid = 60000;
 	int minuid_set = 0;
 	struct passwd *pwbuf;
@@ -361,12 +359,7 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 	free(path);
 	path = NULL;
 
-	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
-	if (rbuflen <= 0)
-		goto fail;
-	rbuf = malloc(rbuflen);
-	if (rbuf == NULL)
-		goto fail;
+	errno = 0;
 	setpwent();
 	while ((pwbuf = getpwent()) != NULL) {
 		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid > maxuid)
@@ -410,9 +403,10 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 		}
 		free(path);
 		path = NULL;
+		errno = 0;
 	}
 
-	if (errno && errno != ENOENT) {
+	if (errno) {
 		WARN(s->h_semanage, "Error while fetching users.  "
 		     "Returning list so far.");
 	}
@@ -421,14 +415,12 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 		goto fail;
 
 	endpwent();
-	free(rbuf);
 	semanage_list_destroy(&shells);
 
 	return homedir_list;
 
       fail:
 	endpwent();
-	free(rbuf);
 	free(path);
 	semanage_list_destroy(&homedir_list);
 	semanage_list_destroy(&shells);
