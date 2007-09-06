Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l86GSInu003398
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 12:28:18 -0400
Received: from web36612.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l86GSGaK006312
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 16:28:16 GMT
Date: Thu, 6 Sep 2007 09:28:16 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH] 1/2 SELinux: Add get, set, and cloning of superblock security information
To: Eric Paris <eparis@redhat.com>, casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov, nfs@lists.sourceforge.net, sds@tycho.nsa.gov,
        jmorris@namei.org, steved@redhat.com, trond.myklebust@fys.uio.no
In-Reply-To: <1189095312.3418.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <214071.34429.qm@web36612.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Eric Paris <eparis@redhat.com> wrote:

> On Thu, 2007-09-06 at 08:59 -0700, Casey Schaufler wrote:
> > --- Eric Paris <eparis@redhat.com> wrote:
> > 
> > > Adds security_get_sb_mnt_opts, security_set_sb_mnt_opts, and
> > > security_clont_sb_mnt_opts to the LSM and to SELinux.  This is in
> > > preparation for NFS to be able to own its own mount options and remove
> > > the NFS specific code from SELinux.
> > 
> > What is the purpose of security_clone_sb_mnt_opts? I see where it is
> > being used, but it's not clear to me why it is necessary. The old SELinux
> > code doesn't clone the options, it filters out the ones it cares about.
> > If that is the behavior you'd expect of this hook, I suggest the name
> > reflect that, perhaps security_filter_sb_mnt_opts.
> 
> I'm not sure what you mean by filter and I don't know which code you are
> referring to.
> 
> At the moment the only user of clone is nfs nohide mounts.  Given an
> exports list like
> 
> /export *()
> /export/nohide *(nohide)
> 
> where /export/nohide actually crosses a filesystem boundry the nfs
> client will quietly mount the new export on your machine as soon as you
> enter that directory.  Assuming the user originally mounted /export with
> some security options when nfs mounts this new export there needs to be
> some way to propogate those security options forward to this new mount.
> So the one usage of clone simply takes the security options from the
> superblock related to /export and applies those to the new security
> block related to /export/nohide

That is perfectly sensible. Is the intent to clone all the mount options
or just the security mount options? Inquiring LSM writers want to know.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
