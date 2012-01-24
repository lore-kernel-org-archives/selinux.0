MIME-Version: 1.0
Date: Tue, 24 Jan 2012 12:44:00 -0600
Message-ID: <CA+XzHePWuxzjF8RjxXzEGd0c8tK5bgW2rEeNC6dkSJ4-jNSOLA@mail.gmail.com>
Subject: SEAndroid Build for Galaxy Nexus
From: Bryan Hinton <bryan@bryanhinton.com>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just completed a 4.0.3 SEAndroid build for the Galaxy Nexus.  The
build was clean and it is successfully running on the device.
A few general notes:
-I ran the following  fastboot commands (in this order) after building
AOSP w/ SELinux patches and repacking the boot image:   fastboot erase
cache, fastboot flash boot boot.img, fastboot flash system system.img,
fastboot flash userdata userdata.img.
-I had to mount /system rw after boot and fix the missing, userland
ril client library in order to get the cdma/lte radios working.
device/samsung/tuna is missing the extract script in AOSP.
-permissive and enforced modes are functioning properly according to
dmesg output.    phone calls and sms are successful.  I am in the
process of relabeling some of the device nodes in the policy to allow
access to the radio.


Bryan Hinton

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
