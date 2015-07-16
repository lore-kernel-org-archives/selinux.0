Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6G4ndaG029120
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 00:49:39 -0400
Received: by lblf12 with SMTP id f12so36742521lbl.2
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 21:49:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87io9kzq5g.fsf@x220.int.ebiederm.org>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-4-git-send-email-seth.forshee@canonical.com>
 <20150715214848.GA24204@mail.hallyn.com>
 <CALCETrVTGC8NJdpOhkqDaE8HdD95y-K2-VnsL+Oo4NjVUyovsA@mail.gmail.com>
 <87wpy1camr.fsf@x220.int.ebiederm.org>
 <CALCETrULyv9pfwAeyNrvJ06o+bW6JbWgBOsi4b4OUhbPjD4FnQ@mail.gmail.com>
 <87io9kzq5g.fsf@x220.int.ebiederm.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 15 Jul 2015 21:49:16 -0700
Message-ID: <CALCETrWrFQJev_yn00BgMYbRhGGGa6nDBqmodbZxBrDO9xVSNw@mail.gmail.com>
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

On Wed, Jul 15, 2015 at 9:23 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Ok.  Andy I have stopped and really looked at your patch that is 4/7 in
> this series.  Something I had not done before since it sounded totally
> wrong.
>
> That combined with your earlier comments I think I can say something
> meaningful.
>
> Andy as I read your patch the thread you are primarily worried about is
> chdir(/some/directory/in/another/mnt/ns).  I think enhancing nosuid to
> deal with that case is reasonable, and is unlikely to break userspace.
> It is one of those hairy security things so we need to be careful not to
> introduce a regression.
>

Indeed.  It's plausible this could regress something, but it would be
really weird.

> I think a top down enhancement of nosuid to just block funny cases that
> no one cares about is completely sensible.    Removing goofy corner
> that no one cares about and that are only good for security exploits
> seems reasonable.
>

Agreed.

> I am a little concerned that smack does not seem to respect nosuid
> on filesystems.  But that is an issue with nosuid not with your enhanced
> nosuid.
>
>
>
>
> Now this patch 3/7 really should be entitled:
> "Limit file caps to the userns of the super block".
>
> It really really is doing something different.   This change is about a
> bottom up understanding of what file caps means on a filesystem mounted
> by a user namespace root.
>
> That is file caps should only apply to the user namespace root of the
> root user who mounted the filesystem, because that is all the privileges
> the mounter of the filesystem had.
>
> This guarantees that even if the filesystem somehow propagates with
> mount propagation that there will be no issues.  I think I know how to
> make that happen...
>
>
>
>
> But deeply and fundamentally limiting a filesystem to only the
> privilieges of it's user namespace root, and enhancing nosuid
> protections are rather different things.
>

So here's the semantic question:

Suppose an unprivileged user (uid 1000) creates a user namespace and a
mount namespace.  They stick a file (owned by uid 1000 as seen by
init_user_ns) in there and mark it setuid root and give it fcaps.

Then global root gets an fd to this filesystem.  If they execve the
file directly, then, with my patch 4, it won't act as setuid 1000 and
the fcaps will be ignored.  Even with my patch 4, though, if they bind
mount the fs and execve the file from their bind mount, it will act as
setuid 1000.  Maybe this is odd.  However, with Seth's patch 3, the
fcaps will (correctly) not be honored.

I tend to thing that, if we're not honoring the fcaps, we shouldn't be
honoring the setuid bit either.  After all, it's really not a trusted
file, even though the only user who could have messed with it really
is the apparent owner.

And, if we're going to say we don't trust the file and shouldn't honor
setuid or fcaps, then merging all the functionality into mnt_may_suid
could make sense.  Yes, these two things do different things, but they
could hook in to the same place.

--Andy
