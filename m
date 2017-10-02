Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v92M2WwI010905
 for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2017 18:02:32 -0400
Received: by mail-pf0-f197.google.com with SMTP id g62so1689380pfk.6
 for <selinux@tycho.nsa.gov>; Mon, 02 Oct 2017 14:55:16 -0700 (PDT)
MIME-Version: 1.0
From: David Graziano <david.graziano@rockwellcollins.com>
Date: Mon, 2 Oct 2017 16:54:54 -0500
Message-ID: <CA+RmS-8tfA9fkvY3AWviFdCrrYu8=FhtB=J9__rz_DMcGosoQw@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Labeling sysfs files
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I'm trying to find a way of labeling specific files/directories in
sysfs that do not exist at boot time. I'm running an embedded SELinux
enabled system (4.1 series kernel) where at boot there is an init
script performing a restorecon on /sys.  Sometime later a usb cellular
modem is powered on and enumerated at which point the it's sysfs
sub-directory structure is added.

This directory path is correctly getting my custom label via
restorecon during boot
/sys/devices/platform/xxxx/yyyy/fsl-ehci.0/usb1/

After the cellular modem is powered on the following directory
structure is created.
/sys/devices/platform/xxxx/yyyy/fsl-ehci.0/usb1/1-1/1-1:1.10/net/wwan1/qmi
Everything "1-1" and lower that is getting the "default" sysfs_t label.

Is there a method of labeling that newly added sub-directory structure
other than running restorecond or restorecon again? I specifically
need to control access to the "qmi" file. I've tried adding a genfscon
to the policy but it doesn't seem to work although I don't know if
it's suppose to.

Any advice would be appreciated.
