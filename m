Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB4LvUZD015049
 for <selinux@tycho.nsa.gov>; Fri, 4 Dec 2015 16:57:30 -0500
Date: Fri, 4 Dec 2015 15:57:22 -0600
From: "Serge E. Hallyn" <serge.hallyn@ubuntu.com>
To: Seth Forshee <seth.forshee@canonical.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Miklos Szeredi <miklos@szeredi.hu>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 linux-bcache@vger.kernel.org, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.sourceforge.net,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 18/19] fuse: Restrict allow_other to the superblock's
 namespace or a descendant
Message-ID: <20151204215722.GB5699@mail.hallyn.com>
References: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
 <1449070821-73820-19-git-send-email-seth.forshee@canonical.com>
 <20151204200541.GI3624@mail.hallyn.com>
 <20151204204319.GF147214@ubuntu-hedt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151204204319.GF147214@ubuntu-hedt>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Dec 04, 2015 at 02:43:19PM -0600, Seth Forshee wrote:
> On Fri, Dec 04, 2015 at 02:05:41PM -0600, Serge E. Hallyn wrote:
> > Quoting Seth Forshee (seth.forshee@canonical.com):
> > > Unprivileged users are normally restricted from mounting with the
> > > allow_other option by system policy, but this could be bypassed
> > > for a mount done with user namespace root permissions. In such
> > > cases allow_other should not allow users outside the userns
> > > to access the mount as doing so would give the unprivileged user
> > > the ability to manipulate processes it would otherwise be unable
> > > to manipulate. Restrict allow_other to apply to users in the same
> > > userns used at mount or a descendant of that namespace.
> > > 
> > > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> > > ---
> > >  fs/fuse/dir.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > > index f67f4dd86b36..5b8edb1203b8 100644
> > > --- a/fs/fuse/dir.c
> > > +++ b/fs/fuse/dir.c
> > > @@ -1018,8 +1018,14 @@ int fuse_allow_current_process(struct fuse_conn *fc)
> > >  {
> > >  	const struct cred *cred;
> > >  
> > > -	if (fc->flags & FUSE_ALLOW_OTHER)
> > > -		return 1;
> > > +	if (fc->flags & FUSE_ALLOW_OTHER) {
> > > +		struct user_namespace *ns;
> > > +		for (ns = current_user_ns(); ns; ns = ns->parent) {
> > > +			if (ns == fc->user_ns)
> > > +				return 1;
> > > +		}
> > 
> > 	use current_in_userns() ?
> 
> Yes, it should. I wrote this before I wrote the patch which adds that
> function and never thought to go back to change it here.

Ok - 

Acked-by: Serge Hallyn <serge.hallyn@canonical.com>

thanks.
