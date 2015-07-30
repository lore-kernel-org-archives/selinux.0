Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6UDtrpd010211
 for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2015 09:55:54 -0400
Received: by oixx19 with SMTP id x19so22057072oix.0
 for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2015 06:55:52 -0700 (PDT)
Date: Thu, 30 Jul 2015 08:55:31 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Amir Goldstein <amir@cellrox.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Message-ID: <20150730135531.GA109168@ubuntu-hedt>
References: <CAOQ4uxi4vzf2ok23_ymUoyCjXMHBGY=GpypnTKE-zo-ZNB2SCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOQ4uxi4vzf2ok23_ymUoyCjXMHBGY=GpypnTKE-zo-ZNB2SCw@mail.gmail.com>
Cc: Serge Hallyn <serge.hallyn@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 30, 2015 at 07:24:11AM +0300, Amir Goldstein wrote:
> On Tue, Jul 28, 2015 at 11:40 PM, Seth Forshee
> <seth.forshee@canonical.com> wrote:
> >
> > On Wed, Jul 22, 2015 at 05:05:17PM -0700, Casey Schaufler wrote:
> > > > This is what I currently think you want for user ns mounts:
> > > >
> > > >  1. smk_root and smk_default are assigned the label of the backing
> > > >     device.
> 
> Seth,
> 
> There were 2 main concerns discussed in this thread:
> 1. trusting LSM labels outside the namespace
> 2. trusting the content of the image file/loopdev
> 
> While your approach addresses the first concern, I suspect it may be placing
> an obstacle in a way for resolving the second concern.
> 
> A viable security policy to mitigate the second concern could be:
> - Allow only trusted programs (e.g. mkfs, fsck) to write to 'Loopback' images
> - Allow mount only of 'Loopback' images
> 
> This should allow the system as a whole to trust unprivileged mounts based on
> the trust of the entities that had raw access the the fs layout.

You don't really say what you mean by "trusted" programs. In a container
context I'd have to assume that you mean suid-root or similar programs
shared into the container by the host. In that case is any new kernel
functionality even required?

That also doesn't work for some of our use cases, where we'd like to be
able to do something like "mount -o loop foo.img /mnt/foo" in an
unprivileged container where foo.img is not created on the local machine
and not fully under control of the host environment.

Agreed though that the "attack from below" problem for untrusted
filesystems is still an open question. At minimum we have fuse, which
has been designed to protect against this threat. Others have mentioned
on this thread that Ted had said something at kernel summit last year
about being willing to support ext4 mounts from unprivileged user
namespaces as well. I've added Ted to the Cc in case he wants to confirm
or deny this rumor.

> Alas, if you choose to propagate the backing dev label to contained files,
> they would all share the designated 'Loopback' label and render the policy above
> useless.
> 
> Any thoughts on how to reconcile this conflict?

I'm not seeing what the conflict is here - nothing you proposed says
anything about security labels in the filesystem, and nothing would
prevent a "trusted" program with CAP_MAC_ADMIN from setting whatever
label was desired on the backing device. Care to elaborate?

Seth
