Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5NJG287008309
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 15:16:02 -0400
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5NJG0GK028335
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 19:16:01 GMT
Subject: Re: pam_mount
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1214226750.11146.232.camel@gorn>
References: <1214047062.30904.13.camel@vogon>
	 <1214226750.11146.232.camel@gorn>
Content-Type: multipart/mixed; boundary="=-VJKgQg/uPt7tgxa1WodH"
Date: Mon, 23 Jun 2008 21:15:39 +0200
Message-Id: <1214248539.5486.10.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-VJKgQg/uPt7tgxa1WodH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached patch solves a problem of local logins while using pam_mount.
In xserver.te GDM already has this permission to
manage /var/run/pam_mount. Therefore GDM logins which use pam_mount to
e.g. decrypt a partition work. But local logins not.

I also had a lot of strange { getattr search } requests of mount. I
dontaudit everyone and the login still works. I'm not sure if we should
add these ones to mount_t:

domain_dontaudit_search_all_domains_state(mount_t)
dontaudit mount_t pam_var_console_t:file write;
dontaudit mount_t self:process ptrace;
dontaudit mount_t proc_net_t:lnk_file read;

Nevertheless with the attached patch local logins via pam_mount work.

I cc'd Dan in the hope that he will add the patch to the upstream policy
of Fedora. Then I don't have to install a local policy for every
installation. Lazy me ;-)

--=-VJKgQg/uPt7tgxa1WodH
Content-Disposition: attachment; filename=locallogin.te.patch
Content-Type: text/x-patch; name=locallogin.te.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- /usr/src/refpolicy-20080402/policy/modules/system/locallogin.te	2008-06-23 20:53:58.000000000 +0200
+++ policy/modules/system/locallogin.te	2008-06-23 20:54:32.000000000 +0200
@@ -100,6 +100,7 @@
 
 auth_rw_login_records(local_login_t)
 auth_rw_faillog(local_login_t)
+auth_manage_pam_pid(local_login_t)
 auth_manage_pam_console_data(local_login_t)
 auth_domtrans_pam_console(local_login_t)
 

--=-VJKgQg/uPt7tgxa1WodH--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
