Subject: Additional permissions that appear to be necessary
From: Justin Smith <jsmith@mcs.drexel.edu>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: 29 Jan 2002 11:51:10 -0500
Message-Id: <1012323070.1329.4.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is apart from those made necessary by my own policy configuration
(i.e., they probably apply to all Redhat 7.2 installations):

allow initrc_t initrc_t:socket { create };

allow kmod_t kmod_t:capability { setuid };

allow logrotate_t logrotate_t:capability { sys_pacct };

allow system_crond_t etc_t:dir { setattr write };
allow system_crond_t file_labels_t:dir { setattr };
allow system_crond_t var_lib_rpm_t:dir { add_name write };
allow system_crond_t var_lib_rpm_t:file { create read write };
allow system_crond_t var_log_t:file { setattr write };


The last 5 lines only appear after running a system for several days so
that its periodic maintenance is performed.

-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
