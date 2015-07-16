Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6G4UUcD028381
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 00:30:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andy Lutomirski <luto@amacapital.net>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-4-git-send-email-seth.forshee@canonical.com>
 <20150715214848.GA24204@mail.hallyn.com>
 <CALCETrVTGC8NJdpOhkqDaE8HdD95y-K2-VnsL+Oo4NjVUyovsA@mail.gmail.com>
 <87wpy1camr.fsf@x220.int.ebiederm.org>
 <CALCETrULyv9pfwAeyNrvJ06o+bW6JbWgBOsi4b4OUhbPjD4FnQ@mail.gmail.com>
Date: Wed, 15 Jul 2015 23:23:55 -0500
In-Reply-To: <CALCETrULyv9pfwAeyNrvJ06o+bW6JbWgBOsi4b4OUhbPjD4FnQ@mail.gmail.com>
 (Andy Lutomirski's message of "Wed, 15 Jul 2015 18:19:46 -0700")
Message-ID: <87io9kzq5g.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 3/7] fs: Ignore file caps in mounts from other user
 namespaces
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


Ok.  Andy I have stopped and really looked at your patch that is 4/7 in
this series.  Something I had not done before since it sounded totally
wrong.

That combined with your earlier comments I think I can say something
meaningful.  

Andy as I read your patch the thread you are primarily worried about is
chdir(/some/directory/in/another/mnt/ns).  I think enhancing nosuid to
deal with that case is reasonable, and is unlikely to break userspace.
It is one of those hairy security things so we need to be careful not to
introduce a regression.

I think a top down enhancement of nosuid to just block funny cases that
no one cares about is completely sensible.    Removing goofy corner
that no one cares about and that are only good for security exploits
seems reasonable.

I am a little concerned that smack does not seem to respect nosuid
on filesystems.  But that is an issue with nosuid not with your enhanced
nosuid.




Now this patch 3/7 really should be entitled:
"Limit file caps to the userns of the super block".

It really really is doing something different.   This change is about a
bottom up understanding of what file caps means on a filesystem mounted
by a user namespace root. 

That is file caps should only apply to the user namespace root of the
root user who mounted the filesystem, because that is all the privileges
the mounter of the filesystem had.

This guarantees that even if the filesystem somehow propagates with
mount propagation that there will be no issues.  I think I know how to
make that happen...




But deeply and fundamentally limiting a filesystem to only the
privilieges of it's user namespace root, and enhancing nosuid
protections are rather different things.


The approaches show up differently for dealing with uids and gids,
as mappings are required.  The approaches will likely to continue to
show up differently for file caps when Serge implements a version
of file caps with a user namespace root in them.

The approaches fundamentally will need to do different things with
security xattrs.  As mnt_may_suid can just treat as a filesystem
without labels, while ultimately the lsms will have to do something
meaningful.



So while in the very narrow case of todays file caps the two approaches
are the same.   Enhancing nosuid is something very different from
limiting a filesystem to it's mounters user namespace.

Eric
