Date: Tue, 16 Jul 2002 13:46:23 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Richard Mayo <rmayo@caci.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Creating Permissions for New Software
In-Reply-To: <OFC3FE5220.D84825C9-ON85256BF8.00591C2A@hq.caci.com>
Message-ID: <Pine.GSO.4.33.0207161332200.23767-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 16 Jul 2002, Richard Mayo wrote:

> Additionally, I created a new .te file (copied from Mr. Smalley's original
> for Netscape) and commented out most of the original lines.   I've left a
> few in -- the ones that create the derived domain and transition to this
> domain --  but all of the specific permissions have been removed.
> Additinally, I did remember to add this file to the list of includes in
> user_macros.te.

As a side note, it sounds like you are using the 2002053110 release rather
than the latest release (2002070313), since the need for explicit
include's went away when we merged some of Russell's changes to the policy
Makefile.

However, regardless of whether or not you need to include the file, you
do need to "call" the macro within the user_domain macro definition.  See
the series of macro "calls" preceded by the comment "# Instantiate derived
domains for a number of programs."  Did you remember to do this?

> Since then, I've tried to grant permissions to the user for his user files,
> but nothing changed.

Two possible causes:  1) you failed to "call" the macro, so it isn't being
used, or 2) you failed to load the new policy into the kernel after
updating it via 'make load'.

> One specific question I have is, "What do I gain by creating the derived
> (temporary?) domain and how does this impact the permission I must grant to
> run my software?"

You only need a separate domain if you want to grant different permissions
to the software than to the user.  In the case of netscape/mozilla, we
want to run the software with fewer permissions than the user to confine
any exploit of the browser by malicious mobile code.  In the case of some
programs, we want to run the software with more permissions than the user
is directly granted.  Or we may want to just run the software
with different permissions than the user, neither a strict subset nor
superset.

You can define a separate domain without defining a derived domain.  For
example, for the spasswd wrapper program, a single passwd_t domain is
defined in domains/program/passwd.te, and all user domains transition to
this domain when running spasswd.  In contrast, with a derived domain like
the netscape/mozilla domain, each user domain transitions to its own
derived domain when running the program (e.g. sysadm_netscape_t or
user_netscape_t).  The use of derived domains allow the policy to maintain
separation between different instances of the program being run by
different user domains.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
