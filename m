Subject: Re: SEAndroid Build for Galaxy Nexus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bryan Hinton <bryan@bryanhinton.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <CA+XzHePWuxzjF8RjxXzEGd0c8tK5bgW2rEeNC6dkSJ4-jNSOLA@mail.gmail.com>
References: 
	 <CA+XzHePWuxzjF8RjxXzEGd0c8tK5bgW2rEeNC6dkSJ4-jNSOLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Jan 2012 07:40:15 -0500
Message-ID: <1327495215.9607.2.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-01-24 at 12:44 -0600, Bryan Hinton wrote:
> I just completed a 4.0.3 SEAndroid build for the Galaxy Nexus.  The
> build was clean and it is successfully running on the device.
> A few general notes:
> -I ran the following  fastboot commands (in this order) after building
> AOSP w/ SELinux patches and repacking the boot image:   fastboot erase
> cache, fastboot flash boot boot.img, fastboot flash system system.img,
> fastboot flash userdata userdata.img.
> -I had to mount /system rw after boot and fix the missing, userland
> ril client library in order to get the cdma/lte radios working.
> device/samsung/tuna is missing the extract script in AOSP.
> -permissive and enforced modes are functioning properly according to
> dmesg output.    phone calls and sms are successful.  I am in the
> process of relabeling some of the device nodes in the policy to allow
> access to the radio.

Glad to hear that you were able to get it up and running.  I don't
presently have that device, so I'd be interested in hearing more about
your experience, changes you have to make, etc.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
