Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA00899
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 10:26:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA19182
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 14:24:37 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id OAA19178
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 14:24:34 GMT
Date: Tue, 8 Oct 2002 16:26:10 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: /proc file context
Message-ID: <20021008162610.B5457@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I noticed that the Debian sid default policy seems to be lacking
file_context entries for /proc. Not a problem if you are using procfs.
If you don't, maybe this patch to file_contexts/types.fc is useful
(all types taken from the procfs.te file).
I'm almost certain these file contexts were present in an earlier
default policy, so it's likely that they just were ommitted.


*** /usr/share/selinux/policy/default/file_contexts/types.fc    Wed Oct  2 02:12:59 2002
--- types.fc    Tue Oct  8 18:17:25 2002
***************
*** 337,339 ****
--- 337,354 ----
  #
  .*/lost\+found(/.*)?          system_u:object_r:lost_found_t

+ #
+ # /proc
+ #
+ /proc(/.*)?                   system_u:object_r:proc_t
+ /proc/kmsg                    system_u:object_r:proc_kmsg_t
+ /proc/kcore                   system_u:object_r:proc_kcore_t
+ /proc/sys(/.*)?                       system_u:object_r:sysctl_t
+ /proc/sys/fs(/.*)?            system_u:object_r:sysctl_fs_t
+ /proc/sys/kernel(/.*)?                system_u:object_r:sysctl_kernel_t
+ /proc/sys/kernel/modprobe     system_u:object_r:sysctl_modprobe_t
+ /proc/sys/net(/.*)?           system_u:object_r:sysctl_net_t
+ /proc/sys/net/unix(/.*)?      system_u:object_r:sysctl_net_unix_t
+ /proc/sys/vm(/.*)?            system_u:object_r:sysctl_vm_t
+ /proc/sys/dev(/.*)?           system_u:object_r:sysctl_dev_t


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
