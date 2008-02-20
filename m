Subject: Re: NFS/LSM: allow NFS to control all of its own mount options
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
        linux-nfs@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, steved@redhat.com,
        jlayton@redhat.com, jmorris@namei.org, casey@schaufler-ca.com,
        trond.myklebust@fys.uio.no, chuck.lever@oracle.com,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <1203515410.9902.128.camel@moss-spartans.epoch.ncsc.mil>
References: <1203457094.2928.113.camel@localhost.localdomain>
	 <20080219222408.GB10656@infradead.org>
	 <E1JRlsG-0004UB-H4@pomaz-ex.szeredi.hu>
	 <1203515410.9902.128.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 20 Feb 2008 08:56:58 -0500
Message-Id: <1203515818.2928.138.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-20 at 08:50 -0500, Stephen Smalley wrote:
> On Wed, 2008-02-20 at 11:08 +0100, Miklos Szeredi wrote:
> > > Please don't introduce a special case for just nfs.  All filesystems
> > > should control their mount options, so please provide some library
> > > helpers for context= handling and move it into all filesystems that
> > > can support selinux.
> > 
> > Hmm, looks like selinux is not showing it's mount options in
> > /proc/mounts.  Well, actually there's no infrastructure for it either.
> > Here's a template patch (completely untested).
> 
> I think the intent is to use the security_sb_get_mnt_opts() hook for
> this purpose.

It was.  I already knew about this issue and its 'on my list.'  Although
I guess we need a something ?new LSM hook? which will translate the
sb_get_mnt_opts stuff into a single text string.  Or I guess really that
can be done in you sb_show_options and I can just use sb_get_mnt_opts
under the covers.  Anyway, unrelated issue that will get fixed as soon
as this real BUG() is fixed.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
