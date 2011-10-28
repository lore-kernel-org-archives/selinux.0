Message-ID: <1319765776.2767.15.camel@localhost>
Subject: Re: [PATCH] SELinux: audit failed attempts to set invalid labels
From: Eric Paris <eparis@redhat.com>
To: Kyle Moffett <kyle@moffetthome.net>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, dwalsh@redhat.com
Date: Thu, 27 Oct 2011 21:36:16 -0400
In-Reply-To: <CAGZ=bqJtuLzaycj9QJQJGxTMA2aRiOrEjGf+Wn39dv5gPQJFwg@mail.gmail.com>
References: <20111027210531.14866.89071.stgit@paris.rdu.redhat.com>
	 <CAGZ=bqJtuLzaycj9QJQJGxTMA2aRiOrEjGf+Wn39dv5gPQJFwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-10-27 at 21:10 -0400, Kyle Moffett wrote:
> Hi Eric!
> 
> On Thu, Oct 27, 2011 at 17:05, Eric Paris <eparis@redhat.com> wrote:
> > We know that some yum operation is causing CAP_MAC_ADMIN failures.  This
> > implies that an RPM is laying down (or attempting to lay down) a file with
> > an invalid label.  The problem is that we don't have any information to
> > track down the cause.  This patch with cause such a failure to report the
> > failed label in an SELINUX_ERR audit message.  This is similar to the
> > SELINUX_ERR reports on invalid transitions and things like that.  It should
> > help run down problems on what is trying to set invalid labels in the
> > future.
> 
> So, the existing code seems to do the right thing:
> >        rc = security_context_to_sid(value, size, &newsid);
> 
> But this new code looks very wrong:
> > +                       audit_log_n_untrustedstring(ab, value, strnlen(value, size));
> 
> If somebody stuck a "\0" character in there that would not do what you want.

It does what I want, but maybe you are right that it is still wrong.  On
a normal setxattr call 'size' is the size of the string including the
nul.  I know this from testing.  My first attempt at using the audit
function included the nul in the ouput since I used exactly the line you
have below (as you noticed the audit function does not expect to include
the nul).  Which meant that the audit output was encoded rather than a
readable string since the nul was not a valid audit character.

> I would expect this is the correct way:
>   audit_log_n_untrustedstring(ab, value, size)
> 
> I looked at audit_log_n_untrustedstring and
> security_context_to_sid_core, and both seem to assume that "size" does
> not include a trailing NUL.

Actually it presumes that it MIGHT not include the nul.  If the nul is
there it will however politely add a second nul....

> Reading through "security_context_to_sid_core()", it appears to have a
> bug when !ss_initialized:
>   if (!strcmp(initial_sid_to_string[i], scontext))
> 
> Where's the references to scontext_len???
>
> It looks like it will allow (during early boot) a process to set an
> invalid xattr on a file yet cache a valid SID for the same file, EG:
> "system_u:object_r:kernel_t:s0\0HelloWorld", hm?

That is a bit interesting, and is points out the problem that my
function might have.  Maybe I should instead use

size = (value[size-1] == '\0' ? size-1 : size);
audit_log_n_untrustedstring(ab, value, size);

So I only avoid the nul if it is at the end of the buffer....

I guess really the question comes down to what that label means.  Is
"system_u:object_r:kernel_t:s0\0HelloWorld" supposed to be equal to
"system_u:object_r:kernel_t:s0"?  If the labels are strings those are
equal....

> Furthermore, the rest of that code is very non-obviously correct
> regarding checking against the length instead of a NUL character.

I'm still questioning (I only looked 2 seconds) how and if
string_to_context_struct() works properly if there wasn't already a nul
in the size....   But I agree the rest of it looks non-obviously
safe  :)

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
