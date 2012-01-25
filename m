MIME-Version: 1.0
In-Reply-To: <1327495215.9607.2.camel@moss-pluto>
References: <CA+XzHePWuxzjF8RjxXzEGd0c8tK5bgW2rEeNC6dkSJ4-jNSOLA@mail.gmail.com>
	<1327495215.9607.2.camel@moss-pluto>
Date: Wed, 25 Jan 2012 15:07:28 -0600
Message-ID: <CA+XzHeOpr9Wp6C2W2dVv+AYogjfJcB6ESvdmvoyHqkZB2LOyvg@mail.gmail.com>
Subject: Re: SEAndroid Build for Galaxy Nexus
From: Bryan Hinton <bryan@bryanhinton.com>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a fairly minimal configuration of SEAndroid on the Galaxy
Nexus.  Here are the steps that I took.
Phone calls, SMS, and the Browser work.  The camera is disabled along
with most of the other internal peripherals.
I think that the policy config additions that I made around the
telephony provider database files could use some increased granularity
- perhaps a new type in the radio domain for radio access to the
telephony provider databases (rather than overriding radio_data_file
as you mentioned) ?

--Build Environment
Host: Mint 12

--PreBuild Stage
Pull the following drivers from device (SCH-i515 - Galaxy Nexus) with
most recent 4.0.2 ota.
The extract-files.sh script in device/samsung/toro directory does this
but I am not using anything in this directory so here are the three
files
that I pulled manually.
host # adb pull /system/lib/libsecril-client.so
host # adb pull /system/vendor/lib/libsec-ril_lte.so
host # adb pull /system/vendor/firmware/bcm4330.hcd

--Build Stage
AOSP 4.0.3 (full_toro-userdebug) w/ SELinux patches + Kernel w/ SELinux enabled
apply patches below to external/sepolicy

--PostBuild Stage (kernel + full_toro-userdebug)
>From within device/samsung/tuna
host # mkbootimg --cmdline 'no_console_suspend=1 console=null'
--kernel zImage --ramdisk ramdisk.img -o seboot.img
host # adb reboot bootloader
host # fastboot erase cache
host # fastboot flash boot seboot.img
host # fastboot flash system system.img
host # fastboot flash userdata userdata.img
host # fastboot reboot

target # mount -o rw,remount -t ext4
/dev/block/platform/omap/omap_hsmmc.0/by-name/system /system
host # adb root
host # adb push libsecril-client.so /system/lib
host # adb push bcm4330.hcd /system/vendor/firmware
host # adb push libsec-ril_lte.so /system/vendor/lib
host # adb reboot
# manually set permissions on telephony provider databases if needed
target # chcon u:object_r:radio_data_file:s0
/data/data/com.android.providers.telephony/optable.db
target # chcon u:object_r:radio_data_file:s0
/data/data/com.android.providers.telephony/databases/telephony.db
target # chcon u:object_r:radio_data_file:s0
/data/data/com.android.providers.telephony/databases/telephony.db-journal

# set SE mode to enforced. will reset to permissive on next boot. *add
to init.rc and repack seboot.img after testing complete.
target # setenforce 1


diff --git a/file_contexts b/file_contexts
index 92c6bb0..059276c 100644
--- a/file_contexts
+++ b/file_contexts
@@ -19,6 +19,13 @@
 /dev/block/loop[0-9]*  u:object_r:loop_device:s0
 /dev/block/ram[0-9]*   u:object_r:ram_device:s0
 /dev/block/mtdblock5   u:object_r:radio_device:s0
+/dev/cdma_ipc0 u:object_r:radio_device:s0
+/dev/cdma_rmnet5 u:object_r:radio_device:s0
+/dev/lte_ipc0 u:object_r:radio_device:s0
+/dev/lte_rmnet4 u:object_r:radio_device:s0
+/dev/lte_boot0 u:object_r:radio_device:s0
+/dev/lte_spi u:object_r:radio_device:s0
+/dev/ttyGS1 u:object_r:radio_device:s0
 /dev/cam               u:object_r:camera_device:s0
 /dev/console           u:object_r:console_device:s0
 /dev/cpuctl(/.*)?      u:object_r:cpuctl_device:s0
diff --git a/rild.te b/rild.te
index 2857892..630bc42 100644
--- a/rild.te
+++ b/rild.te
@@ -19,3 +19,7 @@ allow rild shell_exec:file rx_file_perms;
 dontaudit rild self:capability sys_admin;
 # XXX Label sysfs files with a specific type?
 allow rild sysfs:file rw_file_perms;
+allow rild radio_data_file:file rw_file_perms;
+allow rild radio_data_file:dir rw_dir_perms;
+allow rild radio_data_file:chr_file r_file_perms;
+allow rild sdcard:dir r_dir_perms;


Bryan Hinton



On Wed, Jan 25, 2012 at 6:40 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2012-01-24 at 12:44 -0600, Bryan Hinton wrote:
>> I just completed a 4.0.3 SEAndroid build for the Galaxy Nexus.  The
>> build was clean and it is successfully running on the device.
>> A few general notes:
>> -I ran the following  fastboot commands (in this order) after building
>> AOSP w/ SELinux patches and repacking the boot image:   fastboot erase
>> cache, fastboot flash boot boot.img, fastboot flash system system.img,
>> fastboot flash userdata userdata.img.
>> -I had to mount /system rw after boot and fix the missing, userland
>> ril client library in order to get the cdma/lte radios working.
>> device/samsung/tuna is missing the extract script in AOSP.
>> -permissive and enforced modes are functioning properly according to
>> dmesg output.    phone calls and sms are successful.  I am in the
>> process of relabeling some of the device nodes in the policy to allow
>> access to the radio.
>
> Glad to hear that you were able to get it up and running.  I don't
> presently have that device, so I'd be interested in hearing more about
> your experience, changes you have to make, etc.
>
> --
> Stephen Smalley
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
