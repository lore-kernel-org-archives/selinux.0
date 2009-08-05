Message-ID: <COL109-W39067F81436136C713D091AB0D0@phx.gbl>
Content-Type: multipart/mixed;
	boundary="_bcefabe7-c239-4213-aec7-9cd0b3f29aad_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: Questions about TE rules in refpolicy-20081210
Date: Wed, 5 Aug 2009 09:30:41 +0000
In-Reply-To: <COL109-W6450505A63B6FB2820C44EAB0D0@phx.gbl>
References: <COL109-W6450505A63B6FB2820C44EAB0D0@phx.gbl>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_bcefabe7-c239-4213-aec7-9cd0b3f29aad_
Content-Type: multipart/alternative;
	boundary="_7f36edb9-0b07-44b7-b16b-7da94f01a2fc_"

--_7f36edb9-0b07-44b7-b16b-7da94f01a2fc_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Oops I clicked the send button too quickly to attach the patches.

Cheers,

Harry

From: harrytaurus2002@hotmail.com
To: sds@tycho.nsa.gov
CC: selinux@tycho.nsa.gov
Subject: Questions about TE rules in refpolicy-20081210
Date: Wed, 5 Aug 2009 09:11:31 +0000








Hi Smalley,

Thank you very much for the selinux kernel patch, after applying it I finally could boot up refpolicy-20081210 uneventfully - all error messages about udevd and mingetty are simply disappeared!

Well, when I play with refpolicy-20081210 with MLS enabled, I run into several issues and I am not clear if they are deliberately designed to be this way or they might be potential problems, I certainly don't want to open any security holes so I would very much like to discuss with you about them, thanks again!

1, after log in, if I do "mount" then it will display nothing, neither "cat /etc/mtab" would show anything;

I think this is due to the mount_t type has no rights to write into /etc/mtab, which is of etc_runtime_t type.
I know we have called files_manage_etc_runtime_files(mount_t) in mount.te, but only after I added files_rw_etc_runtime_files(mount_t) would the mount program be able to write into /etc/mtab. Also, we may have to call fil!
 es_manage_generic_locks(mount_t) so that mount_t could grab related /var/lock/mtab~ successfully.

The whole scenario is logged below and the patch is attached:

root@d610-2:/root> id -Z
root:sysadm_r:sysadm_t:s0-s15:c0.c255
root@d610-2:/root> semodule -u mount.pp 
semodule: SELinux policy is not managed or store cannot be accessed.
root@d610-2:/root> semodule -l | grep mount
semodule: SELinux policy is not managed or store cannot be accessed.
root@d610-2:/root> newrole -r secadm_r
Password: 
bash: /root/.profile: Permission denied
root@d610-2:~# /usr/sbin/semodule -l | grep mount
automount    1.11.0
mount    1.10.0
root@d610-2:~# /usr/sbin/semodule -u mount.pp 
/usr/sbin/semodule:  Could not read file 'mount.pp': Permission denied
root@d610-2:~# /usr/sbin/getenforce 
Enforcing
root@d610-2:~# /usr/sbin/setenforce 0
root@d610-2:~# /usr/sbin/getenforce 
Permissiveroot@d610-2:~# /usr/sbin/semodule -u mount.pp 
root@d610-2:~# /u
sr/sbin/semodule -l | grep mount
automount    1.11.0
mount    1.10.1        # updated!!!
root@d610-2:~# mount
root@d610-2:~# cat /etc/mtab
root@d610-2:~# /sbin/reboot
(rebooting...)
root@d610-2:/root> id -Z
root:sysadm_r:sysadm_t:s0-s15:c0.c255
root@d610-2:/root> getenforce 
Enforcing
root@d610-2:/root> mount
rootfs on / type rootfs (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw)
tmpfs on /dev/shm type tmpfs (rw)
root@d610-2:/root> cat /etc/mtab
rootfs / rootfs rw 0 0
proc /proc proc rw 0 0
sysfs /sys sysfs rw 0 0
devpts /dev/pts devpts rw 0 0
tmpfs /dev/shm tmpfs rw 0 0
root@d610-2:/root> 

2, if log in the root user through serial console, I would be unable to assume another administrator roles(auditadm_r, secadm_r) by the newrole program, the error message says that newrole!
  is unable to relabel the /dev/console device.

So far the contents of the securetty_types file are all about X_tty_device_t, where X could be of any administrator's role or staff or unprivileged user, it would be enough if log in through local /dev/ttyN device by Ctl+Alt+FN. However, if I want to use newrole on the serial console, I think I would have to mark it as secure device by appending its type of console_device_t to the securetty_types file.

Aside from that, I have to call term_relabel_console(newrole_t) so that newrole_t would have necessary permissions to relabelto or relabelfrom the /dev/console.

The patch is attched.

