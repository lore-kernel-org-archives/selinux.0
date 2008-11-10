Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAALcwXl000461
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2008 16:38:58 -0500
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAALbD0Y004062
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2008 21:37:14 GMT
Received: by nf-out-0910.google.com with SMTP id b21so1275687nfd.4
        for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2008 13:38:57 -0800 (PST)
Message-ID: <dd18b0c30811101338l6814f367r8e5f367c5611973d@mail.gmail.com>
Date: Mon, 10 Nov 2008 13:38:57 -0800
From: "Justin Mattock" <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1b6
Cc: tresys <refpolicy@oss.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

when loading the latest refpolicy from svn I see this
with a dmesg | grep SELinux




[    0.010000] SELinux:  Initializing.
[    0.010000] SELinux:  Starting in permissive mode
[    0.606504] SELinux:  Registering netfilter hooks
[    2.809029] SELinux: 8192 avtab hash slots, 142179 rules.
[    2.903562] SELinux: 8192 avtab hash slots, 142179 rules.
[    3.068351] SELinux:  7 users, 9 roles, 2658 types, 95 bools
[    3.076157] SELinux:  73 classes, 142179 rules
[    3.090204] SELinux:  Completing initialization.
[    3.097885] SELinux:  Setting up existing superblocks.
[    3.136387] SELinux: initialized (dev sda1, type ext3), uses xattr
[    3.254102] SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
[    3.261882] SELinux: initialized (dev selinuxfs, type selinuxfs),
uses genfs_contexts
[    3.269736] SELinux: initialized (dev mqueue, type mqueue), uses
transition SIDs
[    3.277673] SELinux: initialized (dev hugetlbfs, type hugetlbfs),
uses genfs_contexts
[    3.285600] SELinux: initialized (dev devpts, type devpts), uses
transition SIDs
[    3.293522] SELinux: initialized (dev inotifyfs, type inotifyfs),
uses genfs_contexts
[    3.301575] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
[    3.309599] SELinux: initialized (dev anon_inodefs, type
anon_inodefs), uses genfs_contexts
[    3.317908] SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
[    3.326135] SELinux: initialized (dev debugfs, type debugfs), uses
genfs_contexts
[    3.334374] SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
[    3.342575] SELinux: initialized (dev proc, type proc), uses genfs_contexts
[    3.350620] SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
[    3.358385] SELinux: initialized (dev rootfs, type rootfs), uses
genfs_contexts
[    3.366247] SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
[    4.238057] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
[    4.448447] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
[    4.466671] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
[   10.215741] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
[   13.022618] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
[   17.496954] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   18.036035] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   18.056560] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   18.442620] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   18.568128] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   18.821974] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   19.893332] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   20.231539] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   20.388169] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   21.113006] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   21.124618] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   21.135766] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   21.445777] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   21.559879] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   21.667643] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   22.043597] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   22.097478] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   22.134225] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   22.155972] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   22.245517] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   22.268845] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   22.279830] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   22.450408] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   22.468437] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   22.485329] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   22.615547] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   22.654946] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   22.858598] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   22.882955] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   22.984151] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   33.012322] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   37.044951] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   38.140604] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   38.141662] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   38.648394] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   39.146536] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   39.408666] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   39.519031] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   39.828370] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   40.767784] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   41.716116] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   41.834767] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   41.840503] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   42.071528] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   42.075675] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   42.083109] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ed
[   42.084113] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ed
[   44.711545] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1ff
[   51.125148] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6
[   51.233138] SELinux: WARNING: inside open_file_mask_to_av with
unknown mode:c1b6


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
