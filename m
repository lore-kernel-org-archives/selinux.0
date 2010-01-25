Subject: Re: bzip support in libsemanage and out of memory (userspace
 ticket 7)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Manoj Srivastava <manoj.srivastava@stdc.com>
In-Reply-To: <201001242029.o0OKTSbY001470@vivaldi39.register.it>
References: <201001242029.o0OKTSbY001470@vivaldi39.register.it>
Content-Type: text/plain
Date: Mon, 25 Jan 2010 13:55:33 -0500
Message-Id: <1264445733.4297.233.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2010-01-24 at 21:29 +0100, Guido Trentalancia wrote:
> Hi !
> 
> Has anybody had any time to look at this ticket:
> http://userspace.selinuxproject.org/trac/ticket/7 ?
> 
> I have experienced the same issue and verified that the problem is actually triggered by the bzip support (as pointed out by Stephen Smalley back in August). In fact, if I use bzip-blocksize=0 in semanage.conf then the problem disappears...
> 
> Otherwise with a default semanage.conf and bzip enabled, I get:
> 
> libsepol.module_package_read_offsets: offset greater than file size (at 4, offset 200478 -> 8192 (No such file or directory).
> libsemanage.semanage_load_module: Error while reading from module file /etc/selinux/refpolicy/modules/tmp/base.pp. (No such file or directory).
> semodule:  Failed!
> 
> I am using libsepol-2.0.41 and libsemanage-2.0.42.

Looking into this more closely, I believe this is another manifestation
of:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=543915#17

which was ultimately traced down to two issues:
1) A missing offset check in libsepol (fixed in libsepol 2.0.38), and
2) A bug / lack of binary mode support in the fmemopen implementation in
glibc that was later fixed, see:
http://sourceware.org/bugzilla/show_bug.cgi?id=6544

Maybe you have the older glibc still?

Looking at the libsemanage code though, I think we could in fact avoid
any dependency on fmemopen by using the native libsepol support for
operating on a memory region via sepol_policy_file_set_mem(), ala:

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index f09c7cf..fee6644 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1371,16 +1371,12 @@ static int semanage_direct_list(semanage_handle_t * sh,
 		char *data = NULL;
 
 		if ((size = bunzip(sh, fp, &data)) > 0) {
-			fclose(fp);
-			fp = fmemopen(data, size, "rb");
-			if (!fp) {
-				ERR(sh, "Out of memory!");
-				goto cleanup;
-			}
+			sepol_policy_file_set_mem(pf, data, size);
+		} else {
+			rewind(fp);
+			__fsetlocking(fp, FSETLOCKING_BYCALLER);
+			sepol_policy_file_set_fp(pf, fp);
 		}
-		rewind(fp);
-		__fsetlocking(fp, FSETLOCKING_BYCALLER);
-		sepol_policy_file_set_fp(pf, fp);
 		if (sepol_module_package_info(pf, &type, &name, &version)) {
 			fclose(fp);
 			free(data);
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 0a55ce0..1b831bd 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1528,16 +1528,12 @@ static int semanage_load_module(semanage_handle_t * sh, const char *filename,
 	char *data = NULL;
 
 	if ((size = bunzip(sh, fp, &data)) > 0) {
-		fclose(fp);
-		fp = fmemopen(data, size, "rb");
-		if (!fp) {
-			ERR(sh, "Out of memory!");
-			goto cleanup;
-		}
+		sepol_policy_file_set_mem(pf, data, size);
+	} else {
+		rewind(fp);
+		__fsetlocking(fp, FSETLOCKING_BYCALLER);
+		sepol_policy_file_set_fp(pf, fp);
 	}
-	rewind(fp);
-	__fsetlocking(fp, FSETLOCKING_BYCALLER);
-	sepol_policy_file_set_fp(pf, fp);
 	sepol_policy_file_set_handle(pf, sh->sepolh);
 	if (sepol_module_package_read(*package, pf, 0) == -1) {
 		ERR(sh, "Error while reading from module file %s.", filename);



-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
