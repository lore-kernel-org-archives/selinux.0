Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81GrSrT022592
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 12:53:28 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81GqdY2014486
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 16:52:39 GMT
Subject: Re: udev policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200409011753.01483.russell@coker.com.au>
References: <200409011753.01483.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1094057500.13328.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 01 Sep 2004 12:51:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-01 at 03:53, Russell Coker wrote:
> The attached patch allows udev in rawhide to work properly with no audit 
> messages.

--- /usr/src/se/policy/domains/program/unused/udev.te	2004-09-01 10:52:36.000000000 +1000
+++ domains/program/unused/udev.te	2004-09-01 17:51:52.000000000 +1000
@@ -43,7 +43,8 @@
 allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
 	
 # to read the file_contexts file
-r_dir_file(udev_t, { selinux_config_t file_context_t default_context_t } )
+allow udev_t { selinux_config_t default_context_t file_context_t }:dir search;
+allow udev_t { selinux_config_t file_context_t }:file { getattr read };
 
 allow udev_t policy_config_t:dir { search };
 allow udev_t proc_t:file { read };

What's wrong with using r_dir_file here?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
