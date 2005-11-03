Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA3HDqMA017163
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 12:13:53 -0500 (EST)
Received: from mx53.ms.so-net.ne.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA3H8UhI023317
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 17:08:31 GMT
Received: from admin0 (pd32f49.ykhmac00.ap.so-net.ne.jp [61.211.47.73])
	by mx53.ms.so-net.ne.jp  with SMTP id jA3H8UUC012590
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 02:08:30 +0900 (JST)
Message-ID: <004701c5e099$3777e6b0$0300a8c0@admin0>
From: "shintarou_fujiwara" <shin216@xf7.so-net.ne.jp>
To: "selinux mailing list" <selinux@tycho.nsa.gov>
Subject: antivir policy
Date: Fri, 4 Nov 2005 02:08:31 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0044_01C5E0E4.A72B1130"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0044_01C5E0E4.A72B1130
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi, again from Japan.

I've written down antivir policy for antivir users.

Antivir is downloadable from here.
http://www.free-av.com/


shintarou_fujiwara
------=_NextPart_000_0044_01C5E0E4.A72B1130
Content-Type: application/octet-stream;
	name="antivir.fc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="antivir.fc"

####################for =
antivir###########################################=0A=
/usr/lib/AntiVir       -d   system_u:object_r:antivir_home_t=0A=
/usr/lib/AntiVir/antivir    system_u:object_r:antivir_exec_t=0A=
/usr/lib/AntiVir/antivir\.vdf    system_u:object_r:antivir_pattern_file_t=0A=
/usr/lib/AntiVir/avupdater    system_u:object_r:antivir_bin_t=0A=
/usr/lib/AntiVir/configantivir    system_u:object_r:antivir_bin_t=0A=
/etc/antivir\.conf             system_u:object_r:antivir_conf_t=0A=
/etc/avguard\.conf             system_u:object_r:antivir_conf_t=0A=
=0A=

------=_NextPart_000_0044_01C5E0E4.A72B1130
Content-Type: application/octet-stream;
	name="antivir.te"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="antivir.te"

#############for antivir###############=0A=
daemon_domain(antivir,`,auth_chkpwd')=0A=
=0A=
can_network(antivir_t)=0A=
=0A=
can_exec(antivir_t,bin_t)=0A=
can_exec(antivir_t,sbin_t)=0A=
can_exec(antivir_t,mount_exec_t)=0A=
=0A=
tmp_domain(antivir)=0A=
lock_domain(antivir)=0A=
=0A=
###############types##############################=0A=
type antivir_home_t, file_type, sysadmfile;=0A=
type antivir_bin_t, file_type, sysadmfile, exec_type;=0A=
type antivir_pattern_file_t, file_type, sysadmfile;=0A=
type antivir_conf_t, file_type, sysadmfile;=0A=
type antivir_var_log_t, file_type, sysadmfile;=0A=
=0A=
################basic policy############################=0A=
allow antivir_t antivir_conf_t:file r_file_perms;=0A=
allow antivir_t antivir_home_t:dir r_dir_perms;=0A=
allow antivir_t antivir_pattern_file_t:file r_file_perms;=0A=
allow antivir_t self:fifo_file rw_file_perms;=0A=
allow antivir_t var_log_t:file ra_file_perms;=0A=
=0A=
###########so that antivir can check dir########################=0A=
allow antivir_t boot_t:dir r_dir_perms;=0A=
allow antivir_t bin_t:dir r_dir_perms;=0A=
allow antivir_t sbin_t:dir r_dir_perms;=0A=
allow antivir_t default_t:dir r_dir_perms;=0A=
allow antivir_t home_root_t:dir r_dir_perms;=0A=
allow antivir_t lost_found_t:dir r_dir_perms;=0A=
allow antivir_t mnt_t:dir r_dir_perms;=0A=
allow antivir_t security_t:dir r_dir_perms;=0A=
allow antivir_t sysadm_home_dir_t:dir r_dir_perms;=0A=
allow antivir_t var_log_t:dir r_dir_perms;=0A=
=0A=
#######################others################################=0A=
allow antivir_t antivir_t:unix_dgram_socket  { connect write create };=0A=
allow antivir_t etc_runtime_t:file r_file_perms;=0A=
allow antivir_t etc_t:file r_file_perms;=0A=
allow antivir_t proc_t:file r_file_perms;=0A=

------=_NextPart_000_0044_01C5E0E4.A72B1130--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
