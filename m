Message-ID: <421CB4F3.5040803@redhat.com>
Date: Wed, 23 Feb 2005 11:53:07 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov
Subject: Re: Strange staff role problems...
References: <1109131644.5285.10.camel@cobra.ivg2.net>	 <1109163626.17298.8.camel@moss-spartans.epoch.ncsc.mil>	 <421CAF61.20708@redhat.com> <1109176324.17298.85.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1109176324.17298.85.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------050705090800030602040005"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050705090800030602040005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Wed, 2005-02-23 at 11:29 -0500, Daniel J Walsh wrote:
>  
>
>>Should be in Rawhide tonight.  I have put it out on my people page
>>ftp://people.redhat.com/dwalsh/SELinux/Fedora
>>
>>I have attached the patch.
>>    
>>
>
>1) data_size should be size_t (same as fix by Ulrich to load_policy).
>
>2) Error message looks like it is missing a verb (while <blank> user
>configuration), and the comment is cut-and-paste from the booleans.
>
>3) Do you really want it to fail completely if sepol_genusers() returns
>an error other than ENOENT or EINVAL (e.g. ENOMEM is possible, EACCES is
>possible if it lacks permission to read the file, ...)?  Likely should
>just always proceed with the original binary policy if there is any
>error from sepol_genusers().  That will let the system come up with
>system_u, user_u, and root for basic recovery.
>
>  
>
Ok try again.

--------------050705090800030602040005
Content-Type: text/plain;
 name="sysvinit-2.85-selgenusers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysvinit-2.85-selgenusers.patch"

--- sysvinit-2.85/src/init.c.selgenusers	2005-02-23 11:47:17.000000000 -0500
+++ sysvinit-2.85/src/init.c	2005-02-23 11:51:07.000000000 -0500
@@ -199,9 +199,10 @@
 static int load_policy(int *enforce) 
 {
 	int fd=-1,ret=-1;
+	size_t data_size;
 	int rc=0, orig_enforce;
 	struct stat sb;
-	void *map;
+	void *map, *data;
 	char policy_file[PATH_MAX];
 	int policy_version=0;
 	FILE *cfg;
@@ -306,8 +307,16 @@
 	}
 
 
+	/* Set SELinux users based on a local.users configuration file. */
+	ret = sepol_genusers(map, sb.st_size, selinux_users_path(), &data, &data_size);
+	if (ret < 0) {
+		log(L_VB,"Warning!  Error while reading user configuration from %s/{local.users,system.users}:  %s\n", selinux_users_path(), strerror(errno));
+		data=map;
+		data_size=sb.st_size;
+	}
+
 	/* Set booleans based on a booleans configuration file. */
-	ret = sepol_genbools(map, sb.st_size, selinux_booleans_path());
+	ret = sepol_genbools(data, data_size, selinux_booleans_path());
 	if (ret < 0) {
 		if (errno == ENOENT || errno == EINVAL) {
 			/* No booleans file or stale booleans in the file; non-fatal. */
@@ -320,7 +329,7 @@
 		}
 	}
 	log(L_VB, "Loading security policy\n");
-	ret=security_load_policy(map, sb.st_size);
+	ret=security_load_policy(data, data_size);
 	if (ret < 0) {
 		log(L_VB, "security_load_policy failed\n");
 	}

--------------050705090800030602040005--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
