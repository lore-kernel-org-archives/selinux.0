From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: casey@schaufler-ca.com, chrisw@sous-sol.org, sds@tycho.nsa.gov,
        jmorris@namei.org, hch@lst.de, viro@zeniv.linux.org.uk
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC]Introduce generalized hooks for getting and setting inode secctx
Date: Wed,  5 Mar 2008 13:54:46 -0500
Message-Id: <1204743288-3461-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch set does two things. First it factors the section of vfs_setxattr
that does the real work into a helper function. This allows LSMs the ability to
set the xattrs they need without hitting the permission check inside
vfs_setxattr each time. Second it introduces two new hooks
inode_{get,set}secctx. The first hook retreives all security information the
LSM feels is relavent in the form of a security context. The second hook given
this context can set the in-core and on-disk store for the particular inode.
This differentiation is necessary since there are times when it is necessary
only to set the in-core representation.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
