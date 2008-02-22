Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MD73W7009005
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 08:07:03 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1MD71DE016486
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 13:07:01 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <55722.57422.qm@web36602.mail.mud.yahoo.com>
References: <55722.57422.qm@web36602.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, Trond.Myklebust@netapp.com, chuck.lever@oracle.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 09/37] Security: Allow kernel services to override LSM settings for task actions
Date: Fri, 22 Feb 2008 13:06:29 +0000
Message-ID: <20272.1203685589@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> > +static int smack_task_kernel_act_as(struct task_struct *p,
> > +				    struct task_security *sec, u32 secid)
> > +{
> > +	return -ENOTSUPP;
> > +}
> ...
> > +static int smack_task_create_files_as(struct task_struct *p,
> > +				      struct task_security *sec,
> > +				      struct inode *inode)
> > +{
> > +	return -ENOTSUPP;
> > +}
> 
> Hum. ENOTSUPP is not not very satisfying, is it? I will have to
> think on this a bit.

Sorry, I meant to ping you on this directly.  I'm not sure how to effect these
two functions for Smack.

> Except for the fact that the hooks don't do anything this
> looks fine. I'm not sure that I would want these hooks to
> do anything, it requires additional thought to determine if
> there is a good behavior for them.

Note that you won't be able to use CacheFiles with Smack if either of these
just returns an error.  This may also affect NFSd in the future too.

smack_task_create_files_as() is passed the label that new files created by
CacheFiles should be created with.

For smack_task_kernel_act_as(), it may be sufficient to set CAP_MAC_OVERRIDE in
the task_security struct and leave it as that.  It also may not be sufficient,
as NFSd may end up using this to set the subjective security label supplied by
the NFS client.  I don't know, though, whether Smack is going to be involved in
that passing labels over NFS.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
