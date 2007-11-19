Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAJG0SZp014138
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 11:00:28 -0500
Received: from web36602.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lAJG0RxK019102
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 16:00:27 GMT
Date: Mon, 19 Nov 2007 08:00:11 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [Labeled-nfs] [PATCH 08/13] NFS: Introduce lifecycle managment for label attribute.
To: James Morris <jmorris@namei.org>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: Labeled NFS <labeled-nfs@linux-nfs.org>, selinux@tycho.nsa.gov
In-Reply-To: <Xine.LNX.4.64.0711192226180.20955@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <967921.55654.qm@web36602.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- James Morris <jmorris@namei.org> wrote:

> On Fri, 16 Nov 2007, David P. Quigley wrote:
> 
> 
> > +#ifdef CONFIG_SECURITY
> > +#define	nfs_fattr_alloc(fattr)						\
> > +{									\
> > +	(fattr)->label = kmalloc(NFS_MAXLABELLEN, GFP_ATOMIC);		\
> > +	(fattr)->label_len = NFS_MAXLABELLEN;				\
> > +	memset((fattr)->label, 0, NFS_MAXLABELLEN);			\
> > +}
> 
> These should be normal functions, perhaps in their own file which is 
> conditionally built (and containing other label-specific code).
> 
> You need to check the return of kmalloc().
> 
> I suggest passing a gfp_t parameter to the allocation function to allow 
> the caller to determine the allocation flags (unless you know it will 
> always be GFP_ATOMIC).
> 
> Use kzalloc() instead of kmalloc() + memset().
> 
> It seems wasteful to always allocate the maximum sized label.

You could have a look at the smack_import() scheme. If you're
looking at a gazillion enormous, short lived labels on a system
it would be a bad choice, but even if you're labeling every file
differently (please say you're not) you may find it a better
mechanism. Your label lifecycle management issues go "poof".

Just a thought.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
