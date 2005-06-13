Subject: Re: libsepol - users [ Patch v. 0]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118679035.9356.7.camel@dhcp83-8.boston.redhat.com>
References: <1118342870.30978.12.camel@dhcp83-8.boston.redhat.com>
	 <1118441058.7908.2.camel@dhcp83-8.boston.redhat.com>
	 <1118677251.24565.97.camel@moss-spartans.epoch.ncsc.mil>
	 <1118679035.9356.7.camel@dhcp83-8.boston.redhat.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 13:15:05 -0400
Message-Id: <1118682905.24565.118.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-06-13 at 12:10 -0400, Ivan Gyurdiev wrote:
> Yes, I understand the concern - I am not ignoring the issue.
> I've tried to write it this way for efficiency, but if you prefer I
> can duplicate the strings.

I suppose it depends on whether we expect any other users of these
functions, and whether they are likely to only require such localized
reference as well.

> Right, I fixed this, and now it actually compiles and runs :)

Ok, and I presume the static variables were moved to a .c file.  We
should likely adjust the libsepol/src/Makefile to be consistent with the
libselinux one so that we get stricter checking.

> Can you explain this a bit more - I haven't worked w/ varargs a lot.

Just prefix the sepol_debug_printf() definition with that attribute
qualifier, and the compiler will apply normal printf-style checking to
the arguments against the format string.

> So, is genhomedircon wrong in that assumption? Should it be looking
> at the <username> file instead?

The <username> or default_contexts would be more accurate, but then you
have the problem of which default do you want, e.g. login, sshd, xdm,
etc.  Could differ, e.g. root login via xdm might default to staff while
root login on console might default to sysadm.

Of course, if we had polyinstantiated home directories, then you get a
separate home directory for each role.

> I'll look at that. Is the mls context supposed to allow spaces?

The normal context parsing code in the security server
(mls_context_to_sid) and in libselinux (context_new) doesn't allow
whitespace within the context, but checkpolicy allows it in the source
policy configuration, e.g. s0 : c0, c2 is legal to checkpolicy but
libselinux or the kernel would only take s0:c0,c2.  That's why the
genusers code strips whitespace prior to passing the MLS level or range
along to mls_context_to_sid.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
