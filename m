Subject: Re: SE Android on Galaxy Nexus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bryan Hinton <bryan@bryanhinton.com>
Cc: Subramani Venkatesh <selinuxv31@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <CA+XzHeO7S5OYPvRV7jMJXN+3jaEcKtM1RY8Du61-gvv2asfWMg@mail.gmail.com>
References: 
	 <CAD8iFzx70mZyFbqTju=oVm1uLRx=Nic6Y8drsbiM-Vxqw3F8cw@mail.gmail.com>
	 <1330702776.2616.43.camel@moss-pluto>
	 <CAD8iFzycUJLiZynmHGiUR6s2OJVKRvoQda7n-ktUBxTf-RiFwA@mail.gmail.com>
	 <CA+XzHeMaetu1zmC9KNo1VVnPan20neiXiSVYWwyC9ZmS_rx4=w@mail.gmail.com>
	 <1330716665.2616.80.camel@moss-pluto>
	 <CA+XzHeO7S5OYPvRV7jMJXN+3jaEcKtM1RY8Du61-gvv2asfWMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Mar 2012 14:16:36 -0500
Message-ID: <1331061396.26027.108.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-03-02 at 16:13 -0600, Bryan Hinton wrote:
> Thank you for the feedback. An updated patch for inclusion into the
> sepolicy tree, is below.
> My replies to your comments are below the patch.

Thanks, a few comments below.

> @@ -35,6 +37,7 @@
>  /dev/mtd/mtd5ro		u:object_r:radio_device:s0
>  /dev/mtp_usb		u:object_r:mtp_device:s0
>  /dev/pn544		u:object_r:nfc_device:s0
> +/dev/ttyO3     u:object_r:nfc_device:s0

I suspect this one should go into a separate sepolicy.fc file for the
device, now that we have support for such files.

> @@ -66,7 +69,8 @@
>  /dev/socket/zygote	u:object_r:zygote_socket:s0
>  /dev/spdif_out.*	u:object_r:audio_device:s0
>  /dev/tegra.*		u:object_r:video_device:s0
> -/dev/tty[0-9]*		u:object_r:tty_device:s0
> +/dev/tty[0-2]*		u:object_r:tty_device:s0
> +/dev/tty[4-9]*		u:object_r:tty_device:s0

Not necessary; a fully specified (no regex) pathname will always take
precedence over a regex, and a later entry will take precedence over an
earlier one.  So it should suffice to have the /dev/tty03 in your
sepolicy.fc file for the device.

> @@ -116,10 +120,15 @@
>  /data/misc/wifi(/.*)?		u:object_r:wifi_data_file:s0
>  # App sandboxes
>  /data/data/.*		u:object_r:app_data_file:s0
> +/data/data/com.android.providers.telephony/databases(/.*)?
> u:object_r:radio_data_file:s0
> +/data/data/com.android.providers.telephony/(optable\.db)?
> u:object_r:radio_data_file:s0

The last pathname regex doesn't seem right.  If you just want
optable.db, then drop the parens and ?; if you want everything under the
directory, then you can just use (/.*)?.

Also, your patch was line wrapped and thus can't be applied.
Make sure you use preformat or equivalent in your mail client or
directly send via git send-email.

> +
>  #############################
>  # efs files
>  #
>  /efs(/.*)?		u:object_r:efs_file:s0
> +/data/radio/nv_data.bin.*  u:object_r:radio_data_file:s0
> +/factory/nv_data.bin.*     u:object_r:radio_data_file:s0

I suspect these will go into your sepolicy.fc file for the device.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
