Subject: sepol_genusers
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>, Karl MacMillan <kmacmillan@tresys.com>
Content-Type: text/plain
Message-Id: <1108656216.24494.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 17 Feb 2005 11:03:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As per the earlier discussions of improving user management, the
genpolusers logic has been moved into a libsepol function,
sepol_genusers(), that can act on an in-memory binary policy image prior
to loading.  The genpolusers utility is now a trivial utility in
libsepol rather than part of the checkpolicy package.  A
selinux_users_path() function has been added to libselinux to allow
programs to get the path to the directory
(/etc/selinux/$SELINUXTYPE/users/) containing the runtime user
configuration files (system.users, local.users) so that they can pass
this path to sepol_genusers().  load_policy has been modified to call
sepol_genusers() prior to policy load in a similar manner to how it
already calls sepol_genbools().  /sbin/init still needs to be modified
in the same manner.

These changes are included in libsepol >= 1.3.5, checkpolicy >= 1.21.4,
libselinux >= 1.21.10, and policycoreutils >= 1.21.16.  Note that the
new load_policy depends on the new libselinux and libsepol for the
selinux_users_path() and sepol_genusers() functions.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
