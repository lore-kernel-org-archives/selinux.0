Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12EEX53022540
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 09:14:33 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j12ECFVb002894
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 14:12:24 GMT
Subject: Re: File Browsing apps and getattr
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1107350096.890.78.camel@moss-spartans.epoch.ncsc.mil>
References: <1107210369.1928.5.camel@cobra.ivg2.net>
	 <1107259894.26936.27.camel@moss-spartans.epoch.ncsc.mil>
	 <1107263308.6722.5.camel@cobra.ivg2.net>
	 <1107263499.26936.50.camel@moss-spartans.epoch.ncsc.mil>
	 <1107264384.6956.2.camel@cobra.ivg2.net>
	 <1107264676.26936.63.camel@moss-spartans.epoch.ncsc.mil>
	 <1107283354.7117.13.camel@cobra.ivg2.net>
	 <1107287529.26936.231.camel@moss-spartans.epoch.ncsc.mil>
	 <1107301148.3429.10.camel@cobra.ivg2.net>
	 <1107345834.890.9.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350380.7449.2.camel@cobra.ivg2.net>
	 <1107350096.890.78.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-wU3vVtjttkb9PckEwomP"
Date: Wed, 02 Feb 2005 07:14:31 -0700
Message-Id: <1107353672.7808.3.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-wU3vVtjttkb9PckEwomP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-02-02 at 08:14 -0500, Stephen Smalley wrote:
> On Wed, 2005-02-02 at 08:19, Ivan Gyurdiev wrote:
> > It was a general question, regardless of the specific type. 
> > I thought perhaps shadow_t would be a security type, and would produce
> > denials when I do ls -l /etc. What would you consider a
> > security type?
> 
> Yes, shadow_t would fall into that class.  So at that point you might
> dontaudit attempts to getattr it from user domains, while leaving them
> audited for the daemon domains.

Patch for user_macros.te and samba_macros.te attached.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-wU3vVtjttkb9PckEwomP
Content-Disposition: attachment; filename=samba.patch
Content-Type: text/x-patch; name=samba.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- samba_macros.te	2005-02-02 07:05:30.000000000 -0700
+++ samba_macros.new	2005-02-02 07:05:14.000000000 -0700
@@ -21,6 +21,7 @@
 if ( samba_enable_home_dirs ) {
 allow smbd_t home_root_t:dir r_dir_perms;
 file_type_auto_trans(smbd_t, $1_home_dir_t, $1_home_t)
+dontaudit smbd_t $1_file_type:dir_file_class_set getattr;
 }
 ')
 ', `

--=-wU3vVtjttkb9PckEwomP
Content-Disposition: attachment; filename=user.patch
Content-Type: text/x-patch; name=user.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- user_macros.te	2005-02-02 07:07:32.000000000 -0700
+++ user_macros.new	2005-02-02 07:08:00.000000000 -0700
@@ -93,8 +93,8 @@
 # Do not audit write denials to utmp to avoid the noise.
 dontaudit $1_t initrc_var_run_t:file write;
 
-# do not audit getattr on tmpfile, otherwise ls -l /tmp fills the logs
-dontaudit $1_t tmpfile:dir_file_class_set getattr;
+# do not audit getattr on dir/files to prevent ls -l denials
+dontaudit $1_t file_type:dir_file_class_set getattr; 
 
 # do not audit getattr on disk devices, otherwise KDE fills the logs
 dontaudit $1_t { removable_device_t fixed_disk_device_t }:blk_file {getattr read};

--=-wU3vVtjttkb9PckEwomP--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
