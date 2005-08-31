Subject: Re: Another place where policy blows up because of translations in
	MCS.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, James Morris <jmorris@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1125497296.18888.287.camel@moss-spartans.epoch.ncsc.mil>
References: <43148322.5030201@redhat.com>
	 <1125418171.18888.138.camel@moss-spartans.epoch.ncsc.mil>
	 <4314958B.5000602@redhat.com>
	 <1125493031.18888.238.camel@moss-spartans.epoch.ncsc.mil>
	 <1125497296.18888.287.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-5xB4do3CrnQ7kAM0FOCG"
Date: Wed, 31 Aug 2005 10:22:15 -0400
Message-Id: <1125498135.18888.291.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-5xB4do3CrnQ7kAM0FOCG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-08-31 at 10:08 -0400, Stephen Smalley wrote:
> Note that we wouldn't want to require setfiles to link against
> libsetrans, as there is no upstream libsetrans and it is optional.
> Hence, either setfiles would need to dlopen libsetrans in the same
> manner as libselinux to access the translation functions or libselinux
> needs to export wrapper functions for the translation functions it has
> already looked up from libsetrans.  The latter seems simpler, but
> requires that we add such functions to libselinux that are exported and
> have proper namespace prefixes, unlike the hidden
> trans_to_raw_context/raw_to_trans_context functions.  The exported
> functions would also need to internally check the context_translations
> flag unlike the current trans_to_raw_context/raw_to_trans_context
> functions.

See the attached patches for libselinux and setfiles.  Does this address
the issue?  Is it the right approach (i.e. keeping libsepol
translation-unaware and handling this in setfiles)?

-- 
Stephen Smalley
National Security Agency

--=-5xB4do3CrnQ7kAM0FOCG
Content-Disposition: attachment; filename=libselinux-trans.patch
Content-Type: text/x-patch; name=libselinux-trans.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/selinux.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/include/selinux/selinux.h,v
retrieving revision 1.42
diff -u -p -r1.42 selinux.h
--- libselinux/include/selinux/selinux.h	24 Aug 2005 19:56:29 -0000	1.42
+++ libselinux/include/selinux/selinux.h	31 Aug 2005 14:15:13 -0000
@@ -344,6 +344,14 @@ extern int rpm_execcon(unsigned int veri
    be relabeled . */
 extern int is_context_customizable (security_context_t scontext);
 
+/* Perform context translation between the human-readable format
+   ("translated") and the internal system format ("raw"). 
+   Caller must free the resulting context.  
+   Returns -1 upon an error or 0 otherwise.
+   If passed NULL, sets the returned context to NULL and returns 0. */
+extern int selinux_trans_to_raw_context(char *trans, char **rawp);
+extern int selinux_raw_to_trans_context(char *raw, char **transp);
+
 #ifdef __cplusplus
 }
 #endif
Index: libselinux/src/trans.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/trans.c,v
retrieving revision 1.4
diff -u -p -r1.4 trans.c
--- libselinux/src/trans.c	25 Aug 2005 14:11:39 -0000	1.4
+++ libselinux/src/trans.c	31 Aug 2005 14:12:15 -0000
@@ -16,6 +16,20 @@ int hidden trans_to_raw_context(char *tr
 	return *rawp ? 0 : -1;
 }
 
+int selinux_trans_to_raw_context(char *trans, char **rawp)
+{
+	if (context_translations)
+		return trans_to_raw_context(trans, rawp);
+
+	if (!trans) {
+		*rawp = NULL;
+		return 0;
+	}
+
+	*rawp = strdup(trans);
+	return *rawp ? 0 : -1;
+}
+
 int hidden raw_to_trans_context(char *raw, char **transp) 
 {
 	*transp = NULL;
@@ -28,3 +42,16 @@ int hidden raw_to_trans_context(char *ra
 	return *transp ? 0 : -1;
 }
 
+int selinux_raw_to_trans_context(char *raw, char **transp)
+{
+	if (context_translations)
+		return raw_to_trans_context(raw, transp);
+
+	if (!raw) {
+		*transp = NULL;
+		return 0;
+	}
+
+	*transp = strdup(raw);
+	return *transp ? 0 : -1;
+}

--=-5xB4do3CrnQ7kAM0FOCG
Content-Disposition: attachment; filename=setfiles-trans.patch
Content-Type: text/x-patch; name=setfiles-trans.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/setfiles/setfiles.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/setfiles/setfiles.c,v
retrieving revision 1.35
diff -u -p -r1.35 setfiles.c
--- policycoreutils/setfiles/setfiles.c	8 Apr 2005 12:27:08 -0000	1.35
+++ policycoreutils/setfiles/setfiles.c	31 Aug 2005 14:16:15 -0000
@@ -387,7 +387,11 @@ int invalidcon(const char *path, unsigne
 	int valid = 1;
 
 	if (policyfile) {
-		valid = (sepol_check_context ((char *) context) >= 0);
+		char *raw;
+		if (selinux_trans_to_raw_context((char*)context, &raw))
+			valid = 0;
+		if (valid)
+			valid = (sepol_check_context (raw) >= 0);
 	} else if (security_check_context((char *) context) < 0 && errno != ENOENT) {
 		valid = 0;
 		inc_err();

--=-5xB4do3CrnQ7kAM0FOCG--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
