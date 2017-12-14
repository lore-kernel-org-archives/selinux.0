Message-ID: <1513256850.18008.1.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: yangjihong <yangjihong1@huawei.com>, "paul@paul-moore.com"
 <paul@paul-moore.com>, "eparis@parisplace.org" <eparis@parisplace.org>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Daniel J Walsh <dwalsh@redhat.com>, Lukas Vrabec <lvrabec@redhat.com>,
 Petr Lautrbach <plautrba@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 14 Dec 2017 08:07:30 -0500
In-Reply-To: <1BC3DBD98AD61A4A9B2569BC1C0B4437D5D2AF@DGGEMM506-MBS.china.huawei.com>
References: <1BC3DBD98AD61A4A9B2569BC1C0B4437D5D1F3@DGGEMM506-MBS.china.huawei.com>
 <1513178296.19161.8.camel@tycho.nsa.gov>
 <1BC3DBD98AD61A4A9B2569BC1C0B4437D5D2AF@DGGEMM506-MBS.china.huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [BUG]kernel softlockup due to sidtab_search_context run for
 long time because of too many sidtab context node
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-12-14 at 03:19 +0000, yangjihong wrote:
> Hello,
> 
> >  So, does docker just keep allocating a unique category set for
> > every new container, never reusing them even if the container is
> > destroyed? 
> >  That would be a bug in docker IMHO.  Or are you creating an
> > unbounded number of containers and never destroying the older ones?
> 
> I creat a containers, then destroy it,  and create second one,
> destroy it.......
> When docker created, it will mount overlay fs, because every
> containers has different selinux context, so a new sidtab node is
> generated and insert into the sidtab list  
> When docker destroyed, it will umount overlay fs, but umount
> operation does not seem relevant to "delete the node" hooks function,
> resulting in longer and longer sidtab list
> I think when umount, its selinux context will never reuse, so sidtab
> node is useless, it is best to delete i

The "selinux context will never reuse" is IMHO a bug in docker; if you
truly destroy the container (i.e. don't just stop its execution, but
delete it entirely), then the context should be reusable.

> >  sidtab_search_context() could no doubt be optimized for the
> > negative case; there was an earlier optimization for the positive
> > case by adding a cache to sidtab_context_to_sid() prior to calling
> > it.  It's a reverse lookup in the sidtab.
> 
> I think add cache may be not very userful, because every containers
> has different selinux context, so when one docker created, it will
> search the whole sidtab list, until compare the last node, When a new
> node arrives, it is always necessary to compare all the nodes first,
> and then insert. 
> All as long as the list does not delete the node, list will always
> increase, and search time will longer and longer, eventually leading
> to softlockup
> 
> 
> Is there any solution to this problem?

On the kernel side, we could certainly implement a reverse lookup hash
table.  And there could be a faster way to quickly check whether a
given category set has ever been used if we wanted to specialize in
that manner.  But that won't fix the fact that docker is allocating
unbounded security contexts.
