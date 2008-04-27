Date: Mon, 28 Apr 2008 09:33:22 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: Casey Schaufler <casey@schaufler-ca.com>,
        Chris Wright <chrisw@sous-sol.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, hch@lst.de,
        viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nfsv4@linux-nfs.org
Subject: Re: [PATCH]Introduce generalized hooks for getting and setting inode
 secctx.
In-Reply-To: <1208969836-8129-1-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <Xine.LNX.4.64.0804280932520.17090@us.intercode.com.au>
References: <1208969836-8129-1-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 23 Apr 2008, David P. Quigley wrote:

> 
> This patch set does two things. First it factors the section of vfs_setxattr
> that does the real work into a helper function. This allows LSMs the ability 
> to set the xattrs they need without hitting the permission check inside
> vfs_setxattr each time. Second it introduces three new hooks
> inode_{get,set}secctx, and inode_notifysecctx.
> 
> The first hook retreives all security information the LSM feels is relavent in
> the form of a security context. The second hook given this context can sets
> both the in-core and on-disk store for the particular inode. The third hook is
> used to notify the in-core inode of a change to it's security state.
> 
> This is the fourth revision of this patch set which takes into account
> concerns by Casey Schaufler, and Christop Hellwig.

Cristoph, Casey -- any chance of getting ack or nack on this before the 
merge window closes?

Thanks.


> 
> fs/xattr.c               |   57 ++++++++++++++++++++++++++++++++++-----------
> include/linux/security.h |   50 ++++++++++++++++++++++++++++++++++++++++
> include/linux/xattr.h    |    1 +
> security/dummy.c         |   17 +++++++++++++
> security/security.c      |   18 ++++++++++++++
> security/selinux/hooks.c |   28 ++++++++++++++++++++++
> 6 files changed, 157 insertions(+), 14 deletions(-)
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