3, The /root/ directory is used to be labeled as "sysadm_home_t" or "sysadm_home_dir_t", but I found them are labeled as default_t now and it seems that only the sysadm_t has read permission to the /root/ directory. If I assume another administrator role such as secadm_r, then secadm_t would have trouble to read or write /!
 root/:

root@d610-2:/root> id -Z
root:sysadm_r:sysadm_t:s0
-s15:c0.c255
root@d610-2:/root> newrole -r secadm_r
Password: 
bash: /root/.profile: Permission denied    
root@d610-2:~# id -Z
root:secadm_r:secadm_t:s0-s15:c0.c255
root@d610-2:~# touch 1
touch: cannot touch `1': Permission denied
root@d610-2:~#

Shouldn't secadm_t and auditadm_t also have enough rights to the /root/ directory?

Looking forward to any of your comments!

Best regards,

Harry


与任何您希望的人分享您的回忆。 任何您希望的人。
_________________________________________________________________
与任何您希望的人分享您的回忆。
http://www.microsoft.com/china/windows/windowslive/products/photos-share.aspx?tab=1
--_7f36edb9-0b07-44b7-b16b-7da94f01a2fc_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
</style>
</head>
<body class='hmmessage'>
Oops I clicked the send button too quickly to attach the patches.<br><br>Cheers,<br><br>Harry<br><br><hr id="stopSpelling">From: harrytaurus2002@hotmail.com<br>To: sds@tycho.nsa.gov<br>CC: selinux@tycho.nsa.gov<br>Subject: Questions about TE rules in refpolicy-20081210<br>Date: Wed, 5 Aug 2009 09:11:31 +0000<br><br>



<style>
.ExternalClass .EC_hmmessage P
{padding:0px;}
.ExternalClass body.EC_hmmessage
{font-size:10pt;font-family:Verdana;}
</style>


Hi Smalley,<br><br>Thank you very much for the selinux kernel patch, after applying it I finally could boot up refpolicy-20081210 uneventfully - all error messages about udevd and mingetty are simply disappeared!<br><br>Well, when I play with refpolicy-20081210 with MLS enabled, I run into several issues and I am not clear if they are deliberately designed to be this way or they might be potential problems, I certainly don't want to open any security holes so I would very much like to discuss with you about them, thanks again!<br><br>1, after log in, if I do "mount" then it will display nothing, neither "cat /etc/mtab" would show anything;<br><br>I think this is due to the mount_t type has no rights to write into /etc/mtab, which is of etc_runtime_t type.<br>I know we have called files_manage_etc_runtime_files(mount_t) in mount.te, but only after I added files_rw_etc_runtime_files(mount_t) would the mount program be able to write into /etc/mtab. Also, we may have to call fil!
 es_manage_generic_locks(mount_t) so that mount_t could grab related /var/lock/mtab~ successfully.<br><br>The whole scenario is logged below and the patch is attached:<br><br>root@d610-2:/root&gt; id -Z<br>root:sysadm_r:sysadm_t:s0-s15:c0.c255<br>root@d610-2:/root&gt; semodule -u mount.pp <br>semodule: SELinux policy is not managed or store cannot be accessed.<br>root@d610-2:/root&gt; semodule -l | grep mount<br>semodule: SELinux policy is not managed or store cannot be accessed.<br>root@d610-2:/root&gt; newrole -r secadm_r<br>Password: <br>bash: /root/.profile: Permission denied<br>root@d610-2:~# /usr/sbin/semodule -l | grep mount<br>automount&nbsp;&nbsp; &nbsp;1.11.0<br>mount&nbsp;&nbsp; &nbsp;1.10.0<br>root@d610-2:~# /usr/sbin/semodule -u mount.pp <br>/usr/sbin/semodule:&nbsp; Could not read file 'mount.pp': Permission denied<br>root@d610-2:~# /usr/sbin/getenforce <br>Enforcing<br>root@d610-2:~# /usr/sbin/setenforce 0<br>root@d610-2:~# /usr/sbin/getenforce <br>Permissiver!
 oot@d610-2:~# /usr/sbin/semodule -u mount.pp <br>root@d610-2:~# /u
sr/sbin/semodule -l | grep mount<br>automount&nbsp;&nbsp; &nbsp;1.11.0<br>mount&nbsp;&nbsp; &nbsp;1.10.1&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;# updated!!!<br>root@d610-2:~# mount<br>root@d610-2:~# cat /etc/mtab<br>root@d610-2:~# /sbin/reboot<br>(rebooting...)<br>root@d610-2:/root&gt; id -Z<br>root:sysadm_r:sysadm_t:s0-s15:c0.c255<br>root@d610-2:/root&gt; getenforce <br>Enforcing<br>root@d610-2:/root&gt; mount<br>rootfs on / type rootfs (rw)<br>proc on /proc type proc (rw)<br>sysfs on /sys type sysfs (rw)<br>devpts on /dev/pts type devpts (rw)<br>tmpfs on /dev/shm type tmpfs (rw)<br>root@d610-2:/root&gt; cat /etc/mtab<br>rootfs / rootfs rw 0 0<br>proc /proc proc rw 0 0<br>sysfs /sys sysfs rw 0 0<br>devpts /dev/pts devpts rw 0 0<br>tmpfs /dev/shm tmpfs rw 0 0<br>root@d610-2:/root&gt; <br><br>2, if log in the root user through serial console, I would be unable to assume another administrator roles(auditadm_r, secadm_r) by the newrole program, the error message says that newrole!
  is unable to relabel the /dev/console device.<br><br>So far the contents of the securetty_types file are all about X_tty_device_t, where X could be of any administrator's role or staff or unprivileged user, it would be enough if log in through local /dev/ttyN device by Ctl+Alt+FN. However, if I want to use newrole on the serial console, I think I would have to mark it as secure device by appending its type of console_device_t to the securetty_types file.<br><br>Aside from that, I have to call term_relabel_console(newrole_t) so that newrole_t would have necessary permissions to relabelto or relabelfrom the /dev/console.<br><br>The patch is attched.<br><br>3, The /root/ directory is used to be labeled as "sysadm_home_t" or "sysadm_home_dir_t", but I found them are labeled as default_t now and it seems that only the sysadm_t has read permission to the /root/ directory. If I assume another administrator role such as secadm_r, then secadm_t would have trouble to read or write /!
 root/:<br><br>root@d610-2:/root&gt; id -Z<br>root:sysadm_r:sysadm_t:s0
-s15:c0.c255<br>root@d610-2:/root&gt; newrole -r secadm_r<br>Password: <br>bash: /root/.profile: Permission denied&nbsp;&nbsp; &nbsp;<br>root@d610-2:~# id -Z<br>root:secadm_r:secadm_t:s0-s15:c0.c255<br>root@d610-2:~# touch 1<br>touch: cannot touch `1': Permission denied<br>root@d610-2:~#<br><br>Shouldn't secadm_t and auditadm_t also have enough rights to the /root/ directory?<br><br>Looking forward to any of your comments!<br><br>Best regards,<br><br>Harry<br><br><br><hr>与任何您希望的人分享您的回忆。 <a href="http://www.microsoft.com/china/windows/windowslive/products/photos-share.aspx?tab=1">任何您希望的人。</a><br /><hr />与任何您希望的人分享您的回忆。 <a href='http://www.microsoft.com/china/windows/windowslive/products/photos-share.aspx?tab=1' target='_new'>任何您希望的人。</a></body>
</html>
--_7f36edb9-0b07-44b7-b16b-7da94f01a2fc_--

