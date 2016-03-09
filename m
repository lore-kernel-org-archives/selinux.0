Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u29H7cF5014192
 for <selinux@tycho.nsa.gov>; Wed, 9 Mar 2016 12:07:38 -0500
Received: by mail-oi0-f52.google.com with SMTP id r187so40375088oih.3
 for <selinux@tycho.nsa.gov>; Wed, 09 Mar 2016 09:07:35 -0800 (PST)
Date: Wed, 9 Mar 2016 11:07:26 -0600
From: Seth Forshee <seth.forshee@canonical.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-bcache@vger.kernel.org, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 fuse-devel <fuse-devel@lists.sourceforge.net>,
 LSM <linux-security-module@vger.kernel.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH RESEND v2 16/18] fuse: Support fuse filesystems outside
 of init_user_ns
Message-ID: <20160309170726.GB28779@ubuntu-hedt>
References: <1451930639-94331-1-git-send-email-seth.forshee@canonical.com>
 <1451930639-94331-17-git-send-email-seth.forshee@canonical.com>
 <20160309112923.GF8655@tucsk> <20160309141840.GC23399@ubuntu-xps13>
 <CAJfpegv5JmB15yHpjYxVeOYdWWkoLMftr9-e_iS93Y_7m=t4Zw@mail.gmail.com>
 <20160309152505.GA28779@ubuntu-hedt>
 <CAJfpegv5KR_Hi-79a8oyb+R+tv9W3RYqy5pngUKSyauVNk2ScQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJfpegv5KR_Hi-79a8oyb+R+tv9W3RYqy5pngUKSyauVNk2ScQ@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Mar 09, 2016 at 04:51:42PM +0100, Miklos Szeredi wrote:
> On Wed, Mar 9, 2016 at 4:25 PM, Seth Forshee <seth.forshee@canonical.com> wrote:
> > On Wed, Mar 09, 2016 at 03:48:22PM +0100, Miklos Szeredi wrote:
> 
> >> Can't we use current_cred()->uid/gid? Or fsuid/fsgid maybe?
> >
> > That would be a departure from the current behavior in the !allow_other
> > case for unprivileged users. Since those mounts are done by an suid
> > helper all of those ids would be root in the userns, wouldn't they?
> 
> Well, actually this is what the helper does:
> 
>     sprintf(d, "fd=%i,rootmode=%o,user_id=%u,group_id=%u",
>         fd, rootmode, getuid(), getgid());

Sorry, I was thinking of euid. So this may not be a problem.

> So it just uses the current uid/gid.  Apparently no reason to do this
> in userland, we could just as well set these in the kernel.  Except
> for possible backward compatibility problems for things not using the
> helper.
> 
> BUT if the mount is unprivileged or it's a userns mount, or anything
> previously not possible, then we are not constrained by the backward
> compatibility issues, and can go with the saner solution.
> 
> Does that not make sense?

But we generally do want backwards compatibility, and we want userspace
software to be able to expect the same behavior whether or not it's
running in a user namespaced container. Obviously we can't always have
things 100% identical, but we shouldn't break things unless we really
need to.

However it may be that this isn't actually going to break assumptions of
existing software like I had feared. My preference is still to not
change any userspace-visible behaviors since we never know what software
might have made assumptions based on those behaviors. But if you're
confident that it won't break anything I'm willing to give it a try.

> >> When we have true unprivileged mounts, the user_id/group_id options
> >> become redundant anyway and we can just use the current credentials.
> >
> > True, but we don't yet have that.
> 
> What's missing?

A user must still be privileged to mount, even if only towards their own
user and mount namespaces. Maybe that's what you meant though and I just
misunderstood.

Thanks,
Seth
