Subject: Re: [PATCH v2 1/2] security: Add hook to invalidate inode security
 labels
To: Andreas Gruenbacher <agruenba@redhat.com>
References: <1443986381-14412-1-git-send-email-agruenba@redhat.com>
 <1443986381-14412-2-git-send-email-agruenba@redhat.com>
 <5612927E.4000801@tycho.nsa.gov>
 <CAHc6FU78E-aTZP9gw51iO3e277AZ1UA7R-_Qw8Bwe=idJ=qmbg@mail.gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christoph Hellwig <hch@infradead.org>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56143D3A.3010802@tycho.nsa.gov>
Date: Tue, 6 Oct 2015 17:29:30 -0400
MIME-Version: 1.0
In-Reply-To: <CAHc6FU78E-aTZP9gw51iO3e277AZ1UA7R-_Qw8Bwe=idJ=qmbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/05/2015 05:56 PM, Andreas Gruenbacher wrote:
> On Mon, Oct 5, 2015 at 5:08 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> Not fond of these magic initialized values.
> 
> That should be a solvable problem.
> 
>> Is it always safe to call inode_doinit() from all callers of
>> inode_has_perm()?
> 
> As long as inode_has_perm is only used in contexts in which a file
> permission check / acl check would be possible, I don't see why not.
> 
>> What about the cases where isec->sid is used without going through
>> inode_has_perm()?
> 
> inode_has_perm seems to be called frequently and invalid labels seem
> to be reload quickly, so this change may make SELinux work well enough
> to be useful on top of gfs2 or similar. More checks would of course be
> better. The ideal case would be to always reload invalid labels, but
> that currently won't be possible because we don't have dentries
> everywhere.
> 
> I can't tell if this is this good enough to provide a useful level of
> protection. In any case, without a patch like this, on gfs2 and
> similar file systems, SELinux currently doesn't work at all.
> 
> How we can make progress with this problem?

I think we'd need to wrap all uses of inode->i_security with a helper that
applies this test.  FWIW, many/most of them seem to have a dentry
available, including all callers of inode_has_perm itself, so you could
just use inode_doinit_with_dentry() for all of those cases.  Maybe just
inline inode_has_perm() and get rid of it.

Need to deal appropriately with situations like selinux_inode_permission with
MAY_NOT_BLOCK.
