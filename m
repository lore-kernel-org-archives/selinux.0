Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QH4deZ011184
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 12:04:39 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1QH60W2015761
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 17:06:00 GMT
Message-ID: <45E31365.8060806@redhat.com>
Date: Mon, 26 Feb 2007 12:05:41 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: rpm-script needs to be able to look at running processes on the system
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

mcs is causing avc messages if usr logs in to root as s0, and wants to 
do a yum update, rpm_script is not allowed to look at running processes 
unless these privs are added.


--- nsaserefpolicy/policy/modules/admin/rpm.te  2007-02-19 
11:32:54.000000000 -0500
+++ serefpolicy-2.5.5/policy/modules/admin/rpm.te       2007-02-26 
11:02:34.000000000 -0500
@@ -256,6 +258,9 @@
 kernel_read_kernel_sysctls(rpm_script_t)
 kernel_read_system_state(rpm_script_t)
 
+mcs_killall(rpm_script_t)
+mcs_ptrace_all(rpm_script_t)
+
 dev_list_sysfs(rpm_script_t)
 
 # ideally we would not need this


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
