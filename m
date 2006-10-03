Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93GeYUu017519
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 12:40:34 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k93GdN50028994
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 16:39:24 GMT
Subject: Range transitions in modules+refpolicy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 12:40:26 -0400
Message-Id: <1159893626.14831.51.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Now that range transitions have been integrated into refpolicy
appropriately, I came up with the following changes,

MLS:

-range_transition kernel_t lvm_exec_t s0 - s15:c0.c255;
+range_transition NetworkManager_t initrc_exec_t:process s0 - s15:c0.c255;
+range_transition anaconda_t initrc_exec_t:process s0 - s15:c0.c255;
+range_transition apmd_t initrc_exec_t:process s0 - s15:c0.c255;
+range_transition dpkg_script_t initrc_exec_t:process s0 - s15:c0.c255;
+range_transition dpkg_t initrc_exec_t:process s0 - s15:c0.c255;
+range_transition firstboot_t initrc_exec_t:process s0 - s15:c0.c255;
+range_transition hald_t initrc_exec_t:process s0 - s15:c0.c255;
+range_transition hotplug_t initrc_exec_t:process s0 - s15:c0.c255;
+range_transition init_t initrc_exec_t:process s0 - s15:c0.c255;
+range_transition initrc_t lvm_exec_t s0 - s15:c0.c255;
+range_transition logrotate_t initrc_exec_t:process s0 - s15:c0.c255;
+range_transition rpm_script_t initrc_exec_t:process s0 - s15:c0.c255;
+range_transition rpm_t initrc_exec_t:process s0 - s15:c0.c255;

MCS:

+range_transition NetworkManager_t initrc_exec_t:process s0;
+range_transition anaconda_t initrc_exec_t:process s0;
+range_transition apmd_t initrc_exec_t:process s0;
+range_transition dpkg_script_t initrc_exec_t:process s0;
+range_transition dpkg_t initrc_exec_t:process s0;
+range_transition firstboot_t initrc_exec_t:process s0;
+range_transition hald_t initrc_exec_t:process s0;
+range_transition hotplug_t initrc_exec_t:process s0;
+range_transition init_t initrc_exec_t:process s0;
+range_transition logrotate_t initrc_exec_t:process s0;
+range_transition rpm_script_t initrc_exec_t:process s0;
+range_transition rpm_t initrc_exec_t:process s0;

In both cases, the additions are because the range transition was added
to the interface for transitioning to initrc_t to handle the prexisting
range transitions on initrc_exec_t.  I looked into the removal in the
MLS policy, and there isn't a way for kernel_t to transition to lvm_t,
so that removal should be ok.

Comments on this change (in particular the MLS changes)?  Are they
reasonable, or do we need a separate interface for non range transition
to initrc_t?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
