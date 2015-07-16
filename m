Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GDEED6029514
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 09:14:14 -0400
Received: by obre1 with SMTP id e1so46541403obr.1
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 06:14:11 -0700 (PDT)
Date: Thu, 16 Jul 2015 08:13:08 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 3/7] fs: Ignore file caps in mounts from other user
 namespaces
Message-ID: <20150716131308.GB77715@ubuntu-hedt>
References: <1436989569-69582-4-git-send-email-seth.forshee@canonical.com>
 <20150715214848.GA24204@mail.hallyn.com>
 <CALCETrVTGC8NJdpOhkqDaE8HdD95y-K2-VnsL+Oo4NjVUyovsA@mail.gmail.com>
 <87wpy1camr.fsf@x220.int.ebiederm.org>
 <CALCETrULyv9pfwAeyNrvJ06o+bW6JbWgBOsi4b4OUhbPjD4FnQ@mail.gmail.com>
 <87io9kzq5g.fsf@x220.int.ebiederm.org>
 <CALCETrWrFQJev_yn00BgMYbRhGGGa6nDBqmodbZxBrDO9xVSNw@mail.gmail.com>
 <87wpy0u1zo.fsf@x220.int.ebiederm.org>
 <CALCETrUiwuMaYCKPNam3VzmNr4=tFUs-fO3Kusag3UGWVwu8JQ@mail.gmail.com>
 <87vbdkslke.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vbdkslke.fsf@x220.int.ebiederm.org>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 LSM List <linux-security-module@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 16, 2015 at 12:44:49AM -0500, Eric W. Biederman wrote:
> Andy Lutomirski <luto@amacapital.net> writes:
> 
> > On Wed, Jul 15, 2015 at 10:04 PM, Eric W. Biederman
> > <ebiederm@xmission.com> wrote:
> >> Andy Lutomirski <luto@amacapital.net> writes:
> >>
> >>>
> >>> So here's the semantic question:
> >>>
> >>> Suppose an unprivileged user (uid 1000) creates a user namespace and a
> >>> mount namespace.  They stick a file (owned by uid 1000 as seen by
> >>> init_user_ns) in there and mark it setuid root and give it fcaps.
> >>
> >> To make this make sense I have to ask, is this file on a filesystem
> >> where uid 1000 as seen by the init_user_ns stored as uid 1000 on
> >> the filesystem?  Or is this uid 0 as seen by the filesystem?
> >>
> >> I assume this is uid 0 on the filesystem in question or else your
> >> unprivileged user would not have sufficient privileges over the
> >> filesystem to setup fcaps.
> >
> > I was thinking uid 0 as seen by the filesystem.  But even if it were
> > uid 1000, the unprivileged user can still set whatever mode and xattrs
> > they want -- they control the backing store.
> 
> Yes.   And that is what I was really asking.  Are we taking about a
> filesystem where the user controls the backing store?
> 
> >>> Then global root gets an fd to this filesystem.  If they execve the
> >>> file directly, then, with my patch 4, it won't act as setuid 1000 and
> >>> the fcaps will be ignored.  Even with my patch 4, though, if they bind
> >>> mount the fs and execve the file from their bind mount, it will act as
> >>> setuid 1000.  Maybe this is odd.  However, with Seth's patch 3, the
> >>> fcaps will (correctly) not be honored.
> >>
> >> With patch 3 you can also think of it as fcaps being honored and you
> >> get all the caps in the appropriate user namespace, but since you are
> >> not in that user namespace and so don't have a place to store them
> >> in struct cred you don't get the file caps.
> >>
> >> From the philosophy of interpreting the file as defined by the
> >> filesystem in principle we could extend struct cred so you actually
> >> get the creds just in uid 1000s user namespace, but that is very
> >> unlikely to be worth it.
> >
> > I agree.
> >
> >>
> >>> I tend to thing that, if we're not honoring the fcaps, we shouldn't be
> >>> honoring the setuid bit either.  After all, it's really not a trusted
> >>> file, even though the only user who could have messed with it really
> >>> is the apparent owner.
> >>
> >> For the file caps we can't honor them because you don't have the bits
> >> in struct cred.
> >>
> >> For setuid we can honor it, and setuid is something that the user
> >> namespace allows.
> >>
> >
> > We certainly *can* honor it.  But why should we?  I'd be more
> > comfortable with this if the contents of an untrusted filesystem were
> > really treated as just data.
> 
> In these weird bleed through situtations I don't know that we should.
> But extending nosuid protections in this way is a bit like yama
> a bit gratuitious stomping don't care cases in the semantics to
> make bugs harder to exploit.
> 
> >>> And, if we're going to say we don't trust the file and shouldn't honor
> >>> setuid or fcaps, then merging all the functionality into mnt_may_suid
> >>> could make sense.  Yes, these two things do different things, but they
> >>> could hook in to the same place.
> >>
> >> There are really two separate questions:
> >> - Do we trust this filesystem?
> >> - Do you have the bits to implement this concept?
> >>
> >> Even if in this specific context the two questions wind up looking
> >> exactly the same. I think it makes a lot of sense to ask the two
> >> questions separately.  As future maintenance changes may cause the
> >> implementation of the questions to diverge.
> >>
> >
> > Agreed.
> >
> > Unless someone thinks of an argument to the contrary, I'd say "no, we
> > don't trust this filesystem".  I could be convinced otherwise.
> 
> But this is context dependent.  From the perspective of the container
> we really do want to trust the filesystem.  As the container root set it
> up, and if he isn't being hostile likely has a use for setfcaps files
> and setuid files and all of the rest.
> 
> Perhaps I should phrase it as:
> - In this context do we trust the code?   AKA mnt_may_suid?
> - What do these bits mean in this context?  (Usually something more complicated).
> 
> Which says to me we want both patches 3 and 4 (even if 4 uses s_user_ns)
> because 3 is different than 4.

So what I'll do is:

 - Add a s_user_ns check to mnt_may_suid
 - Keep the (now redundant) s_user_ns check in get_file_caps

I'm on the fence about having both the mnt and user ns checks in
mnt_may_suid - it might be overkill, but it still adds the protection
against clearing MNT_NOSUID in a bind mount. So I guess I'll keep the
mnt ns check.

Seth
