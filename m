Date: Thu, 26 Jan 2006 16:14:08 -0600
From: Chad Hanson <chanson@TrustedCS.com>
To: SELinux List <selinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] mls password policy
Message-ID: <20060126221408.GB13211@dhcp-236.il.tcs-sec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Below is a patch to enable generic user password changing at labels above s0.
The passwd command only changes the shadow file and does not touch the
password file. The chfn/chsh commands do not have MLS privileges, so there
is not a downgrade channel at the current time.

-Chad


diff -Nur serefpolicy-2.2.4/policy/modules/admin/usermanage.te serefpolicy-2.2.4.new/policy/modules/admin/usermanage.te
--- serefpolicy-2.2.4/policy/modules/admin/usermanage.te	2006-01-23 07:33:45.000000000 -0600
+++ serefpolicy-2.2.4.new/policy/modules/admin/usermanage.te	2006-01-25 15:54:16.000000000 -0600
@@ -328,6 +328,9 @@
 
 miscfiles_read_localization(passwd_t)
 
+mls_file_write_down(passwd_t)
+mls_file_downgrade(passwd_t)
+
 seutil_dontaudit_search_config(passwd_t)
 
 userdom_use_unpriv_users_fd(passwd_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
