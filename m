Subject: Re: Added is_context_configurable function
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1105544883.10150.17.camel@nexus.verbum.private>
References: <41E2FEF4.5070604@redhat.com>
	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
	 <41E3FAF4.2060109@redhat.com>
	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
	 <1105481440.24748.22.camel@nexus.verbum.private>
	 <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
	 <1105544883.10150.17.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1105567743.23136.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 17:09:03 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 10:48, Colin Walters wrote:
> Actually, thinking about this a bit: probably not.  On my system I have
> several times changed the SELinux user identity component of file
> contexts from the default system_u to e.g. foo_u.  The reason is that
> the constraints prevent a user from relabeling a file unless the SELinux
> user matches.  So a list of alternate types would not be sufficient in
> this case.
<snip>
> It seems the SELinux uid, for one.  Also perhaps whether or not the
> pathname is part of the standard filesystem.  There seems to me to be a
> difference between a very well known file such as /etc/shadow being
> mislabeled according to file_contexts versus an unknown path such
> as /apps/web/blah.

Ok, so I take this to mean that I should await a new patchset from Dan
that supports this more general way of specifying customizable contexts
based on a combination of type, user identity, and file location.  Yes?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
