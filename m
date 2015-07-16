Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6G5G9Hv030738
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 01:16:09 -0400
Received: by lbbzr7 with SMTP id zr7so37036440lbb.1
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 22:15:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87wpy0u1zo.fsf@x220.int.ebiederm.org>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-4-git-send-email-seth.forshee@canonical.com>
 <20150715214848.GA24204@mail.hallyn.com>
 <CALCETrVTGC8NJdpOhkqDaE8HdD95y-K2-VnsL+Oo4NjVUyovsA@mail.gmail.com>
 <87wpy1camr.fsf@x220.int.ebiederm.org>
 <CALCETrULyv9pfwAeyNrvJ06o+bW6JbWgBOsi4b4OUhbPjD4FnQ@mail.gmail.com>
 <87io9kzq5g.fsf@x220.int.ebiederm.org>
 <CALCETrWrFQJev_yn00BgMYbRhGGGa6nDBqmodbZxBrDO9xVSNw@mail.gmail.com>
 <87wpy0u1zo.fsf@x220.int.ebiederm.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 15 Jul 2015 22:15:30 -0700
Message-ID: <CALCETrUiwuMaYCKPNam3VzmNr4=tFUs-fO3Kusag3UGWVwu8JQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] fs: Ignore file caps in mounts from other user
 namespaces
To: "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset=UTF-8
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 15, 2015 at 10:04 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Andy Lutomirski <luto@amacapital.net> writes:
>
>> On Wed, Jul 15, 2015 at 9:23 PM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>>
>>> Ok.  Andy I have stopped and really looked at your patch that is 4/7 in
>>> this series.  Something I had not done before since it sounded totally
>>> wrong.
>>>
>>> That combined with your earlier comments I think I can say something
>>> meaningful.
>>>
>>> Andy as I read your patch the thread you are primarily worried about is
>>> chdir(/some/directory/in/another/mnt/ns).  I think enhancing nosuid to
>>> deal with that case is reasonable, and is unlikely to break userspace.
>>> It is one of those hairy security things so we need to be careful not to
>>> introduce a regression.
>>>
>>
>> Indeed.  It's plausible this could regress something, but it would be
>> really weird.
>>
>>> I think a top down enhancement of nosuid to just block funny cases that
>>> no one cares about is completely sensible.    Removing goofy corner
>>> that no one cares about and that are only good for security exploits
>>> seems reasonable.
>>>
>>
>> Agreed.
>>
>>> I am a little concerned that smack does not seem to respect nosuid
>>> on filesystems.  But that is an issue with nosuid not with your enhanced
>>> nosuid.
>>>
>>>
>>>
>>>
>>> Now this patch 3/7 really should be entitled:
>>> "Limit file caps to the userns of the super block".
>>>
>>> It really really is doing something different.   This change is about a
>>> bottom up understanding of what file caps means on a filesystem mounted
>>> by a user namespace root.
>>>
>>> That is file caps should only apply to the user namespace root of the
>>> root user who mounted the filesystem, because that is all the privileges
>>> the mounter of the filesystem had.
>>>
>>> This guarantees that even if the filesystem somehow propagates with
>>> mount propagation that there will be no issues.  I think I know how to
>>> make that happen...
>>>
>>>
>>>
>>>
>>> But deeply and fundamentally limiting a filesystem to only the
>>> privilieges of it's user namespace root, and enhancing nosuid
>>> protections are rather different things.
>>>
>>
>> So here's the semantic question:
>>
>> Suppose an unprivileged user (uid 1000) creates a user namespace and a
>> mount namespace.  They stick a file (owned by uid 1000 as seen by
>> init_user_ns) in there and mark it setuid root and give it fcaps.
>
> To make this make sense I have to ask, is this file on a filesystem
> where uid 1000 as seen by the init_user_ns stored as uid 1000 on
> the filesystem?  Or is this uid 0 as seen by the filesystem?
>
> I assume this is uid 0 on the filesystem in question or else your
> unprivileged user would not have sufficient privileges over the
> filesystem to setup fcaps.

I was thinking uid 0 as seen by the filesystem.  But even if it were
uid 1000, the unprivileged user can still set whatever mode and xattrs
they want -- they control the backing store.

>
>> Then global root gets an fd to this filesystem.  If they execve the
>> file directly, then, with my patch 4, it won't act as setuid 1000 and
>> the fcaps will be ignored.  Even with my patch 4, though, if they bind
>> mount the fs and execve the file from their bind mount, it will act as
>> setuid 1000.  Maybe this is odd.  However, with Seth's patch 3, the
>> fcaps will (correctly) not be honored.
>
> With patch 3 you can also think of it as fcaps being honored and you
> get all the caps in the appropriate user namespace, but since you are
> not in that user namespace and so don't have a place to store them
> in struct cred you don't get the file caps.
>
> From the philosophy of interpreting the file as defined by the
> filesystem in principle we could extend struct cred so you actually
> get the creds just in uid 1000s user namespace, but that is very
> unlikely to be worth it.

I agree.

>
>> I tend to thing that, if we're not honoring the fcaps, we shouldn't be
>> honoring the setuid bit either.  After all, it's really not a trusted
>> file, even though the only user who could have messed with it really
>> is the apparent owner.
>
> For the file caps we can't honor them because you don't have the bits
> in struct cred.
>
> For setuid we can honor it, and setuid is something that the user
> namespace allows.
>

We certainly *can* honor it.  But why should we?  I'd be more
comfortable with this if the contents of an untrusted filesystem were
really treated as just data.

>> And, if we're going to say we don't trust the file and shouldn't honor
>> setuid or fcaps, then merging all the functionality into mnt_may_suid
>> could make sense.  Yes, these two things do different things, but they
>> could hook in to the same place.
>
> There are really two separate questions:
> - Do we trust this filesystem?
> - Do you have the bits to implement this concept?
>
> Even if in this specific context the two questions wind up looking
> exactly the same. I think it makes a lot of sense to ask the two
> questions separately.  As future maintenance changes may cause the
> implementation of the questions to diverge.
>

Agreed.

Unless someone thinks of an argument to the contrary, I'd say "no, we
don't trust this filesystem".  I could be convinced otherwise.

--Andy
