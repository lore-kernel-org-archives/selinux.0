Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3OIsE7N032560
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2008 14:54:14 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3OIsCNv020593
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2008 18:54:13 GMT
Received: by fg-out-1718.google.com with SMTP id 16so2871022fgg.40
        for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2008 11:54:11 -0700 (PDT)
Message-ID: <4c4ba1530804241154j29be39adnb71e8dc11d4f4f25@mail.gmail.com>
Date: Thu, 24 Apr 2008 11:54:11 -0700
From: "Tom London" <selinux@gmail.com>
To: "SELinux List" <selinux@tycho.nsa.gov>
Subject: How to handle USB devices....
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Attempting to get '-usbdevice host:001.004' (and similar) working with
qemu-kvm on my Fedora rawhide system, it occurred to me that there is
the opportunity to apply policy to the files associated with USB
devices.  Currently, most seem to have a 'flat' label (usbfs_t),
making it hard to confine qemu like programs that should only have
access to, say, a single device.

Does it make sense to support more 'fine grained' labeling, and to
label the associated device file (e.g., /proc/bus/usb/...., /dev/usb,
etc.) when the files are 'created'?

Would udev be the place to do this?  PolicyKIt?

Thoughts?

tom
-- 
Tom London

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
