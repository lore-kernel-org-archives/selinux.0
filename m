Subject: Re: SE Android on Galaxy Nexus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bryan Hinton <bryan@bryanhinton.com>
Cc: Subramani Venkatesh <selinuxv31@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <CA+XzHeMaetu1zmC9KNo1VVnPan20neiXiSVYWwyC9ZmS_rx4=w@mail.gmail.com>
References: 
	 <CAD8iFzx70mZyFbqTju=oVm1uLRx=Nic6Y8drsbiM-Vxqw3F8cw@mail.gmail.com>
	 <1330702776.2616.43.camel@moss-pluto>
	 <CAD8iFzycUJLiZynmHGiUR6s2OJVKRvoQda7n-ktUBxTf-RiFwA@mail.gmail.com>
	 <CA+XzHeMaetu1zmC9KNo1VVnPan20neiXiSVYWwyC9ZmS_rx4=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Mar 2012 14:31:05 -0500
Message-ID: <1330716665.2616.80.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-03-02 at 11:51 -0600, Bryan Hinton wrote:
> Here is the latest policy that I am using.

Thanks for posting this.  A few comments below.

> diff --git a/device.te b/device.te
> index 6424db6..08437a5 100644
> --- a/device.te
> +++ b/device.te
> @@ -23,6 +23,7 @@ type log_device, dev_type, mlstrustedobject;
>  type mtd_device, dev_type;
>  type mtp_device, dev_type, mlstrustedobject;
>  type nfc_device, dev_type;
> +type nfc_ctrl_device, dev_type;

Types are intended to be used as equivalence classes, so if the same set
of domains are going to be allowed to access nfc_ctrl_device with the
same permissions as for nfc_device, then just reuse nfc_device rather
than introducing a new type.

> diff --git a/domain.te b/domain.te
> index 55c9ecd..88fb261 100644
> --- a/domain.te
> +++ b/domain.te
> @@ -85,6 +85,7 @@ if (in_qemu) {
>  allow domain sysfs:file rw_file_perms;
>  }
>  allow domain sysfs_writable:file rw_file_perms;
> +allow domain sysfs_nfc_power_writable:file rw_file_perms;

Likewise here, if you truly need to allow all domains rw access to this
type, why not just reuse sysfs_writable?  I was wondering though whether
we truly should be allowing all domains such access.

> diff --git a/file.te b/file.te
> index 11c3ef6..ec7a02e 100644
> --- a/file.te
> +++ b/file.te
> @@ -8,6 +8,7 @@ type selinuxfs, fs_type;
>  type cgroup, fs_type, mlstrustedobject;
>  type sysfs, fs_type, mlstrustedobject;
>  type sysfs_writable, fs_type, sysfs_type, mlstrustedobject;
> +type sysfs_nfc_power_writable, fs_type, sysfs_type, mlstrustedobject;

See above.

> @@ -43,6 +44,11 @@ type systemkeys_data_file, file_type, data_file_type;
>  type wifi_data_file, file_type, data_file_type;
>  type radio_data_file, file_type, data_file_type;
>  type nfc_data_file, file_type, data_file_type;
> +
> +type radio_nv_data_file, file_type, data_file_type;
> +type efs_radio_nv_data_file, file_type, data_file_type;
> +type radio_telephony_data_file, file_type, data_file_type;

Do we need the distinction between radio_nv_data_file and
efs_radio_nv_rdata_file?  Where is that distinction used in the policy
allow rules?

> diff --git a/file_contexts b/file_contexts
> index 92c6bb0..59bac40 100644
> --- a/file_contexts
> +++ b/file_contexts
> @@ -19,6 +19,16 @@
>  /dev/block/loop[0-9]*	u:object_r:loop_device:s0
>  /dev/block/ram[0-9]*	u:object_r:ram_device:s0
>  /dev/block/mtdblock5	u:object_r:radio_device:s0
> +# rild needs access to the cdma and lte device nodes
> +/dev/cdma_ipc0 u:object_r:radio_device:s0
> +/dev/cdma_rmnet5 u:object_r:radio_device:s0
> +/dev/lte_ipc0 u:object_r:radio_device:s0
> +/dev/lte_rmnet4 u:object_r:radio_device:s0
> +/dev/lte_boot0 u:object_r:radio_device:s0
> +/dev/lte_spi u:object_r:radio_device:s0
> +/dev/ttyGS1 u:object_r:radio_device:s0
> +/dev/lte_rfs0 u:object_r:radio_device:s0

