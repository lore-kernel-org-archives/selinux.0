Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6U8F5gA006625
	for <selinux@tycho.nsa.gov>; Sat, 30 Jul 2005 04:15:07 -0400 (EDT)
Received: from mx05.ms.so-net.ne.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6U8867R029065
	for <selinux@tycho.nsa.gov>; Sat, 30 Jul 2005 08:08:07 GMT
Received: from admin0 (pdd5cde.ykhmac00.ap.so-net.ne.jp [218.221.92.222])
	by mx05.ms.so-net.ne.jp  with SMTP id j6U88vS1007262
	for <selinux@tycho.nsa.gov>; Sat, 30 Jul 2005 17:08:57 +0900 (JST)
Message-ID: <002201c594dd$eee47500$0300a8c0@admin0>
From: "shintarou_fujiwara" <shin216@xf7.so-net.ne.jp>
To: "selinux mailing list" <selinux@tycho.nsa.gov>
Subject: no-ip policy
Date: Sat, 30 Jul 2005 17:08:56 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001F_01C59529.5E7B16D0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_001F_01C59529.5E7B16D0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi , I'm shin from JAPAN .

 I'm working on a private home-server by FC3 using no-ip DNS services. Here 
I'v written down a policy for it.
Any comments ?

------=_NextPart_000_001F_01C59529.5E7B16D0
Content-Type: application/octet-stream;
	name="noip.fc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="noip.fc"

####################for noip##########################=0A=
/usr/local/bin/noip2    system_u:object_r:noip_exec_t=0A=
/usr/local/etc/no-ip2\.conf    system_u:object_r:noip_conf_t=0A=
=0A=

------=_NextPart_000_001F_01C59529.5E7B16D0
Content-Type: application/octet-stream;
	name="noip.te"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="noip.te"

#############for noip###############=0A=
daemon_domain(noip)=0A=
=0A=
type noip_conf_t,file_type,sysadmfile;=0A=
=0A=
can_network(noip_t)=0A=
uses_shlib(noip_t)=0A=
base_file_read_access(noip_t)=0A=
tmpfs_domain(noip)=0A=
rw_dir_file(noip_t,noip_conf_t)=0A=
=0A=
allow noip_t noip_t:shm create_shm_perms;=0A=
allow noip_t noip_t:socket_class_set create_stream_socket_perms;=0A=
allow noip_t kernel_t:fd { use };=0A=
allow noip_t etc_t:file { read };=0A=
allow noip_t etc_t:file { getattr };=0A=
allow noip_t noip_t:capability { setgid };=0A=
allow noip_t noip_t:capability { setuid };=0A=

------=_NextPart_000_001F_01C59529.5E7B16D0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
