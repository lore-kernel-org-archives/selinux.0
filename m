Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA20083
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 17:55:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA06959
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 21:54:20 GMT
Received: from web40014.mail.yahoo.com (web40014.mail.yahoo.com [66.218.78.54])
        by jazzband.ncsc.mil  with SMTP id VAA06951 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 21:54:19 GMT
Message-ID: <20020711215548.37078.qmail@web40014.mail.yahoo.com>
Date: Thu, 11 Jul 2002 14:55:48 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: minilogd.te
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-586041674-1026424548=:37069"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-586041674-1026424548=:37069
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Everyone,

      Here is a domain setup for minilogd, borrowed from klogd.te.

      Status: It Works For Me (tm)

Brad

<snip>

#
# Author: Brad Chapman
#
# Taken from klogd.te, by Stephen Smalley <sds@tislabs.com> and
# Timothy Fraser <tfraser@tislabs.com> (NAI Labs)
#

#################################
#
# Rules for the minilogd_t domain.
#
type minilogd_t, domain, privlog, privmem;
role system_r types minilogd_t;
every_domain(minilogd_t)
type minilogd_exec_t, file_type, sysadmfile, exec_type;

domain_auto_trans(initrc_t, minilogd_exec_t, minilogd_t)

type_transition init_t minilogd_exec_t:process minilogd_t;

type minilogd_tmp_t, file_type, sysadmfile, tmpfile;
file_type_auto_trans(minilogd_t, tmp_t,  minilogd_tmp_t)
type minilogd_var_run_t, file_type, sysadmfile, pidfile;
file_type_auto_trans(minilogd_t, var_run_t, minilogd_var_run_t)

# Use the sys_admin and sys_rawio capabilities.
allow minilogd_t minilogd_t:capability { sys_admin sys_rawio };

# Inherit and use descriptors from init.
allow minilogd_t init_t:fd inherit_fd_perms;

# Write to the console.
allow minilogd_t console_device_t:chr_file rw_file_perms;

# Control syslog and console logging
allow minilogd_t kernel_t:system { syslog_mod syslog_console };

# Allow access to character files and directories
allow { minilogd_t initrc_t } devfs_t:{ chr_file sock_file } { read write
create getattr unlink };
allow { minilogd_t initrc_t } devfs_t:dir { read remove_name };

# Allow minilogd to make sockets and destroy them
allow { minilogd_t initrc_t } devlog_t:unix_stream_socket { create getattr };

</snip>

=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
Sign up for SBC Yahoo! Dial - First Month Free
http://sbc.yahoo.com
--0-586041674-1026424548=:37069
Content-Type: application/octet-stream; name="minilogd.te"
Content-Transfer-Encoding: base64
Content-Description: minilogd.te
Content-Disposition: attachment; filename="minilogd.te"

IwojIEF1dGhvcjogQnJhZCBDaGFwbWFuCiMKIyBUYWtlbiBmcm9tIGtsb2dk
LnRlLCBieSBTdGVwaGVuIFNtYWxsZXkgPHNkc0B0aXNsYWJzLmNvbT4gYW5k
CiMgVGltb3RoeSBGcmFzZXIgPHRmcmFzZXJAdGlzbGFicy5jb20+IChOQUkg
TGFicykKIwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiMK
IyBSdWxlcyBmb3IgdGhlIG1pbmlsb2dkX3QgZG9tYWluLgojCnR5cGUgbWlu
aWxvZ2RfdCwgZG9tYWluLCBwcml2bG9nLCBwcml2bWVtOwpyb2xlIHN5c3Rl
bV9yIHR5cGVzIG1pbmlsb2dkX3Q7CmV2ZXJ5X2RvbWFpbihtaW5pbG9nZF90
KQp0eXBlIG1pbmlsb2dkX2V4ZWNfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxl
LCBleGVjX3R5cGU7Cgpkb21haW5fYXV0b190cmFucyhpbml0cmNfdCwgbWlu
aWxvZ2RfZXhlY190LCBtaW5pbG9nZF90KQoKdHlwZV90cmFuc2l0aW9uIGlu
aXRfdCBtaW5pbG9nZF9leGVjX3Q6cHJvY2VzcyBtaW5pbG9nZF90OwoKdHlw
ZSBtaW5pbG9nZF90bXBfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlLCB0bXBm
aWxlOwpmaWxlX3R5cGVfYXV0b190cmFucyhtaW5pbG9nZF90LCB0bXBfdCwg
IG1pbmlsb2dkX3RtcF90KQp0eXBlIG1pbmlsb2dkX3Zhcl9ydW5fdCwgZmls
ZV90eXBlLCBzeXNhZG1maWxlLCBwaWRmaWxlOwpmaWxlX3R5cGVfYXV0b190
cmFucyhtaW5pbG9nZF90LCB2YXJfcnVuX3QsIG1pbmlsb2dkX3Zhcl9ydW5f
dCkKCiMgVXNlIHRoZSBzeXNfYWRtaW4gYW5kIHN5c19yYXdpbyBjYXBhYmls
aXRpZXMuCmFsbG93IG1pbmlsb2dkX3QgbWluaWxvZ2RfdDpjYXBhYmlsaXR5
IHsgc3lzX2FkbWluIHN5c19yYXdpbyB9OwoKIyBJbmhlcml0IGFuZCB1c2Ug
ZGVzY3JpcHRvcnMgZnJvbSBpbml0LgphbGxvdyBtaW5pbG9nZF90IGluaXRf
dDpmZCBpbmhlcml0X2ZkX3Blcm1zOwoKIyBXcml0ZSB0byB0aGUgY29uc29s
ZS4KYWxsb3cgbWluaWxvZ2RfdCBjb25zb2xlX2RldmljZV90OmNocl9maWxl
IHJ3X2ZpbGVfcGVybXM7CgojIENvbnRyb2wgc3lzbG9nIGFuZCBjb25zb2xl
IGxvZ2dpbmcKYWxsb3cgbWluaWxvZ2RfdCBrZXJuZWxfdDpzeXN0ZW0geyBz
eXNsb2dfbW9kIHN5c2xvZ19jb25zb2xlIH07CgojIEFsbG93IGFjY2VzcyB0
byBjaGFyYWN0ZXIgZmlsZXMgYW5kIGRpcmVjdG9yaWVzCmFsbG93IHsgbWlu
aWxvZ2RfdCBpbml0cmNfdCB9IGRldmZzX3Q6eyBjaHJfZmlsZSBzb2NrX2Zp
bGUgfSB7IHJlYWQgd3JpdGUgY3JlYXRlIGdldGF0dHIgdW5saW5rIH07CmFs
bG93IHsgbWluaWxvZ2RfdCBpbml0cmNfdCB9IGRldmZzX3Q6ZGlyIHsgcmVh
ZCByZW1vdmVfbmFtZSB9OwoKIyBBbGxvdyBtaW5pbG9nZCB0byBtYWtlIHNv
Y2tldHMgYW5kIGRlc3Ryb3kgdGhlbQphbGxvdyB7IG1pbmlsb2dkX3QgaW5p
dHJjX3QgfSBkZXZsb2dfdDp1bml4X3N0cmVhbV9zb2NrZXQgeyBjcmVhdGUg
Z2V0YXR0ciB9Owo=

--0-586041674-1026424548=:37069--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
