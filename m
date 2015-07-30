Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6UFqAAI018869
 for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2015 11:52:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 5BCD320BCD
 for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2015 11:52:08 -0400 (EDT)
Message-Id: <1438271527.4081427.337383497.750BC231@webmail.messagingengine.com>
From: Colin Walters <walters@verbum.org>
To: Casey Schaufler <casey@schaufler-ca.com>,
 Amir Goldstein <amir@cellrox.com>,
 Seth Forshee <seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <55BA43C7.40300@schaufler-ca.com>
References: <CAOQ4uxi4vzf2ok23_ymUoyCjXMHBGY=GpypnTKE-zo-ZNB2SCw@mail.gmail.com>
 <20150730135531.GA109168@ubuntu-hedt>
 <CAA2m6veXwLOHoD5C8h7D=S2t1TdjEP8QWWO_6tNv9CYHWtNkAQ@mail.gmail.com>
 <55BA43C7.40300@schaufler-ca.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Date: Thu, 30 Jul 2015 11:52:07 -0400
Cc: Serge Hallyn <serge.hallyn@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

It's worth noting here that I think a lot of the use cases
for unprivileged mounts are testing/development type things,
and these are pretty well covered by:

http://libguestfs.org/

Basically it just runs the host kernel in a VM, and the userspace
is a minimal agent that you can talk to over virtio.  You can use
the API, or `guestmount` exposes it via FUSE.

It doesn't magically make the kernel filesystems robust against
untrusted input, but in the case of compromise, it's an
"unprivileged" VM.  I've used it for several projects and been
quite happy.
