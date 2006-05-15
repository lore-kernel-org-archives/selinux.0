Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
        Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
        James Morris <jmorris@redhat.com>
In-Reply-To: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 15 May 2006 13:41:20 -0400
Message-Id: <1147714880.30789.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-15 at 12:35 -0400, Stephen Smalley wrote:
> Introduce support for deferring mapping of security contexts in the
> SID table upon policy reload, and use this support for inode security
> contexts when the context is not yet valid under the current policy.
> Only processes with 'labelpriv' permission to the 'security' class can
> set such invalid security contexts on inodes.  Inodes with such
> invalid contexts are treated as having the unlabeled SID until the context 
> becomes valid under a policy.  This support is for use by privileged processes
> like rpm that need to set down files in the proper security contexts prior to 
> loading the policy module that defines the context and its associated rules.

Also requires this diff on top of the other one to map labelpriv to a
string in avc messages:

diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/include/av_perm_to_string.h linux-2.6.17-rc3-mm1-x/security/selinux/include/av_perm_to_string.h
--- linux-2.6.17-rc3-mm1/security/selinux/include/av_perm_to_string.h	2006-05-15 13:22:03.000000000 -0400
+++ linux-2.6.17-rc3-mm1-x/security/selinux/include/av_perm_to_string.h	2006-05-15 12:26:56.000000000 -0400
@@ -87,6 +87,7 @@
    S_(SECCLASS_SECURITY, SECURITY__SETBOOL, "setbool")
    S_(SECCLASS_SECURITY, SECURITY__SETSECPARAM, "setsecparam")
    S_(SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT, "setcheckreqprot")
+   S_(SECCLASS_SECURITY, SECURITY__LABELPRIV, "labelpriv")
    S_(SECCLASS_SYSTEM, SYSTEM__IPC_INFO, "ipc_info")
    S_(SECCLASS_SYSTEM, SYSTEM__SYSLOG_READ, "syslog_read")
    S_(SECCLASS_SYSTEM, SYSTEM__SYSLOG_MOD, "syslog_mod")

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
