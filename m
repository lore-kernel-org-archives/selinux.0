Message-ID: <72222DC86846D411ABD300A0C9EB08A1015242B5@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        Timothy Wood
	 <timothy@hallcomp.com>
Cc: Paul Krumviede <pwk@acm.org>, SELinux <SELinux@tycho.nsa.gov>
Subject: Rules for SELinux in a vmware session
Date: Fri, 25 Jan 2002 12:16:59 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



I created the following rule for running selinux in a vmware session.

I currently have a prototype vmware domain for the host OS.


File: policy/domains/program/modutil.te

allow depmod_t etc_runtime_t:lnk_file r_file_perms;

File: policy/domains/system/initrc.te
# Read conf.modules.
# Added lnk_file for vmware session
allow initrc_t modules_conf_t:{ file lnk_file } r_file_perms;

File: policy/domains/system/kmod.te
# Read conf.modules.
# Additions for vmware session
allow kmod_t modules_conf_t:{ file lnk_file } r_file_perms;
allow kmod_t etc_runtime_t:lnk_file { read };

File: setfiles/file_contexts
# Added for vmware session
/etc/modules.conf(|.*)          system_u:object_r:modules_conf_t


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
