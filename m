Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7MGhueX002374
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 12:43:56 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7MGhtca027098
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 16:43:55 GMT
In-Reply-To: <1187721931.13874.37.camel@gorn>
References: <477DC293-F96F-4AFB-AD19-E66C80CC3AB4@sf-net.com> <1187721931.13874.37.camel@gorn>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-2--959567823
Message-Id: <D041BDDB-B989-4DA5-B312-5D9387DE8A9A@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: [refpolicy] selinuxutils (semodule)
Date: Wed, 22 Aug 2007 18:43:49 +0200
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-2--959567823
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


On 21.08.2007, at 20:45, Christopher J. PeBenito wrote:
>
>> Attached is a patch which solves this. I added the allow rules
>> without a debian distribution check. Maybe we should allow it only to
>> debian?
>
> Yes, it should be in a distro_debian, since this is definitely a
> debian-specific access, since the .py is in a different location.

OK, attached is the right patch with a distro_debian check.


--Apple-Mail-2--959567823
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=selinuxutil.te.patch
Content-Disposition: attachment;
	filename=selinuxutil.te.patch

--- /usr/src/refpolicy-20070629/policy/modules/system/selinuxutil.te	2007-06-29 16:48:13.000000000 +0200
+++ policy/modules/system/selinuxutil.te	2007-08-22 18:37:38.000000000 +0200
@@ -479,6 +479,11 @@
 files_read_usr_files(semanage_t)
 files_list_pids(semanage_t)
 
+ifdef(`distro_debian',`
+	files_read_var_lib_files(semanage_t)
+	files_read_var_lib_symlinks(semanage_t)
+')
+
 mls_file_write_down(semanage_t)
 mls_rangetrans_target(semanage_t)
 mls_file_read_up(semanage_t)
@@ -518,6 +523,8 @@
 
 userdom_search_sysadm_home_dirs(semanage_t)
 
+selinux_dontaudit_getattr_fs(semanage_t)
+
 # cjp: need a more general way to handle this:
 ifdef(`enable_mls',`
 	# read secadm tmp files

--Apple-Mail-2--959567823--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
