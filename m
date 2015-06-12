From: "Roberts, William C" <william.c.roberts@intel.com>
To: "'Greg KH'" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] kernfs: hook inode initialization for LSMs
Date: Fri, 12 Jun 2015 01:29:39 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC56010241E7@ORSMSX103.amr.corp.intel.com>
References: <1433877101-31866-1-git-send-email-william.c.roberts@intel.com>
 <1433877101-31866-2-git-send-email-william.c.roberts@intel.com>
 <20150609210925.GB16038@kroah.com>
 <476DC76E7D1DF2438D32BFADF679FC560101BD9B@ORSMSX103.amr.corp.intel.com>
 <20150610160150.GA31100@kroah.com>
In-Reply-To: <20150610160150.GA31100@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Selinux@tycho.nsa.gov" <Selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<snip>
> > > > +	int error = 0;
> > > >  	kernfs_get(kn);
> > > >  	inode->i_private = kn;
> > > >  	inode->i_mapping->a_ops = &kernfs_aops; @@ -291,6 +293,8 @@
> > > static
> > > > void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
> > > >  	set_default_inode_attr(inode, kn->mode);
> > > >  	kernfs_refresh_inode(kn, inode);
> > > >
> > > > +	WARN_ON(kn->parent && !parent);
> > >
> > > What can a developer do about this?
> > This means that the node has a parent, but you didn't pass it as its
> > argument. Doing a lookup internally, instead Of passing parent,
> > results in a recursive lookup all the way to the root node as to get
> > the inode for The parent one must do a kernfs_get_inode() on it, which
> > can call the initialization routine, which calls Kernfs_get_inode().
> > What the developer should do is forward the inode from the parent so
> > we can Avoid the recursive lookup and any lookup in general. This is
> > based on where this was getting called from, the parent inode was
> > readily available. That WARN_ON is not even strict enough, read
> > further down I mention it again. The goal is that We don't end up
> > skipping LSM initialization by accident, ie kn has parent but they do not pass
> parent. Alternatively, We can move the warning (and make it proper) to right
> before the LSM hook and make sure that parent arg And kn->parent are
> either both specified or both unspecified ie XOR. !a != !b. Rather than litter
> the top level functions With this warning. Also, I chose warn_on because I
> didn't want it to be fatal, however, I am not arguing that its proper And am
> seeking alternative suggestions.
>  
> But again, what can a driver do about this?  If this shouldn't happen, then
> don't test for it.  This isn't something that a driver developer should care
> about, right?  If not, then is it something that the sysfs core could be doing?
> If so, then fix the sysfs core.

All of these modifications are to kernfs internal users and will not affect the users
of kernfs (like cgroups and sysfs) from a modules perspective. In reality, the only
Intended purpose was to keep someone from "in the future" accidentally modifying
Kernfs and calling the wrong function. I guess serving that need is rather pointless.

With that said, I have been thinking about the "too deep to unwind" comment you made.
I guess I don't follow. Eventually that kernfs node and inode would come back from the init routine
To eventually be undone at later time when things are removed from the cache. The reversal
Process for kernfs looks like the inode eviction routine kernfs_evict_inode(). Which only handles
Some of it (handles kernfs + readying the inode for eviction), the ref on the inode needs to be put,
so an iput() should end up calling iput_final() and evict(inode). Although, this is just  from me
browsing the code, I'd like to add a poison filename value to my test module that will cause an
LSM failure and verify the failure case. The failure case, in theory should only be traversed on
ENOMEM cases within the LSM itself. If there are more details I am missing, I'd be eager to
Understand what they are.
