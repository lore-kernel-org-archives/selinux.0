Message-ID: <421CAF61.20708@redhat.com>
Date: Wed, 23 Feb 2005 11:29:21 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov
Subject: Re: Strange staff role problems...
References: <1109131644.5285.10.camel@cobra.ivg2.net> <1109163626.17298.8.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1109163626.17298.8.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------050207030905020809010303"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050207030905020809010303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Tue, 2005-02-22 at 23:07 -0500, Ivan Gyurdiev wrote:
>  
>
>>What does this mean, exactly, and what can cause it?
>>
>>Feb 22 22:19:15 cobra kernel: inode_doinit_with_dentry:
>>context_to_sid([username]:object_r:staff_home_dir_t) returned 22 for
>>dev=dm-2 ino=324481
>>    
>>
>
>22 == EINVAL.  This means that the security context was invalid with
>respect to the current policy, which typically means that:
>- one of the components (user, role, type) is no longer defined in the
>policy, or
>- the combination of the components is illegal in the policy
>
>Given what you show above, I'd assume that the user is no longer defined
>in the policy.
>
>  
>
>>Something's broken on my machine. I had to reboot,
>>and then gdm said my home directory is missing (which it isn't - 
>>apparently it sees unlabeled context, which doesn't make any sense 
>>either, because ls -Z shows staff_home_dir_t).
>>    
>>
>
>ls -Z (or other applications) will display the on-disk extended
>attribute value, regardless of whether it is valid or not, as the xattr
>API queries the filesystem code, not the security module (other than to
>check permissions for accessing the xattr).  Hence, SELinux may
>internally be treating it as unlabeled due to an invalid context.
>
>  
>
>>Then I enable permissive mode, start X, and it creates unlabeled_t 
>>Xauthority file. Restorecon properly restores that to staff_home_t.
>>    
>>
>
>If the home directory is being treated internally as unlabeled, then any
>files created in it will by default also inherit that label.
>
>  
>
>>What could be the problem?
>>I have all the right users and roles, I think
>>in /etc/selinux/strict/users/local.users
>>    
>>
>
>We only recently introduced support for actually using local.users, by
>adding sepol_genusers(3) to libsepol and modifying load_policy(1) to
>call it prior to loading the policy into the kernel.  At the same time,
>we changed the policy Makefile to no longer pull in local.users upon a
>policy build because it is now being dynamically added to the in-memory
>binary policy image by load_policy(1).  AFAIK, Dan is still working on
>the patch to /sbin/init to likewise call sepol_genusers(3) prior to
>loading the policy into the kernel.  Until that change is made, you'll
>lose any user definitions in local.users upon a reboot until you run
>load_policy, because /sbin/init won't dynamically pull in those entries.
>In the short term, you can either restore the inclusion of local.users
>into your policy build or separately run genpolusers(1) to rebuild the
>binary policy file with local.users included.
>
>  
>
Should be in Rawhide tonight.  I have put it out on my people page
ftp://people.redhat.com/dwalsh/SELinux/Fedora

I have attached the patch.

Dan

--------------050207030905020809010303
Content-Type: text/plain;
 name="sysvinit-2.85-selgenusers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysvinit-2.85-selgenusers.patch"

--- sysvinit-2.85/src/init.c.selgenusers	2005-02-17 19:03:08.000000000 -0500
+++ sysvinit-2.85/src/init.c	2005-02-17 19:03:49.000000000 -0500
@@ -199,9 +199,10 @@
 static int load_policy(int *enforce) 
 {
 	int fd=-1,ret=-1;
+	unsigned data_size;
 	int rc=0, orig_enforce;
 	struct stat sb;
-	void *map;
+	void *map, *data;
 	char policy_file[PATH_MAX];
 	int policy_version=0;
 	FILE *cfg;
@@ -306,8 +307,21 @@
 	}
 
 
+	ret = sepol_genusers(map, sb.st_size, selinux_users_path(), &data, &data_size);
+	if (ret < 0) {
+		if (errno == ENOENT || errno == EINVAL) {
+			/* No booleans file or stale booleans in the file; non-fatal. */
+			log(L_VB,"Warning!  Error while user configuration from %s:  %s\n", selinux_users_path(), strerror(errno));
+			data=map;
+			data_size=sb.st_size;
+		} else {
+			log(L_VB, "Error while setting user configuration from %s:  %s\n", selinux_users_path(), strerror(errno));
+			goto UMOUNT;
+		}
+	}
+
 	/* Set booleans based on a booleans configuration file. */
-	ret = sepol_genbools(map, sb.st_size, selinux_booleans_path());
+	ret = sepol_genbools(data, data_size, selinux_booleans_path());
 	if (ret < 0) {
 		if (errno == ENOENT || errno == EINVAL) {
 			/* No booleans file or stale booleans in the file; non-fatal. */
@@ -320,7 +334,7 @@
 		}
 	}
 	log(L_VB, "Loading security policy\n");
-	ret=security_load_policy(map, sb.st_size);
+	ret=security_load_policy(data, data_size);
 	if (ret < 0) {
 		log(L_VB, "security_load_policy failed\n");
 	}

--------------050207030905020809010303--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