--_bcefabe7-c239-4213-aec7-9cd0b3f29aad_
Content-Type: text/x-diff
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="refpolicy-strict-mount-rw-etc-locks.patch"

R3JhbnQgbmVjZXNzYXJ5IFRFIHJ1bGVzIHNvIHRoYXQgdGhlIG1vdW50IHByb2dyYW0gY291bGQg
Z3JhYiB0aGUKL3Zhci9sb2NrL210YWJ+IGxvY2sgYW5kIHdyaXRlIGludG8gL2V0Yy9tdGFiIHN1
Y2Nlc3NmdWxseS4KLS0tCiBwb2xpY3kvbW9kdWxlcy9zeXN0ZW0vbW91bnQudGUgfCAgICA1ICsr
KystCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgotLS0g
YS9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vbW91bnQudGUKKysrIGIvcG9saWN5L21vZHVsZXMvc3lz
dGVtL21vdW50LnRlCkBAIC0xLDUgKzEsNSBAQAogCi1wb2xpY3lfbW9kdWxlKG1vdW50LCAxLjEw
LjApCitwb2xpY3lfbW9kdWxlKG1vdW50LCAxLjEwLjEpCiAKICMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMKICMKQEAgLTgzLDYgKzgzLDkgQEAgZG9tYWluX3VzZV9pbnRl
cmFjdGl2ZV9mZHMobW91bnRfdCkKIGZpbGVzX3NlYXJjaF9hbGwobW91bnRfdCkKIGZpbGVzX3Jl
YWRfZXRjX2ZpbGVzKG1vdW50X3QpCiBmaWxlc19tYW5hZ2VfZXRjX3J1bnRpbWVfZmlsZXMobW91
bnRfdCkKKyMgbW91bnRfdCBuZWVkcyB0byB3cml0ZSAvZXRjL210YWIgYW5kIC92YXIvbG9jay9t
dGFifiB3aGVuIG1vdW50aW5nIGZzCitmaWxlc19yd19ldGNfcnVudGltZV9maWxlcyhtb3VudF90
KQorZmlsZXNfbWFuYWdlX2dlbmVyaWNfbG9ja3MobW91bnRfdCkKIGZpbGVzX2V0Y19maWxldHJh
bnNfZXRjX3J1bnRpbWUobW91bnRfdCxmaWxlKQogZmlsZXNfbW91bnRvbl9hbGxfbW91bnRwb2lu
dHMobW91bnRfdCkKIGZpbGVzX3VubW91bnRfcm9vdGZzKG1vdW50X3QpCg==

