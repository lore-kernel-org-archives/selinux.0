Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3SF2WGM026779
	for <selinux@tycho.nsa.gov>; Mon, 28 Apr 2008 11:02:32 -0400
Received: from web36607.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m3SF2Rd0029836
	for <selinux@tycho.nsa.gov>; Mon, 28 Apr 2008 15:02:27 GMT
Date: Mon, 28 Apr 2008 08:02:11 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH]Introduce generalized hooks for getting and setting inode secctx.
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>, casey@schaufler-ca.com,
        chrisw@sous-sol.org, sds@tycho.nsa.gov, jmorris@namei.org, hch@lst.de,
        viro@zeniv.linux.org.uk
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
In-Reply-To: <1208969836-8129-1-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <106538.45347.qm@web36607.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:

> 
> This patch set does two things. First it factors the section of vfs_setxattr
> that does the real work into a helper function. This allows LSMs the ability 
> to set the xattrs they need without hitting the permission check inside
> vfs_setxattr each time. Second it introduces three new hooks
> inode_{get,set}secctx, and inode_notifysecctx.
> 
> The first hook retreives all security information the LSM feels is relavent
> in
> the form of a security context. The second hook given this context can sets
> both the in-core and on-disk store for the particular inode. The third hook
> is
> used to notify the in-core inode of a change to it's security state.
> 
> This is the fourth revision of this patch set which takes into account
> concerns by Casey Schaufler, and Christop Hellwig.
> 
> fs/xattr.c               |   57 ++++++++++++++++++++++++++++++++++-----------
> include/linux/security.h |   50 ++++++++++++++++++++++++++++++++++++++++
> include/linux/xattr.h    |    1 +
> security/dummy.c         |   17 +++++++++++++
> security/security.c      |   18 ++++++++++++++
> security/selinux/hooks.c |   28 ++++++++++++++++++++++
> 6 files changed, 157 insertions(+), 14 deletions(-)

These patches don't appear to cause any harm, but I remain
unconvinced regarding the approach you're taking.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
