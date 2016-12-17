From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, sds@tycho.nsa.gov, Gary Tierney <gary.tierney@gmx.com>
Subject: [PATCH 0/2] kernel: add error handling / logging to
 sel_write_load()/sel_make_bools()
Date: Sat, 17 Dec 2016 20:48:37 +0000
Message-Id: <1482007719-14313-1-git-send-email-gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Adds error logging to sel_write_load() so there is warning/error messages about
what specifically failed.  Also prints a warning when security_genfs_sid()
fails in sel_make_bools() and defaults the labeling of the relevant /booleans/*
entries to SECINITSID_SECURITY.

Currently if security_genfs_sid() fails in sel_make_bools() the policy will
fail to load, and the system will consequently fail to complete booting.  This
is quite easy to reproduce on Fedora:

# semodule --cil -E base
# sed -i '/genfscon selinuxfs/d' base.cil
# semodule -i base.cil

This will cause load_policy to exit with an error, though it will seem as if
the policy was loaded succesfully (until reboot at least).  When rebooting I
see an error message and the system hangs for a while waiting on D-Bus and
eventually fails to start the login service:

SELinux:  Could not load policy file /etc/selinux/targeted/policy/policy.30:  No such file or directory
... snip ...
[FAILED] Failed to start Login Service.

With the first patch a message will be printed indicating where
sel_write_load() failed and print an error message in sel_make_bools(), the
second will print a warning then also use SECINITSID_SECURITY as a default SID:

[ 1682.776151] SELinux: sel_make_bools: no sid found, defaulting to security isid for /booleans/antivirus_can_scan_system
[ 1682.781782] SELinux: sel_make_bools: no sid found, defaulting to security isid for /booleans/antivirus_use_jit
[ 1682.787027] SELinux: sel_make_bools: no sid found, defaulting to security isid for /booleans/httpd_anon_write

With /sys/fs/selinux/booleans/* showing the correct labels (the security initial SID):

bash-4.3# ls -Z /sys/fs/selinux/booleans/ | head -n 5
system_u:object_r:security_t:s0 abrt_anon_write
system_u:object_r:security_t:s0 abrt_handle_event
system_u:object_r:security_t:s0 abrt_upload_watch_anon_write
system_u:object_r:security_t:s0 antivirus_can_scan_system
system_u:object_r:security_t:s0 antivirus_use_jit

Gary Tierney (2):
  selinux: log errors when loading new policy
  selinux: default to security isid in sel_make_bools() if no sid is
    found

 security/selinux/selinuxfs.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

--
2.7.4
