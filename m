From: ebiederm@xmission.com (Eric W. Biederman)
To: Colin Walters <walters@verbum.org>
References: <CAOQ4uxi4vzf2ok23_ymUoyCjXMHBGY=GpypnTKE-zo-ZNB2SCw@mail.gmail.com>
 <20150730135531.GA109168@ubuntu-hedt>
 <CAA2m6veXwLOHoD5C8h7D=S2t1TdjEP8QWWO_6tNv9CYHWtNkAQ@mail.gmail.com>
 <55BA43C7.40300@schaufler-ca.com>
 <1438271527.4081427.337383497.750BC231@webmail.messagingengine.com>
Date: Thu, 30 Jul 2015 11:15:48 -0500
In-Reply-To: <1438271527.4081427.337383497.750BC231@webmail.messagingengine.com>
 (Colin Walters's message of "Thu, 30 Jul 2015 11:52:07 -0400")
Message-ID: <87twslliyz.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Cc: Theodore Ts'o <tytso@mit.edu>, Serge Hallyn <serge.hallyn@canonical.com>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Colin Walters <walters@verbum.org> writes:

> It's worth noting here that I think a lot of the use cases
> for unprivileged mounts are testing/development type things,
> and these are pretty well covered by:
>
> http://libguestfs.org/
>
> Basically it just runs the host kernel in a VM, and the userspace
> is a minimal agent that you can talk to over virtio.  You can use
> the API, or `guestmount` exposes it via FUSE.
>
> It doesn't magically make the kernel filesystems robust against
> untrusted input, but in the case of compromise, it's an
> "unprivileged" VM.  I've used it for several projects and been
> quite happy.

Thanks for pointing this out.  That makes it clear we only have to get
as far as making fuse work for this work to be useful in practice.

Eric
