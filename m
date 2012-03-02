Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q22Hpbbm008596
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2012 12:51:37 -0500
Received: by obceq6 with SMTP id eq6so2489332obc.12
        for <selinux@tycho.nsa.gov>; Fri, 02 Mar 2012 09:51:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAD8iFzycUJLiZynmHGiUR6s2OJVKRvoQda7n-ktUBxTf-RiFwA@mail.gmail.com>
References: <CAD8iFzx70mZyFbqTju=oVm1uLRx=Nic6Y8drsbiM-Vxqw3F8cw@mail.gmail.com>
	<1330702776.2616.43.camel@moss-pluto>
	<CAD8iFzycUJLiZynmHGiUR6s2OJVKRvoQda7n-ktUBxTf-RiFwA@mail.gmail.com>
Date: Fri, 2 Mar 2012 11:51:36 -0600
Message-ID: <CA+XzHeMaetu1zmC9KNo1VVnPan20neiXiSVYWwyC9ZmS_rx4=w@mail.gmail.com>
Subject: Re: SE Android on Galaxy Nexus
From: Bryan Hinton <bryan@bryanhinton.com>
To: Subramani Venkatesh <selinuxv31@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is the latest policy that I am using.


From: Bryan Hinton <bryan@bryanhinton.com>
Date: Wed, 15 Feb 2012 22:31:58 -0600
Subject: [PATCH] New SEPolicy for SCH-1515.
---
 device.te      |    1 +
 domain.te      |    1 +
 file.te        |    6 ++++++
 file_contexts  |   26 ++++++++++++++++++++++++++
 nfc.te         |    1 +
 radio.te       |    3 ++-
 rild.te        |    7 +++++++
 seapp_contexts |    3 +++
 8 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/device.te b/device.te
index 6424db6..08437a5 100644
--- a/device.te
+++ b/device.te
@@ -23,6 +23,7 @@ type log_device, dev_type, mlstrustedobject;
 type mtd_device, dev_type;
 type mtp_device, dev_type, mlstrustedobject;
 type nfc_device, dev_type;
+type nfc_ctrl_device, dev_type;
 type nv_device, dev_type, mlstrustedobject;
 type powervr_device, dev_type, mlstrustedobject;
 type ptmx_device, dev_type, mlstrustedobject;
diff --git a/domain.te b/domain.te
index 55c9ecd..88fb261 100644
--- a/domain.te
+++ b/domain.te
@@ -85,6 +85,7 @@ if (in_qemu) {
 allow domain sysfs:file rw_file_perms;
 }
 allow domain sysfs_writable:file rw_file_perms;
+allow domain sysfs_nfc_power_writable:file rw_file_perms;

 # Read access to pseudo filesystems.
 r_dir_file(domain, proc)
diff --git a/file.te b/file.te
index 11c3ef6..ec7a02e 100644
--- a/file.te
+++ b/file.te
@@ -8,6 +8,7 @@ type selinuxfs, fs_type;
 type cgroup, fs_type, mlstrustedobject;
 type sysfs, fs_type, mlstrustedobject;
 type sysfs_writable, fs_type, sysfs_type, mlstrustedobject;
+type sysfs_nfc_power_writable, fs_type, sysfs_type, mlstrustedobject;
 type inotify, fs_type, mlstrustedobject;
 type devpts, fs_type;
 type tmpfs, fs_type;
@@ -43,6 +44,11 @@ type systemkeys_data_file, file_type, data_file_type;
 type wifi_data_file, file_type, data_file_type;
 type radio_data_file, file_type, data_file_type;
 type nfc_data_file, file_type, data_file_type;
+
+type radio_nv_data_file, file_type, data_file_type;
+type efs_radio_nv_data_file, file_type, data_file_type;
+type radio_telephony_data_file, file_type, data_file_type;
+
 # /data/data subdirectories - app sandboxes
 type app_data_file, file_type, data_file_type;
 # Default type for anything under /cache
