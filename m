Subject: Re: libsepol - users [ Patch v. 0]
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118677251.24565.97.camel@moss-spartans.epoch.ncsc.mil>
References: <1118342870.30978.12.camel@dhcp83-8.boston.redhat.com>
	 <1118441058.7908.2.camel@dhcp83-8.boston.redhat.com>
	 <1118677251.24565.97.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 12:10:34 -0400
Message-Id: <1118679035.9356.7.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> - In the future, please post as a diff -uprN generated patch against
> libsepol, not as separate file attachments even when only adding new
> files.  The patch can be an attachment if you prefer that, although
> inline has advantages for reading and commenting (quoting sections of
> the diffs easily in the reply).

Okay...

> - I'm not sure about having the uc_set_* functions simply save the
> provided pointers rather than allocating their own storage (e.g. strdup
> them).  Especially since you do have an explicit destructor that could
> easily handle freeing the memory.  It looks like you only need the
> buffer to stay around temporarily anyway, but I'm a little concerned
> about more general use of the structure and functions in the future.

Yes, I understand the concern - I am not ignoring the issue.
I've tried to write it this way for efficiency, but if you prefer I
can duplicate the strings.

> - No functions in .h files other than static inlines (users_internal.h).

Right, I fixed this, and now it actually compiles and runs :)

> Not new to your code, but sepol_debug_printf should have an
> __attribute__ ((format (printf, 1, 2))).

Can you explain this a bit more - I haven't worked w/ varargs a lot.
  
> - As a warning, the notion of the first role as the "default" role is
> somewhat of a lie.  Default role for a user process is determined by
> libselinux based on /etc/selinux/strict/contexts/default_contexts and
> the optional /etc/selinux/strict/contexts/users/<username> file and may
> vary depending on the application (e.g. local login vs. ssh login vs gdm
> login vs. cron job vs. su shell vs. sudo command).  Kernel binary policy
> just specifies set of allowed roles with no real ordering or notion of
> default.  I know that genhomedircon already makes the assumption that
> the first role is the default, but that is just a convention.

So, is genhomedircon wrong in that assumption? Should it be looking
at the <username> file instead?

> - Not new to your code, but the parsing of lines from the users files is
> not as general as it should be, e.g. checkpolicy would allow a single
> user entry to span multiple lines whereas genusers does not.

I'll look at that. Is the mls context supposed to allow spaces?

=======

P.S. I'm actually testing this now - fixed a bunch of bugs, 
and running through valgrind to clear memory leaks. I'll
submit a testable patch next time.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