You can shorten this specification by using pathname regexes, e.g.
/dev/cdma_.*	u:object_r:radio_device:s0
/dev/lte_.*	u:object_r:radio_device:s0
/dev/ttyGS[0-9] u:object_r:radio_device:s0

> @@ -68,6 +78,7 @@
>  /dev/tegra.*		u:object_r:video_device:s0
>  /dev/tty[0-9]*		u:object_r:tty_device:s0
>  /dev/ttyS[0-9]*		u:object_r:serial_device:s0
> +/dev/ttyO3		u:object_r:nfc_ctrl_device:s0
>  /dev/uinput		u:object_r:input_device:s0
>  /dev/urandom		u:object_r:urandom_device:s0
>  /dev/vcs[0-9a-z]*	u:object_r:vcs_device:s0
> @@ -116,10 +127,24 @@
>  /data/misc/wifi(/.*)?		u:object_r:wifi_data_file:s0
>  # App sandboxes
>  /data/data/.*		u:object_r:app_data_file:s0
> +
> +# rild needs access to the databases that the android telephony
> provider manages
> +/data/data/com.android.providers.telephony/databases(/.*)?
> u:object_r:radio_telephony_data_file:s0
> +/data/data/com.android.providers.telephony/optable.db
> u:object_r:radio_telephony_data_file:s0
> +/data/data/com.android.providers.telephony/databases/telephony.db
> u:object_r:radio_telephony_data_file:s0
> +/data/data/com.android.providers.telephony/databases/telephony.db-journal
> u:object_r:radio_telephony_data_file:s0

The first entry (with the (/.*)? suffix) should match the latter two
entries already, making them unnecessary.

> +# rild needs acess to radio image and associated md5 sum on userdata.img
> +/data/radio/nv_data.bin u:object_r:radio_nv_data_file:s0
> +/data/radio/nv_data.bin.md5 u:object_r:radio_nv_data_file:s0

/data/radio/nv_data.bin.* would work here.

> +
>  #############################
>  # efs files
>  #
>  /efs(/.*)?		u:object_r:efs_file:s0
> +# rild needs access to radio image and associated md5 sum on
> /efs(/factory) ext4 image
> +/factory/nv_data.bin u:object_r:efs_radio_nv_data_file:s0
> +/factory/nv_data.bin.md5 u:object_r:efs_radio_nv_data_file:s0

Likewise.  Do we need the efs vs non-efs distinction?

> diff --git a/seapp_contexts b/seapp_contexts
> index c301792..52bbfa2 100644
> --- a/seapp_contexts
> +++ b/seapp_contexts
> @@ -32,6 +32,9 @@ isSystemServer=true domain=system
>  user=system domain=system_app type=system_data_file
>  user=nfc domain=nfc type=nfc_data_file
>  user=radio domain=radio type=radio_data_file
> +user=radio domain=radio type=radio_telephony_data_file
> +user=radio domain=radio type=radio_nv_data_file
> +user=radio domain=radio type=efs_radio_nv_data_file
>  user=app_* domain=untrusted_app type=app_data_file levelFromUid=true
>  user=app_* seinfo=systemApp domain=trusted_app levelFromUid=true
>  user=app_* seinfo=systemApp name=com.android.browser
> domain=browser_app levelFromUid=true

You can only have one type= specification per user=, and this is only
used by installd to label the /data/data/<packagename> directory and
files when they are created.  So the additional entries here should be
no-ops effectively.  We should likely add a validator program for
seapp_contexts to check for these kinds of errors.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