diff --git a/file_contexts b/file_contexts
index 92c6bb0..59bac40 100644
--- a/file_contexts
+++ b/file_contexts
@@ -19,6 +19,16 @@
 /dev/block/loop[0-9]*	u:object_r:loop_device:s0
 /dev/block/ram[0-9]*	u:object_r:ram_device:s0
 /dev/block/mtdblock5	u:object_r:radio_device:s0
+# rild needs access to the cdma and lte device nodes
+/dev/cdma_ipc0 u:object_r:radio_device:s0
+/dev/cdma_rmnet5 u:object_r:radio_device:s0
+/dev/lte_ipc0 u:object_r:radio_device:s0
+/dev/lte_rmnet4 u:object_r:radio_device:s0
+/dev/lte_boot0 u:object_r:radio_device:s0
+/dev/lte_spi u:object_r:radio_device:s0
+/dev/ttyGS1 u:object_r:radio_device:s0
+/dev/lte_rfs0 u:object_r:radio_device:s0
+
 /dev/cam		u:object_r:camera_device:s0
 /dev/console		u:object_r:console_device:s0
 /dev/cpuctl(/.*)?	u:object_r:cpuctl_device:s0
@@ -68,6 +78,7 @@
 /dev/tegra.*		u:object_r:video_device:s0
 /dev/tty[0-9]*		u:object_r:tty_device:s0
 /dev/ttyS[0-9]*		u:object_r:serial_device:s0
+/dev/ttyO3		u:object_r:nfc_ctrl_device:s0
 /dev/uinput		u:object_r:input_device:s0
 /dev/urandom		u:object_r:urandom_device:s0
 /dev/vcs[0-9a-z]*	u:object_r:vcs_device:s0
@@ -116,10 +127,24 @@
 /data/misc/wifi(/.*)?		u:object_r:wifi_data_file:s0
 # App sandboxes
 /data/data/.*		u:object_r:app_data_file:s0
+
+# rild needs access to the databases that the android telephony
provider manages
+/data/data/com.android.providers.telephony/databases(/.*)?
u:object_r:radio_telephony_data_file:s0
+/data/data/com.android.providers.telephony/optable.db
u:object_r:radio_telephony_data_file:s0
+/data/data/com.android.providers.telephony/databases/telephony.db
u:object_r:radio_telephony_data_file:s0
+/data/data/com.android.providers.telephony/databases/telephony.db-journal
u:object_r:radio_telephony_data_file:s0
+# rild needs acess to radio image and associated md5 sum on userdata.img
+/data/radio/nv_data.bin u:object_r:radio_nv_data_file:s0
+/data/radio/nv_data.bin.md5 u:object_r:radio_nv_data_file:s0
+
 #############################
 # efs files
 #
 /efs(/.*)?		u:object_r:efs_file:s0
+# rild needs access to radio image and associated md5 sum on
/efs(/factory) ext4 image
+/factory/nv_data.bin u:object_r:efs_radio_nv_data_file:s0
+/factory/nv_data.bin.md5 u:object_r:efs_radio_nv_data_file:s0
+
 #############################
 # Cache files
 #
@@ -128,3 +153,4 @@
 # sysfs files
 #
 /sys/qemu_trace/process_name	--	u:object_r:sysfs_writable:s0
+/sys/devices/platform/nfc-power/nfc_power	--	u:object_r:sysfs_nfc_power_writable:s0
diff --git a/nfc.te b/nfc.te
index b20d236..7ff3c01 100644
--- a/nfc.te
+++ b/nfc.te
@@ -4,6 +4,7 @@ app_domain(nfc)

 # NFC device access.
 allow nfc nfc_device:chr_file rw_file_perms;
+allow nfc nfc_ctrl_device:chr_file rw_file_perms;

 # Data file accesses.
 allow nfc nfc_data_file:dir create_dir_perms;
