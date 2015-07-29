Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6TG4sYQ028354
 for <selinux@tycho.nsa.gov>; Wed, 29 Jul 2015 12:04:55 -0400
Date: Wed, 29 Jul 2015 11:04:50 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 3/7] fs: Ignore file caps in mounts from other user
 namespaces
Message-ID: <20150729160450.GA21625@mail.hallyn.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-4-git-send-email-seth.forshee@canonical.com>
 <20150715214848.GA24204@mail.hallyn.com>
 <CALCETrVTGC8NJdpOhkqDaE8HdD95y-K2-VnsL+Oo4NjVUyovsA@mail.gmail.com>
 <87wpy1camr.fsf@x220.int.ebiederm.org>
 <CALCETrULyv9pfwAeyNrvJ06o+bW6JbWgBOsi4b4OUhbPjD4FnQ@mail.gmail.com>
 <87io9kzq5g.fsf@x220.int.ebiederm.org>
 <CALCETrWrFQJev_yn00BgMYbRhGGGa6nDBqmodbZxBrDO9xVSNw@mail.gmail.com>
 <87wpy0u1zo.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wpy0u1zo.fsf@x220.int.ebiederm.org>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 16, 2015 at 12:04:43AM -0500, Eric W. Biederman wrote:
> > I tend to thing that, if we're not honoring the fcaps, we shouldn't be
> > honoring the setuid bit either.  After all, it's really not a trusted
> > file, even though the only user who could have messed with it really
> > is the apparent owner.
> 
> For the file caps we can't honor them because you don't have the bits
> in struct cred.
> 
> For setuid we can honor it, and setuid is something that the user
> namespace allows.

Setuid is something explicitly tied to the user id.  File capabilities
are MAC, that is, explicitly orthogonal to user id.  So 100% agreed with
honoring setuid in user_ns and, for now, ignoring file caps.

As I've mentioned a few times privately, I'm intending to implement
user-namespaced file capabilities as a new xattr.  Design is not 100%
nailed down, but probably it would support a set of userns_fcaps, each
of which lists the k_uid of the root user in the namespace assigning the
filecaps, followed by three sets.  Then when exec()ing the file, if
the current->userns->root user has a userns_fcap entry, or there is a -1
entry, then use that, else use nothing.  I think this is a very importing
thing to support, to remove a barrier to shipping packages with software
using filecaps.  Without this, any package, say ping, which wants to
support being installed in a (unprivileged) cotainer would need to also
support use without filecaps, meaning that will likely be the only
supported mode.

-serge
