Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GN9FXA007624
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 19:09:15 -0400
Message-ID: <55A8398A.3000802@schaufler-ca.com>
Date: Thu, 16 Jul 2015 16:08:58 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <87615k7pyu.fsf@x220.int.ebiederm.org> <20150716135947.GC77715@ubuntu-hedt>
 <55A7C920.7090206@schaufler-ca.com> <20150716185750.GB51751@ubuntu-hedt>
 <55A8253E.3000407@schaufler-ca.com>
 <CALCETrW6NpwY0CXNXWBcqx6JPyAqr6XP-BKexO1HFdpxnQUJrQ@mail.gmail.com>
In-Reply-To: <CALCETrW6NpwY0CXNXWBcqx6JPyAqr6XP-BKexO1HFdpxnQUJrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/16/2015 3:27 PM, Andy Lutomirski wrote:
> On Thu, Jul 16, 2015 at 2:42 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> You want to provide a mechanism whereby an unprivileged user (Seth)
>> can mount a filesystem for his own use. You want full filesystem
>> semantics, but you're willing to accept restrictions on certain
>> filesystem features to avoid opening security holes. You are not
>> willing to accept restrictions that make the filesystem unusable,
>> such as making it read-only.
>>
>> I am going to present a suggestion. Feel free to correct my
>> assumptions and my reasoning. For simplicity let's use loop-back
>> mounting of a filesystem contained in a file as an example. The
>> principles should apply to newly created memory based filesystems
>> or disk partitions "owned" by Seth.
>>
>> Seth wants to mount a file (~seth/myfs) which contains an ext4
>> filesystem. There is already a filesystem object, with security
>> attributes, that the system knows how to deal with. If Seth mounts
>> this as a filesystem he, and potentially other people, will be
>> able to access the content of this object without accessing the
>> object itself.
>>
>>         seth$ mount --justforme -t ext4 ~seth/myfs /tmp/seth
>>         seth$ chmod 777 /tmp/seth
>>         seth$ ls -la /tmp/seth
>>         drwxrwxrwx.  3  seth     seth   260 Jul 16 12:59 .
>>         drwxrwxrwxt 18  root     root  4069 Jul 16 11:13 ..
>>         seth$
>>
>> Everything's fine at this point. Wilma is also using the system,
>> being the sort who likes to hide things in out of the way places
>>
>>         wilma$ cp ~/scandals /tmp/seth
>>         wilma$ chmod 600 /tmp/seth/scandals
> This is already impossible as described.  Seth can only mount the
> filesystem in a private mount namespace inside a user namespace that
> he created.  Wilma can't see it unless Seth passes an fd to Wilma and
> Wilma accepts and uses it.

But you do have multiple UIDs withing your user namespace, right?
There are processes running as someone other than seth, right?

>
>> puts her list of scandals on the unsuspecting filesystem, and changes
>> the mode to ensure that no one can find out what went on after the
>> office party.
>>
>> Seth unmounts /tmp/seth. He looks in ~seth/myfs, finds out what really
>> happened at the office party, and the story goes from there.
>>
>> Wilma did everything correctly according to the system security policy,
>> but the system security policy did not protect her as advertised. The
>> system was tricked into behaving as if it was in control of the content
>> of the filesystem when in fact it was not.
>
> I would argue that, if Wilma writes to some place described by an fd
> and doesn't verify where she's writing to, then she has no expectation
> of privacy.  After all, she could just *tell* Seth directly whatever
> she wants (assuming she can communicate with Seth in the first place).

Don't ascribe either wisdom or good intentions to Wilma.

>> One way to fix this problem is for unprivileged mounts to recognize the
>> attributes of the object mounted and to propagate those attributes to all
>> the objects they present. All files on /tmp/seth would be owned by seth
>> and protected by the mode bits, ACL and LSM requirements of ~/seth/myfs.
> This is impossible to enforce, because Seth could use FUSE instead of ext4.

I never said that things aren't already broken. And, if you want
to ignore the potential DAC issues (read, negative groups) just
do it for the LSM xattrs.


>
>> opening a file on /tmp/seth would require the same permissions as opening
>> the file containing the mounted filesystem. These attributes would have to
>> be immutable, or at least demonstrably more restrictive (chmod might be
>> allowed in some cases, but chown would never be) when changed. I don't see
>> how a user other than seth could create a new file, as you'd either have
>> a magical change in ownership or a false sense of security.
> This would be a very harsh restriction.  Seth might legitimately want
> to give a user access to a file on backing store he owns without
> giving that user access to the backing store.  Root on a normal system
> does that all the time.

You already said that it was impossible for Wilma to get
access, so how is this more restrictive? Besides, Seth can
always set the mode on ~/seth so that Wilma can't read the
files it contains. This isn't an old problem or a novel
solution.

>> If you can mount a filesystem such that the labels are ignored you
>> are effectively specifying that the Smack label on the files be
>> determined by the defaulting rules. With CAP_MAC_ADMIN that's fine.
>> Without it, it's not.
> Can you explain what the threat model is here?  I don't see what it is
> that you're trying to prevent.

Um, OK.
The filesystem has files with a hundred different Smack labels on it.
I mount it as an unlabeled filesystem and everything is readable by
everyone. Bad jojo.

>
>>> Your point is taken about my less-than-expert opinion about the other
>>> security modules. We should at minimum get acks from the maintainers of
>>> those modules that unprivileged mounts will not compromise MAC.
>> I am the Smack maintainer. Unprivileged mounts as you have
>> described them compromise MAC. They compromise DAC, too.
>>
> How do they compromise DAC?

Wilma's expectation (or the application running with a mapped UID)
that chmod will keep Seth out of the file.

> --Andy
>