diff --git a/radio.te b/radio.te
index 9094cce..94cf54b 100644
--- a/radio.te
+++ b/radio.te
@@ -13,5 +13,6 @@ unix_socket_connect(radio, rild, rild)
 # Data file accesses.
 allow radio radio_data_file:dir create_dir_perms;
 allow radio radio_data_file:notdevfile_class_set create_file_perms;
-
+allow radio radio_telephony_data_file:dir r_dir_perms;
+allow radio radio_telephony_data_file:file create_file_perms;
 allow radio alarm_device:chr_file rw_file_perms;
diff --git a/rild.te b/rild.te
index 2857892..b14bd10 100644
--- a/rild.te
+++ b/rild.te
@@ -7,6 +7,7 @@ net_domain(rild)
 allow rild kernel:system module_request;
 unix_socket_connect(rild, property, init)
 unix_socket_connect(rild, qemud, qemud)
+allow rild self:netlink_route_socket { setopt };
 allow rild self:capability { setuid net_admin net_raw };
 allow rild alarm_device:chr_file rw_file_perms;
 allow rild cgroup:dir create_dir_perms;
@@ -19,3 +20,9 @@ allow rild shell_exec:file rx_file_perms;
 dontaudit rild self:capability sys_admin;
 # XXX Label sysfs files with a specific type?
 allow rild sysfs:file rw_file_perms;
+allow rild radio_telephony_data_file:file rw_file_perms;
+allow rild radio_telephony_data_file:dir r_dir_perms;
+allow rild radio_nv_data_file:file rw_file_perms;
+allow rild radio_nv_data_file:dir r_dir_perms;
+allow rild efs_radio_nv_data_file:file rw_file_perms;
+
diff --git a/seapp_contexts b/seapp_contexts
index c301792..52bbfa2 100644
--- a/seapp_contexts
+++ b/seapp_contexts
@@ -32,6 +32,9 @@ isSystemServer=true domain=system
 user=system domain=system_app type=system_data_file
 user=nfc domain=nfc type=nfc_data_file
 user=radio domain=radio type=radio_data_file
+user=radio domain=radio type=radio_telephony_data_file
+user=radio domain=radio type=radio_nv_data_file
+user=radio domain=radio type=efs_radio_nv_data_file
 user=app_* domain=untrusted_app type=app_data_file levelFromUid=true
 user=app_* seinfo=systemApp domain=trusted_app levelFromUid=true
 user=app_* seinfo=systemApp name=com.android.browser
domain=browser_app levelFromUid=true
-- 
1.7.5.4


Bryan Hinton

On Fri, Mar 2, 2012 at 10:03 AM, Subramani Venkatesh
<selinuxv31@gmail.com> wrote:
> Thanks Stephen,
> I did not add Bryan changes, i will add them now and see the difference.
> Thanks for debug information.
>
> Regards,
> Subbu
>
> On Fri, Mar 2, 2012 at 10:39 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On Fri, 2012-03-02 at 10:29 -0500, Subramani Venkatesh wrote:
>>> Hi,
>>> I got SE Android working on Galaxy Nexus, followed instructions from
>>> http://selinuxproject.org/page/SEAndroid
>>> After executing "setenforce 1", launching applications works as
>>> expected, but it is only short period of time, later it reboots. Would
>>> like to debug the issues, Is their any guide to debug SE on Android?
>>
>> Did you try the policy changes posted by Bryan Hinton for the Galaxy
>> Nexus?  See:
>> http://marc.info/?l=selinux&m=132752617008734&w=2
>>
>> Before running setenforce 1, you should check for any avc messages in
>> your dmesg output, e.g.
>> adb shell dmesg | grep avc
>>
>> Such denials need to be addressed through policy changes or labeling
>> changes before you go to enforcing mode.
>>
>> You might want to start a process capturing dmesg output just before you
>> go to enforcing mode, e.g.
>> adb shell su 0 cat /proc/kmsg
>>
>> adb logcat *:E can also be helpful.
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
