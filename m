Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6G4rbvX029445
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 00:53:37 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Casey Schaufler <casey@schaufler-ca.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <55A6C448.5050902@schaufler-ca.com>
 <87vbdlf7vo.fsf@x220.int.ebiederm.org>
 <55A6E107.3070200@schaufler-ca.com>
 <CALCETrVCNQPVr-hg_pqd2J_LeWtRJs3LRsbbE+fifo4sat+FQQ@mail.gmail.com>
 <55A71CE3.4050708@schaufler-ca.com>
Date: Wed, 15 Jul 2015 23:47:08 -0500
In-Reply-To: <55A71CE3.4050708@schaufler-ca.com> (Casey Schaufler's message of
 "Wed, 15 Jul 2015 19:54:27 -0700")
Message-ID: <87fv4owvxv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 7/15/2015 6:08 PM, Andy Lutomirski wrote:
>> On Wed, Jul 15, 2015 at 3:39 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 7/15/2015 2:06 PM, Eric W. Biederman wrote:
>>>> Casey Schaufler <casey@schaufler-ca.com> writes:
>>>> The first step needs to be not trusting those labels and treating such
>>>> filesystems as filesystems without label support.  I hope that is Seth
>>>> has implemented.
>>> A filesystem with Smack labels gets mounted in a namespace. The labels
>>> are ignored. Instead, the filesystem defaults (potentially specified as
>>> mount options smackfsdef="something", but usually the floor label ("_"))
>>> are used, giving the user the ability to read everything and (usually)
>>> change nothing. This is both dangerous (unintended read access to files)
>>> and pointless (can't make changes).
>> I don't get it.
>>
>> If I mount an unprivileged filesystem, then either the contents were
>> put there *by me*, in which case letting me access them are fine, or
>> (with Seth's patches and then some) I control the backing store, in
>> which case I can do whatever I want regardless of what LSM thinks.
>>
>> So I don't see the problem.  Why would Smack or any other LSM care at
>> all, unless it wants to prevent me from mounting the fs in the first
>> place?
>
> First off, I don't cotton to the notion that you should be able
> to mount filesystems without privilege. But it seems I'm being
> outvoted on that. I suspect that there are cases where it might
> be safe, but I can't think of one off the top of my head.

There are two fundamental issues mounting filesystems without privielge,
by which I actually mean mounting filesystems as the root user in a user
namespace.

- Are the semantics safe.
- Is the extra attack surface a problem.

Figuring out how to make semantics safe is what we are talking about.

Once we sort out the semantics we can look at the handful of filesystems
like fuse where the extra attack surface is not a concern.

With that said desktop environments have for a long time been
automatically mounting whichever filesystem you place in your computer,
so in practice what this is really about is trying to align the kernel
with how people use filesystems.

I haven't looked closely but I think docker is just about as bad as
those desktop environments when it comes to mounting filesystems.

> If you do mount a filesystem it needs to behave according to the
> rules of the system.

I agree.

> If you have a security module that uses
> attributes on the filesystem you can't ignore them just because
> it's "your data". Mandatory access control schemes, including
> Smack and SELinux don't give a fig about who you are. It's the
> label on the data and the process that matter. If "you" get to
> muck the labels up, you've broken the mandatory access control.

So there are filesystems like fat and minix that can not store a label.
Since it is not possible to store labels securely in filesystems mounted
by unprivileged users (at least in the normal sense) the intent would be
to treat a filesystem mounted without the privileges of the global root
user as a filesystem that does not support xattrs.

Treating such a filesystem as a filesystem that does not support xattrs
is the only possible way support such a filesystem securely, because as
you have said someone who can muck up the labels breaks mandatory access
control.

Given how non-trivial it is to grasp the nuances of different lsms
mandatory access control semantics, I am asking Seth for the first past
to simply forbid mounting of filesystems with just user namespace
permissions when there is an lsm active.

Once we get that far smack may never need to support such systems.

Eric
