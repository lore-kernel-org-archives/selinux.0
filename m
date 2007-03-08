Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28Fb2Na007644
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 10:37:02 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28Fb0wk020105
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 15:37:00 GMT
Message-ID: <45F02D99.7070202@redhat.com>
Date: Thu, 08 Mar 2007 10:36:57 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: fix /dev/ub specification
Content-Type: multipart/mixed;
 boundary="------------030108090208060305050805"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030108090208060305050805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------030108090208060305050805
Content-Type: text/plain;
 name="nsaserefpolicy_policy_modules_kernel_storage.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_kernel_storage.fc"

--- nsaserefpolicy/policy/modules/kernel/storage.fc	2006-11-16 17:15:04.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/kernel/storage.fc	2007-03-08 08:42:37.000000000 -0500
@@ -42,7 +42,8 @@
 /dev/sjcd		-b	gen_context(system_u:object_r:removable_device_t,s0)
 /dev/sonycd		-b	gen_context(system_u:object_r:removable_device_t,s0)
 /dev/tape.*		-c	gen_context(system_u:object_r:tape_device_t,s0)
-/dev/ub[a-z]		-b	gen_context(system_u:object_r:removable_device_t,mls_systemhigh)
+/dev/tw[a-z][^/]+	-c	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
+/dev/ub[a-z][^/]+	-b	gen_context(system_u:object_r:removable_device_t,mls_systemhigh)
 /dev/ubd[^/]*		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
 /dev/xvd[^/]*		-b	gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
 

--------------030108090208060305050805--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
