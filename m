Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2JE4pH7009131
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 10:04:51 -0400
Received: from web36604.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m2JE4oGp024823
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 14:04:50 GMT
Date: Wed, 19 Mar 2008 06:38:09 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC]Introduce generalized hooks for getting and setting inode secctx v3
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>, casey@schaufler-ca.com,
        chrisw@sous-sol.org, sds@tycho.nsa.gov, jmorris@namei.org, hch@lst.de,
        viro@zeniv.linux.org.uk
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
In-Reply-To: <1205866664-24902-1-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <868245.60928.qm@web36604.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:

> This patch set does two things. First it factors the section of vfs_setxattr
> that does the real work into a helper function. This allows LSMs the ability
> to
> set the xattrs they need without hitting the permission check inside
> vfs_setxattr each time.

Why is this important? I'm perfectly willing to believe that it is,
but I would hesitate to say that it's completely obvious to the
casual observer. After all, we've gotten by with things the way they
are for some time. Perhaps you could describe the use to which you
would be putting this. I expect that if I go through the backlog
discussions on or about this topic I could probably make some
logical assumptions about what you want to do, but it will save
everyone some time if you could spell it out here.

> Second it introduces three new hooks
> inode_{get,set}secctx, and inode_notifysecctx.
>
> The first hook retreives all security information the
> LSM feels is relavent in the form of a security context. The second hook
> given
> this context can sets both the in-core and on-disk store for the particular
> inode. The third hook is used to notify the in-core inode of a change to it's
> security state.

I still dislike having an interface that explicitly disallows
security attribute integrity. That does not help me feel secure.

> This is the third revision of this patch which takes into account concerns by
> Casey Schaufler, and Christop Hellwig.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
