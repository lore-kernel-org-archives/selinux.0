Subject: Re: libsepol - users [ Patch v. 0]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118441058.7908.2.camel@dhcp83-8.boston.redhat.com>
References: <1118342870.30978.12.camel@dhcp83-8.boston.redhat.com>
	 <1118441058.7908.2.camel@dhcp83-8.boston.redhat.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 11:40:51 -0400
Message-Id: <1118677251.24565.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 18:04 -0400, Ivan Gyurdiev wrote:
> On Thu, 2005-06-09 at 14:47 -0400, Ivan Gyurdiev wrote:
> > I have yet to see if this code works at all, but please have a look
> > to determine if it's moving in the right direction. The goals are:
> 
> no comment?
> 
> Come on, it can't be that bad :)

- In the future, please post as a diff -uprN generated patch against
libsepol, not as separate file attachments even when only adding new
files.  The patch can be an attachment if you prefer that, although
inline has advantages for reading and commenting (quoting sections of
the diffs easily in the reply).

- I'm not sure about having the uc_set_* functions simply save the
provided pointers rather than allocating their own storage (e.g. strdup
them).  Especially since you do have an explicit destructor that could
easily handle freeing the memory.  It looks like you only need the
buffer to stay around temporarily anyway, but I'm a little concerned
about more general use of the structure and functions in the future.

- No functions in .h files other than static inlines (users_internal.h).
Not new to your code, but sepol_debug_printf should have an
__attribute__ ((format (printf, 1, 2))).
  
- As a warning, the notion of the first role as the "default" role is
somewhat of a lie.  Default role for a user process is determined by
libselinux based on /etc/selinux/strict/contexts/default_contexts and
the optional /etc/selinux/strict/contexts/users/<username> file and may
vary depending on the application (e.g. local login vs. ssh login vs gdm
login vs. cron job vs. su shell vs. sudo command).  Kernel binary policy
just specifies set of allowed roles with no real ordering or notion of
default.  I know that genhomedircon already makes the assumption that
the first role is the default, but that is just a convention.

- Not new to your code, but the parsing of lines from the users files is
not as general as it should be, e.g. checkpolicy would allow a single
user entry to span multiple lines whereas genusers does not.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
