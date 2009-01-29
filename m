From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com,
        linux-security-module@vger.kernel.org
Subject: [PATCH][RFC] selinux: remove noop secondary_ops calls
Date: Wed, 28 Jan 2009 19:55:28 -0800
Message-Id: <1233201347-17568-1-git-send-email-jmorris@namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


These patches remove calls to secondary_ops where there is no
real capability hook, and a couple of SELinux hooks which only
called these noop hooks.

(Following this, the noop capabilities hooks should also be removed).

Please review.

James Morris (18):
      selinux: remove unused bprm_check_security hook
      selinux: remove secondary ops call to bprm_committing_creds
      selinux: remove secondary ops call to bprm_committed_creds
      selinux: remove secondary ops call to sb_mount
      selinux: remove secondary ops call to sb_umount
      selinux: remove secondary ops call to inode_link
      selinux: remove secondary ops call to inode_unlink
      selinux: remove secondary ops call to inode_mknod
      selinux: remove secondary ops call to inode_follow_link
      selinux: remove secondary ops call to inode_permission
      selinux: remove secondary ops call to inode_setattr
      selinux: remove secondary ops call to file_mprotect
      selinux: remove secondary ops call to task_create
      selinux: remove unused cred_commit hook
      selinux: remove secondary ops call to task_setrlimit
      selinux: remove secondary ops call to task_kill
      selinux: remove secondary ops call to unix_stream_connect
      selinux: remove secondary ops call to shm_shmat

 security/selinux/hooks.c |   92 +---------------------------------------------
 1 files changed, 2 insertions(+), 90 deletions(-)


-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
