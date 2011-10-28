Subject: Re: [PATCH] SELinux: audit failed attempts to set invalid labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kyle Moffett <kyle@moffetthome.net>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <CAGZ=bqJtuLzaycj9QJQJGxTMA2aRiOrEjGf+Wn39dv5gPQJFwg@mail.gmail.com>
References: <20111027210531.14866.89071.stgit@paris.rdu.redhat.com>
	 <CAGZ=bqJtuLzaycj9QJQJGxTMA2aRiOrEjGf+Wn39dv5gPQJFwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 28 Oct 2011 09:02:52 -0400
Message-ID: <1319806972.19110.12.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-10-27 at 21:10 -0400, Kyle Moffett wrote:
> I looked at audit_log_n_untrustedstring and
> security_context_to_sid_core, and both seem to assume that "size" does
> not include a trailing NUL.

security_context_to_sid_core() is supposed to handle it either way, with
or without a trailing NUL.  Originally it only took NUL-terminated
strings (with the original SELinux interfaces), but we had to make it
more forgiving of its input when we switched to using the xattr APIs.

> Reading through "security_context_to_sid_core()", it appears to have a
> bug when !ss_initialized:
>   if (!strcmp(initial_sid_to_string[i], scontext))
> 
> Where's the references to scontext_len???

Fair enough, we don't seem to have updated that case.  Of course, that
only happens before policy is loaded and thus anything is allowed
anyway.

> It looks like it will allow (during early boot) a process to set an
> invalid xattr on a file yet cache a valid SID for the same file, EG:
> "system_u:object_r:kernel_t:s0\0HelloWorld", hm?

Well, technically it will only accept strings with initial SID names
(e.g. "kernel" or "kernel\0HelloWorld", which aren't even valid contexts
once the policy has loaded).  And that's merely to ensure that
security_sid_to_context() followed by security_context_to_sid() on an
initial SID during bootup yields the right SID.  Those contexts should
never be stored at all, as selinux_inode_setxattr() won't let you set an
SELinux label on a filesystem until after policy has loaded.

> Furthermore, the rest of that code is very non-obviously correct
> regarding checking against the length instead of a NUL character.

That's because the original code only dealt with NUL-terminated strings,
and we merely changed security_context_to_sid_core() to create a
NUL-terminated copy for use by the rest of the code (it was already
copying it to allow modifying it during parsing, so we just extended it
by a byte and cleared the last byte).  And then
string_to_context_struct() applies a check against scontext_len just
before the policydb_context_isvalid() call to ensure that we have
consumed the entire context value during parsing.

So trying to set a context value with content after a NUL will just
return -1 with errno EINVAL; feel free to try it (I did).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
