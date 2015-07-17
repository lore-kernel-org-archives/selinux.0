Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6H0mQEv012719
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 20:48:31 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Chinner <david@fromorbit.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <55A6C448.5050902@schaufler-ca.com>
 <87vbdlf7vo.fsf@x220.int.ebiederm.org>
 <55A6E107.3070200@schaufler-ca.com>
 <CALCETrVCNQPVr-hg_pqd2J_LeWtRJs3LRsbbE+fifo4sat+FQQ@mail.gmail.com>
 <55A71CE3.4050708@schaufler-ca.com>
 <87fv4owvxv.fsf@x220.int.ebiederm.org> <20150717000914.GO7943@dastard>
Date: Thu, 16 Jul 2015 19:42:03 -0500
In-Reply-To: <20150717000914.GO7943@dastard> (Dave Chinner's message of "Fri,
 17 Jul 2015 10:09:14 +1000")
Message-ID: <87380nobs4.fsf@x220.int.ebiederm.org>
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

Dave Chinner <david@fromorbit.com> writes:

> On Wed, Jul 15, 2015 at 11:47:08PM -0500, Eric W. Biederman wrote:
>> Casey Schaufler <casey@schaufler-ca.com> writes:
>> > On 7/15/2015 6:08 PM, Andy Lutomirski wrote:
>> >> If I mount an unprivileged filesystem, then either the contents were
>> >> put there *by me*, in which case letting me access them are fine, or
>> >> (with Seth's patches and then some) I control the backing store, in
>> >> which case I can do whatever I want regardless of what LSM thinks.
>> >>
>> >> So I don't see the problem.  Why would Smack or any other LSM care at
>> >> all, unless it wants to prevent me from mounting the fs in the first
>> >> place?
>> >
>> > First off, I don't cotton to the notion that you should be able
>> > to mount filesystems without privilege. But it seems I'm being
>> > outvoted on that. I suspect that there are cases where it might
>> > be safe, but I can't think of one off the top of my head.
>> 
>> There are two fundamental issues mounting filesystems without privielge,
>> by which I actually mean mounting filesystems as the root user in a user
>> namespace.
>> 
>> - Are the semantics safe.
>> - Is the extra attack surface a problem.
>
> I think the attack surface this exposes is the biggest problem
> facing this proposal.

I completely agree.

>> Figuring out how to make semantics safe is what we are talking about.
>> 
>> Once we sort out the semantics we can look at the handful of filesystems
>> like fuse where the extra attack surface is not a concern.
>> 
>> With that said desktop environments have for a long time been
>> automatically mounting whichever filesystem you place in your computer,
>> so in practice what this is really about is trying to align the kernel
>> with how people use filesystems.
>
> The key difference is that desktops only do this when you physically
> plug in a device. With unprivileged mounts, a hostile attacker
> doesn't need physical access to the machine to exploit lurking
> kernel filesystem bugs. i.e. they can just use loopback mounts, and
> they can keep mounting corrupted images until they find something
> that works.

Yep.  That magnifies the problem quite a bit.

> User namespaces are supposed to provide trust separation.  The
> kernel filesystems simply aren't hardened against unprivileged
> attacks from below - there is a trust relationship between root and
> the filesystem in that they are the only things that can write to
> the disk. Mounts from within a userns destroys this relationship as
> the userns root, by definition, is not a trusted actor.

I talked to Ted Tso a while back and ext4 is at least in principle
already hardened against that kind of attack.  I am not certain I
believe it, but if it is true I think it is fantastic.

At this point any setting of the FS_USER_MOUNT flag I figure needs to go
through the filesystem maintainers tree and they need to be aware of and
agree to deal with the attack from below issue.

The one filesystem I truly expect we can make work is fuse.  fuse has
been designed to deal with some variation of the attack from below issue
since day one.  We looked at what the patches to fuse would look like
with the current state of the vfs and it was not pretty.

We very much need to sort through as much as possible at the vfs layer,
and in generic code.  Allow everyone to see what is going on and how
it works before preceeding forward with enabling any filesystems.



I truly hope we can find a small set of block device filesystems that we
can harden from attack below.   That would allow linux to have serious
defenses against evil usb stick attacks.  I think that is going to take
a lot of careful coding, testing and validation and advancing the state
of the art to get there.

Eric