--_bcefabe7-c239-4213-aec7-9cd0b3f29aad_
Content-Type: text/x-diff
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="refpolicy-strict-newrole-relabel-console.patch"

SWYgbG9naW4gdGhyb3VnaCBzZXJpYWwgY29uc29sZSwgdGhlbiB0aGUgdGVybWluYWwgY29ubmVj
dGVkIHRvIHRoZQpzdGFuZGFyZCBpbnB1dCBhcyByZXZlYWxlZCBieSB0aGUgInR0eSIgY29tbWFu
ZCB3b3VsZCBiZSAvZGV2L2NvbnNvbGUsCm5ld3JvbGVfdCBzaG91bGUgaGF2ZSByZWxhYmVsdG8g
YW5kIHJlbGFiZWxmcm9tIHBlcm1pc3Npb25zIG9uIGl0IHNvIHRoYXQKYWRtaW5pc3RyYXRvcnMg
b3Igc3RhZmYgdXNlcnMgY291bGQgZG8gbmV3cm9sZSBvbiBpdC4KCkFsc28sIHRoZSAvZGV2L2Nv
bnNvbGUgd291bGQgaGF2ZSB0byBiZSByZWdhcmRlZCBhcyBhIHNlY3VyZSBkZXZpY2UuCi0tLQog
Y29uZmlnL2FwcGNvbmZpZy1tbHMvc2VjdXJldHR5X3R5cGVzIHwgICAgMSArCiBwb2xpY3kvbW9k
dWxlcy9zeXN0ZW0vc2VsaW51eHV0aWwudGUgfCAgICA0ICsrKy0KIDIgZmlsZXMgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgotLS0gYS9wb2xpY3kvbW9kdWxlcy9zeXN0
ZW0vc2VsaW51eHV0aWwudGUKKysrIGIvcG9saWN5L21vZHVsZXMvc3lzdGVtL3NlbGludXh1dGls
LnRlCkBAIC0xLDUgKzEsNSBAQAogCi1wb2xpY3lfbW9kdWxlKHNlbGludXh1dGlsLCAxLjEyLjAp
Citwb2xpY3lfbW9kdWxlKHNlbGludXh1dGlsLCAxLjEyLjEpCiAKIGdlbl9yZXF1aXJlKGAKIAli
b29sIHNlY3VyZV9tb2RlOwpAQCAtMjYwLDYgKzI2MCw4IEBAIHRlcm1fcmVsYWJlbF9hbGxfdXNl
cl90dHlzKG5ld3JvbGVfdCkKIHRlcm1fcmVsYWJlbF9hbGxfdXNlcl9wdHlzKG5ld3JvbGVfdCkK
IHRlcm1fZ2V0YXR0cl91bmFsbG9jYXRlZF90dHlzKG5ld3JvbGVfdCkKIHRlcm1fZG9udGF1ZGl0
X3VzZV91bmFsbG9jYXRlZF90dHlzKG5ld3JvbGVfdCkKKyMgYWxsb3cgbmV3cm9sZV90IHRvIHJl
bGFiZWwodG8vZnJvbSkgL2Rldi9jb25zb2xlCit0ZXJtX3JlbGFiZWxfY29uc29sZShuZXdyb2xl
X3QpCiAKIGF1dGhfdXNlX25zc3dpdGNoKG5ld3JvbGVfdCkKIGF1dGhfZG9tdHJhbnNfY2hrX3Bh
c3N3ZChuZXdyb2xlX3QpCi0tLSBhL2NvbmZpZy9hcHBjb25maWctbWxzL3NlY3VyZXR0eV90eXBl
cworKysgYi9jb25maWcvYXBwY29uZmlnLW1scy9zZWN1cmV0dHlfdHlwZXMKQEAgLTQsMyArNCw0
IEBAIHN0YWZmX3R0eV9kZXZpY2VfdAogc3lzYWRtX3R0eV9kZXZpY2VfdAogdW5jb25maW5lZF90
dHlfZGV2aWNlX3QKIHVzZXJfdHR5X2RldmljZV90Citjb25zb2xlX2RldmljZV90Cg==

--_bcefabe7-c239-4213-aec7-9cd0b3f29aad_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
