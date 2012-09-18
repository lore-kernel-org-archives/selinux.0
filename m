Message-ID: <1347994362.31966.109.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seandroid and policy version
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        Joman Chu
	 <jcchu@tycho.ncsc.mil>
Date: Tue, 18 Sep 2012 14:52:42 -0400
In-Reply-To: <CAFftDdorhQYcJ4_76cFg-Nj49vLNJYkKHyM=Zz6RvZ+3jH31vw@mail.gmail.com>
References: <4FFCC3C7.8080602@tresys.com>
	 <1342011045.29461.28.camel@moss-pluto.epoch.ncsc.mil>
	 <4FFDD7C7.4020703@tresys.com>
	 <1342036191.29461.75.camel@moss-pluto.epoch.ncsc.mil>
	 <1347989611.31966.66.camel@moss-pluto.epoch.ncsc.mil>
	 <CAFftDdqjtYd0RGoZ12dcJnyWpD42MPYf_KwkJitwYcaF=+ptgA@mail.gmail.com>
	 <CAFftDdpDkSWWzgKiCyTLuJpAZNRtihgmoRE0WhBcbGa2tdfwPA@mail.gmail.com>
	 <1347992127.31966.93.camel@moss-pluto.epoch.ncsc.mil>
	 <CAFftDdorhQYcJ4_76cFg-Nj49vLNJYkKHyM=Zz6RvZ+3jH31vw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-1WllALMm6sKOHW5/ot78"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1WllALMm6sKOHW5/ot78
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Attached are patches for libselinux and sepolicy to drop the policy
version suffix.  We still force generation of a version 24 policy by
default, although this can be overridden via make command-line or
environment setting (e.g. export POLICYVERS=26).  Does this seem sane?
Note that seandroid-4.0.4 requires changes to system/core as well, so
this only fixes it for master and 4.1.1.


-- 
Stephen Smalley
National Security Agency

--=-1WllALMm6sKOHW5/ot78
Content-Disposition: attachment; filename="libselinux-dropverssuffix.diff"
Content-Type: text/x-patch; name="libselinux-dropverssuffix.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/src/android.c b/src/android.c
index ae3f624..af6c79c 100644
--- a/src/android.c
+++ b/src/android.c
@@ -36,7 +36,7 @@ static const struct selinux_opt seopts[] = {
 	{ SELABEL_OPT_PATH, "/file_contexts" },
 	{ 0, NULL } };
 
-static const char *const sepolicy_prefix[] = {
+static const char *const sepolicy_file[] = {
         "/data/system/sepolicy",
         "/sepolicy",
         0 };
@@ -671,29 +671,15 @@ struct selabel_handle* selinux_android_file_context_handle(void)
 int selinux_android_reload_policy(void)
 {
 	char path[PATH_MAX];
-	int fd = -1, rc, vers;
+	int fd = -1, rc;
 	struct stat sb;
 	void *map = NULL;
 	int i = 0;
 
-	vers = security_policyvers();
-	if (vers <= 0) {
-		selinux_log(SELINUX_ERROR, "SELinux:  Unable to read policy version\n");
-		return -1;
-	}
-	selinux_log(SELINUX_INFO, "SELinux:  Maximum supported policy version:  %d\n", vers);
-
-	while (fd < 0 && sepolicy_prefix[i]) {
-		snprintf(path, sizeof(path), "%s.%d",
-			sepolicy_prefix[i], vers);
+	while (fd < 0 && sepolicy_file[i]) {
+		snprintf(path, sizeof(path), "%s",
+			sepolicy_file[i]);
 		fd = open(path, O_RDONLY);
-
-		int max_vers = vers;
-		while (fd < 0 && errno == ENOENT && --max_vers) {
-			snprintf(path, sizeof(path), "%s.%d",
-				sepolicy_prefix[i], max_vers);
-			fd = open(path, O_RDONLY);
-		}
 		i++;
 	}
 	if (fd < 0) {

--=-1WllALMm6sKOHW5/ot78
Content-Disposition: attachment; filename="sepolicy-dropverssuffix.diff"
Content-Type: text/x-patch; name="sepolicy-dropverssuffix.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/Android.mk b/Android.mk
index 194dbf7..d3b21bb 100644
--- a/Android.mk
+++ b/Android.mk
@@ -9,7 +9,7 @@ include $(CLEAR_VARS)
 # SELinux policy version.
 # Must be <= /selinux/policyvers reported by the Android kernel.
 # Must be within the compatibility range reported by checkpolicy -V.
-POLICYVERS := 24
+POLICYVERS ?= 24
 
 MLS_SENS=1
 MLS_CATS=1024
@@ -31,7 +31,6 @@ include $(CLEAR_VARS)
 LOCAL_MODULE := sepolicy
 LOCAL_MODULE_CLASS := ETC
 LOCAL_MODULE_TAGS := optional
-LOCAL_MODULE_SUFFIX := .$(POLICYVERS)
 LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
 
 include $(BUILD_SYSTEM)/base_rules.mk
@@ -79,9 +78,9 @@ $(seapp_contexts.tmp): $(LOCAL_PATH)/seapp_contexts $(LOCAL_POLICY_SC)
 	@mkdir -p $(dir $@)
 	$(hide) m4 -s $^ > $@
 
-$(LOCAL_BUILT_MODULE) : $(seapp_contexts.tmp) $(TARGET_ROOT_OUT)/sepolicy.$(POLICYVERS) $(HOST_OUT_EXECUTABLES)/checkseapp
+$(LOCAL_BUILT_MODULE) : $(seapp_contexts.tmp) $(TARGET_ROOT_OUT)/sepolicy $(HOST_OUT_EXECUTABLES)/checkseapp
 	@mkdir -p $(dir $@)
-	$(HOST_OUT_EXECUTABLES)/checkseapp -p $(TARGET_ROOT_OUT)/sepolicy.24 -o $@ $<
+	$(HOST_OUT_EXECUTABLES)/checkseapp -p $(TARGET_ROOT_OUT)/sepolicy -o $@ $<
 
 seapp_contexts.tmp :=
 ##################################

--=-1WllALMm6sKOHW5/ot78--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
