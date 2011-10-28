MIME-Version: 1.0
In-Reply-To: <20111027210531.14866.89071.stgit@paris.rdu.redhat.com>
References: <20111027210531.14866.89071.stgit@paris.rdu.redhat.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Thu, 27 Oct 2011 21:10:51 -0400
Message-ID: <CAGZ=bqJtuLzaycj9QJQJGxTMA2aRiOrEjGf+Wn39dv5gPQJFwg@mail.gmail.com>
Subject: Re: [PATCH] SELinux: audit failed attempts to set invalid labels
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, dwalsh@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Eric!

On Thu, Oct 27, 2011 at 17:05, Eric Paris <eparis@redhat.com> wrote:
> We know that some yum operation is causing CAP_MAC_ADMIN failures.  This
> implies that an RPM is laying down (or attempting to lay down) a file with
> an invalid label.  The problem is that we don't have any information to
> track down the cause.  This patch with cause such a failure to report the
> failed label in an SELINUX_ERR audit message.  This is similar to the
> SELINUX_ERR reports on invalid transitions and things like that.  It should
> help run down problems on what is trying to set invalid labels in the
> future.

So, the existing code seems to do the right thing:
>        rc = security_context_to_sid(value, size, &newsid);

But this new code looks very wrong:
> +                       audit_log_n_untrustedstring(ab, value, strnlen(value, size));

If somebody stuck a "\0" character in there that would not do what you want.

I would expect this is the correct way:
  audit_log_n_untrustedstring(ab, value, size)

I looked at audit_log_n_untrustedstring and
security_context_to_sid_core, and both seem to assume that "size" does
not include a trailing NUL.

Reading through "security_context_to_sid_core()", it appears to have a
bug when !ss_initialized:
  if (!strcmp(initial_sid_to_string[i], scontext))

Where's the references to scontext_len???

It looks like it will allow (during early boot) a process to set an
invalid xattr on a file yet cache a valid SID for the same file, EG:
"system_u:object_r:kernel_t:s0\0HelloWorld", hm?

Furthermore, the rest of that code is very non-obviously correct
regarding checking against the length instead of a NUL character.

Cheers,
Kyle Moffett

-- 
Curious about my work on the Debian powerpcspe port?
I'm keeping a blog here: http://pureperl.blogspot.com/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
