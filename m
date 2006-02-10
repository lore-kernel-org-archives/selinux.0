Message-ID: <43EBDC77.5000503@cornell.edu>
Date: Thu, 09 Feb 2006 19:21:11 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Semanage/libsemanage seems to be broken.
References: <43EBCED7.3040305@redhat.com> <43EBD634.1000708@cornell.edu>
In-Reply-To: <43EBD634.1000708@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------010403070404080404010802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010403070404080404010802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ivan Gyurdiev wrote:
>
>> # semanage user -a -rSystemLow-SystemHigh -R user_r -R sysadm_r walsh_u
>> # semaage user -d walsh_u
> I assume this was misspelled in the email only.
>> # semanage user -l
>>                MLS/       MLS/
>> SELinux User    MCS Level  MCS Range                      SELinux Roles
>>
>> lwalsh          None       None
>> root            s0         SystemLow-SystemHigh           system_r 
>> sysadm_r user_r
>> rwalsh          s0         s0                             system_r 
>> sysadm_r user_r
>> system_u        s0         SystemLow-SystemHigh           system_r
>> twalsh          s0         s0                             user_r
>> user_u          s0         SystemLow-SystemHigh           system_r 
>> sysadm_r user_r
>> walsh_u         None       None
>>
>>
>> #semanage user -d walsh_u
>> /usr/sbin/semanage: SELinux user walsh_u is defined in policy, cannot 
>> be deleted
>>
>> #semanage user -a -rSystemLow-SystemHigh -R user_r -R sysadm_r walsh_u
>> /usr/sbin/semanage: SELinux user walsh_u is already defined
> Hmm.... are you shipping the prefix file for genhomedircon yet?
>
> This appears to be caused by the users_extra file not getting cleared 
> on policy rebuild.
> I used to always clear this file. However, after Joshua's patch to 
> support the users extra file in the package format, this was changed 
> to not clear the file. The idea was that on commit(), that file would 
> get overwritten by the users_extra settings from the policy package.
>
> However, I expected this to be a required file. Is this not the case?
> If the users_extra is not a required section of the module package, 
> then perhaps we should explicitly clear that file on rebuild.
> The same argument applies to the seusers file, and the file contexts 
> file. Are those sections optional?
The attached patch should fix the problem - it treats seusers and 
users_extra as optional sections. If they are not present, the 
corresponding dbase is cleared. File contexts appear to be requred (no 
len == 0 check).

--------------010403070404080404010802
Content-Type: text/x-patch;
 name="libsemanage.opt_seusers_extra.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.opt_seusers_extra.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-02-08 03:20:08.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2006-02-09 19:14:15.000000000 -0500
@@ -475,7 +475,7 @@ static int semanage_direct_commit(semana
 
 		/* ==================== File-backed ================== */
 
-		/* write the linked file contexts template */
+		/* File Contexts */
 		if ((ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL)) == NULL ||
 		    write_file(sh, ofilename, sepol_module_package_get_file_contexts(base), 
 				sepol_module_package_get_file_contexts_len(base)) == -1) {
@@ -484,29 +484,36 @@ static int semanage_direct_commit(semana
 
 		if (semanage_split_fc(sh)) 
 			goto cleanup;
-	
+
+		pfcontexts->dtable->drop_cache(pfcontexts->dbase);
+
+		/* Seusers */
 		if (sepol_module_package_get_seusers_len(base)) {
 			if ((ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS)) == NULL ||
 			    write_file(sh, ofilename, sepol_module_package_get_seusers(base), 
 					sepol_module_package_get_seusers_len(base)) == -1) {
 				goto cleanup;
 			}
+			pseusers->dtable->drop_cache(pseusers->dbase);
+
+		} else {
+			if (pseusers->dtable->clear(sh, pseusers->dbase) < 0)
+				goto cleanup;
 		}
 
+		/* Users_extra */
 		if (sepol_module_package_get_user_extra_len(base)) {
 			if ((ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_USER_EXTRA)) == NULL ||
 			    write_file(sh, ofilename, sepol_module_package_get_user_extra(base), 
 					sepol_module_package_get_user_extra_len(base)) == -1) {
 				goto cleanup;
 			}
-		}
+			pusers_extra->dtable->drop_cache(pusers_extra->dbase);
 
-		/* Drop any cached content for file_contexts, seusers, or users_extra,
-	 	 * since it is now superceded by the files just written, and needs to be
-		 * re-cached */
-		pfcontexts->dtable->drop_cache(pfcontexts->dbase);
-		pseusers->dtable->drop_cache(pseusers->dbase);
-		pusers_extra->dtable->drop_cache(pusers_extra->dbase);
+		} else {
+			if (pusers_extra->dtable->clear(sh, pusers_extra->dbase) < 0)
+				goto cleanup;
+		}
 
 		/* ==================== Policydb-backed ================ */
 

--------------010403070404080404010802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
