Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: James Antill <jantill@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <8764b8bu8s.fsf@rho.meyering.net>
References: <45A7D773.8040800@redhat.com>
	 <1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
	 <1168632626.13080.212.camel@code.and.org>
	 <1168633494.7993.546.camel@moss-spartans.epoch.ncsc.mil>
	 <1168636513.13080.227.camel@code.and.org> <873b6ffdi6.fsf@rho.meyering.net>
	 <1168838197.25232.9.camel@code.and.org>  <8764b8bu8s.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 08:33:14 -0500
Message-Id: <1168954394.22731.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-01-15 at 08:54 +0100, Jim Meyering wrote:
> James Antill <jantill@redhat.com> wrote:
> > On Sat, 2007-01-13 at 11:05 +0100, Jim Meyering wrote:
> >
> >> Isn't that fsetfilecon call useful, since your example must
> >> also handle an existing destination file?
> >
> >  Ahh, I see. I'd somehow missed the if check before the ifdef, or not
> > parsed what it meant.
> >
> >  Note that this does mean that:
> >
> > % echo me > uid
> > % sudo touch ouid_r ouid_w
> > % sudo chmod o+w ouid_w
> > % cp -a uid ouid_r
> > cp: cannot create regular file `ouid_r': Permission denied
> > zsh: 25994 exit 1     cp -a uid ouid_r
> > % cp -a uid ouid_w
> > zsh: 25995 exit 1     cp -a uid ouid_w
> 
> Thanks for the example.  I'll make that into a regression test.
> I need a lot more of those for the SELinux-related changes.
> 
> That demonstrates two problems in the Red Hat version of cp.
> Your first copy failed (as expected), because open-unreadable fails,
> The second failed (#1: but with no diagnostic!) due to failure
> to propagate the security context to the destination.  But imho, #2:
> cp -a must not try to apply any security context to the destination.
> 
> Over the weekend I nearly completed my own merge, and tried that.
> The latter "cp -a" still fails, but here because it fails to propagate
> the time stamps to a file not owned by me:
> 
>   $ cp -a uid ouid_r
>   cp: cannot create regular file `ouid_r': Permission denied
>   [Exit 1]
>   $ cp -a uid ouid_w
>   cp: preserving times for `ouid_w': Operation not permitted
>   [Exit 1]
> 
> With a little luck, I'll check it in and push today.
> 
> >> This is a good opportunity to ask about an old note I made:
> >>   - is it worthwhile to check for getfscreatecon failure?
> >>     The documentation says it can fail, but not how.
> >>     Even it's truly a "can't happen" condition now, that might change.
> >
> >  IIRC it:
> >
> >  open's /proc/self/task/$$/attr/fscreate
> >  reads the data
> >  malloc's the correct length for the result and copies.
> >
> > ...either of these three operations can fail.
> 
> Thanks.  I added code to detect the failures and to give diagnostics.
> 
> >  So any ideas on how to make cp do the right thing in all cases ?:)
> 
> Can you give more examples of how it doesn't work?

I'm not certain what the current state of cp is, but I think that we
want cp -a (or -p) to try to preserve security context but to gracefully
proceed (i.e. setfscreatecon(NULL) + retry if the open/mkdir/... failed
or ignore the failed fsetfilecon()) if that is not permitted, whereas we
want cp -c (or --preserve=context or --preserve=all) to treat such
errors as a fatal error.  That will enable contexts to be preserved when
permitted upon ordinary cp -a/-p copying, which is useful, while not
causing breakage when it is not permitted due to a mismatch between the
source and destination (e.g. cp -a /media/cdrom /etc) or due to
restrictions on the copying process (e.g. Secret process cannot
create/write to an Unclassified file but may read one and write it to a
Secret file; Unprivileged user process cannot create/write a system
file, but may read one and write a local copy).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
