Message-ID: <4851361E.3030305@windriver.com>
Date: Thu, 12 Jun 2008 10:43:42 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: libsemanage.semanage_install_active: error during semodule -n -v
 -b base.pp -s refpolicy
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

During the "make load" procedure with refpolicy, the semodule command 
fails, so I tried it manually and I see this error.

root@ubuntu:/home/vikram/refpolicy-ac# semodule -b 
/usr/share/selinux/refpolicy/base.pp -s refpolicy -v -n
Attempting to install base module '/usr/share/selinux/refpolicy/base.pp':
Ok: return value of 0.
Committing changes:
libsemanage.semanage_install_active: setfiles returned error code 1. (No 
such file or directory).
libsemanage.semanage_install_active: Could not copy 
/etc/selinux/refpolicy/modules/active/policy.kern to 
/etc/selinux/refpolicy/policy/policy.23. (No such file or directory).
semodule:  Failed!

root@ubuntu:/home/vikram/refpolicy-ac# find /etc/selinux/
/etc/selinux/
/etc/selinux/refpolicy
/etc/selinux/refpolicy/contexts
/etc/selinux/refpolicy/contexts/failsafe_context
/etc/selinux/refpolicy/contexts/securetty_types
/etc/selinux/refpolicy/contexts/x_contexts
/etc/selinux/refpolicy/contexts/netfilter_contexts
/etc/selinux/refpolicy/contexts/userhelper_context
/etc/selinux/refpolicy/contexts/dbus_contexts
/etc/selinux/refpolicy/contexts/customizable_types
/etc/selinux/refpolicy/contexts/initrc_context
/etc/selinux/refpolicy/contexts/default_contexts
/etc/selinux/refpolicy/contexts/users
/etc/selinux/refpolicy/contexts/users/staff_u
/etc/selinux/refpolicy/contexts/users/user_u
/etc/selinux/refpolicy/contexts/users/root
/etc/selinux/refpolicy/contexts/removable_context
/etc/selinux/refpolicy/contexts/default_type
/etc/selinux/refpolicy/contexts/files
/etc/selinux/refpolicy/contexts/files/file_contexts.homedirs
/etc/selinux/refpolicy/contexts/files/media
/etc/selinux/refpolicy/contexts/files/file_contexts
/etc/selinux/refpolicy/policy
/etc/selinux/refpolicy/policy/policy.23
/etc/selinux/refpolicy/seusers
/etc/selinux/refpolicy/modules
/etc/selinux/refpolicy/modules/active
/etc/selinux/refpolicy/modules/active/modules
/etc/selinux/refpolicy/modules/semanage.read.LOCK
/etc/selinux/refpolicy/modules/semanage.trans.LOCK


root@ubuntu:/home/vikram/refpolicy-ac# find /usr/share/selinux/
/usr/share/selinux/
/usr/share/selinux/refpolicy
/usr/share/selinux/refpolicy/[lots of .pp files]


Could I get some suggestions to what may be the cause of this error?

Thank you.

Vikram

-- 
Vikram Ambrose | Linux Products Division | WindRiver Corporation


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
