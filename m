Subject: Re: Added is_context_configurable function
From: Colin Walters <walters@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1105567743.23136.59.camel@moss-spartans.epoch.ncsc.mil>
References: <41E2FEF4.5070604@redhat.com>
	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
	 <41E3FAF4.2060109@redhat.com>
	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
	 <1105481440.24748.22.camel@nexus.verbum.private>
	 <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
	 <1105544883.10150.17.camel@nexus.verbum.private>
	 <1105567743.23136.59.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 22:52:32 -0500
Message-Id: <1105588352.4649.37.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 17:09 -0500, Stephen Smalley wrote:
> On Wed, 2005-01-12 at 10:48, Colin Walters wrote:
> > Actually, thinking about this a bit: probably not.  On my system I have
> > several times changed the SELinux user identity component of file
> > contexts from the default system_u to e.g. foo_u.  The reason is that
> > the constraints prevent a user from relabeling a file unless the SELinux
> > user matches.  So a list of alternate types would not be sufficient in
> > this case.
> <snip>
> > It seems the SELinux uid, for one.  Also perhaps whether or not the
> > pathname is part of the standard filesystem.  There seems to me to be a
> > difference between a very well known file such as /etc/shadow being
> > mislabeled according to file_contexts versus an unknown path such
> > as /apps/web/blah.
> 
> Ok, so I take this to mean that I should await a new patchset from Dan
> that supports this more general way of specifying customizable contexts
> based on a combination of type, user identity, and file location.  Yes?

This is a complex issue, given we've been going back and forth on this
for months now, with several proposed patches.  The last time this came
up in October, you posted a good message:

http://marc.theaimsgroup.com/?l=selinux&m=109872521815476&w=2

You say:

> The file_contexts configuration and setfiles were only intended to
> initialize the system, as previously noted.  After installation, one
> should only do a make relabel upon a major policy upgrade, and even in
> that case, it would be better to selectively relabel based on the
> differences between the policies.

And I couldn't agree more.  If we can get to the point where we never
(and I really mean never!) tell users to run "fixfiles relabel", I think
a lot of these problems would essentially just go away.   I brainstormed
a bit in another message in this thread about how we can avoid it for
policy upgrades, which I believe is the major cause.  I'll follow up to
that in a bit.

Let's assume for now that we've successfully gotten rid of fixfiles (at
least from the user's perspective; it may exist as an implementation
detail).  At that point, what problems remain?  The problem of user-
customizable types like httpd_sys_script_ro_t in well-known areas such
as /var/www being reset to httpd_sys_content_t goes away, because there
is nothing to reset them.  The problem of user-defined locations such
as /web/mysite1 with type httpd_sys_content_t being reset to default_t
goes away as well.  Are there any other problems?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
