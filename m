Subject: Re: Are the reference policy abstractions the right ones?
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <1192122040.26928.61.camel@dhcp-64-223.iad.redhat.com>
References: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>
	 <1191949852.23486.55.camel@dhcp-64-223.iad.redhat.com>
	 <1191956082.2794.107.camel@moss-lions.epoch.ncsc.mil>
	 <1191956863.23486.62.camel@dhcp-64-223.iad.redhat.com>
	 <1191959097.2794.127.camel@moss-lions.epoch.ncsc.mil>
	 <1191960025.23486.70.camel@dhcp-64-223.iad.redhat.com>
	 <1192029823.2898.32.camel@localhost.localdomain>
	 <1192035162.15060.57.camel@moss-lions.epoch.ncsc.mil>
	 <1192048777.7524.9.camel@localhost.localdomain>
	 <1192122040.26928.61.camel@dhcp-64-223.iad.redhat.com>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 13:32:50 -0400
Message-Id: <1192123970.21812.26.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-10-11 at 13:00 -0400, Karl MacMillan wrote:
> On Wed, 2007-10-10 at 16:39 -0400, Karl MacMillan wrote:
> > On Wed, 2007-10-10 at 12:52 -0400, James Carter wrote:
> > > On Wed, 2007-10-10 at 11:23 -0400, Karl MacMillan wrote:
> > > [...]
> > > > 
> > > > Here's a suggestion (this assumes that hierarchy stops using dot in
> > > > favor of explicit statements):
> > > > 
> > > > type_group daemon {
> > > > 	type process, domain;
> > > > 	type exec, exec_file;
> > > > 	type conf, file_type;
> > > > 	type log, log_file;
> > > > }
> > > > 
> > > 
> > > Why not call it type_class?
> > 
> > Or type_struct :) I don't really care . . .
> > 
> > > 
> > > > allow daemon.process daemon.exec : file entrypoint;
> > > > # etc., etc. for the exec permissions - could
> > > > # even have a type_transition.
> > > > allow daemon.process daemon.conf : file read;
> > > > allow daemon.process daemon.log : file { read write };
> > > > 
> > > So, process, exec, conf, and log are in scope within the type_group
> > > block and are referred to outside of that block by identifying the
> > > namespace using a ".".  Sort of like referring to functions in a python
> > > module.  Is that right?
> > > 
> > 
> > Yep.
> > 
> > > > # Apache gets all of the types defined in daemon and
> > > > # access to the apache versions - so apache.process
> > > > # can read apache.conf.
> > > > type_group apache, daemon {
> > > > 	type html_files, file;
> > > > }
> > > > 
> > > > allow apache.process apache.html_files : file read;
> > > > 
> > > 
> > > Would there be allow rules inside the type_group block?  I think that it
> > > would be needed to distinguish between rules that can be inherited or
> > > not.
> > > 
> > > For example,
> > > 
> > > type_group daemon {
> > > 	type process, domain;
> > > 
> > > 	allow process foo_t : file read;
> > > }
> > > allow daemon.process bar_t : file read;
> > > 
> > > type_group apache, daemon {
> > > 	...
> > > }
> > > 
> > > apache.process would not have read access on bar_t, but it would on
> > > foo_t.
> > > 
> > 
> > That's interesting - I'm having trouble thinking of useful examples
> > though. And it would need to allow you to add rules "inside" outside of
> > the original declaration.
> > 
> 
I can't think of any examples where it would be useful either.  It just
seemed like there should be a way to distinguish between the rules that
should be inherited and those that shouldn't.  I think that you have the
right idea below.  The except rule would allow the type_group doing the
inheriting to make the decision, which is the right way of doing it.

> Thinking about this more - this is actually the same mistake we have
> already made. Our whole model is that the flexibility has to be
> anticipated by the policy author ahead of time. Say I create a firefox
> policy and later some admin wants create a different firefox policy
> based on that (that, say, limits connections to only the intranet, or
> prevents writing to the home directory, etc.). Currently the policy
> author must:
> 
> a) make the whole policy into a template
> b) factor out all of the access that the later author may want to
> exclude.
> 
> It is killing us. So I think we need a way to exclude rules on
> inheritance. For example:
> 
> type_group firefox {
> 	type process, domain;
> 	type conf, conf_file;
> }
> 
> # bunch of rules, including reading user home dirs and
> # connect / send / receive anywhere
> 
> type_group intranet_firefox {
> 	except process user_home_t : file all_file_perms;
> 	# also exclude network
> }
> 
This looks good to me.  If all permissions are excluded, then that type
is essentially not inherited.

Would you be able to do this?
allow firefox foo_t : file read;

If you can, then why not get rid of the distinction between types and
type_groups?  ;)  I mean, other then the fact that it hurts to think
about nested type_groups inheriting other nested type_groups and that it
would probably add little value for a lot of complexity.

> # allow limited network access
> 
> No idea about that syntax - they idea is to prevent access from being
> inherited. These are not deny rules - they only limit inheritance. I
> think this solves a lot of problems with deny rules - there is no
> ordering, precedence, or any related problems.
> 
> It also gives the flexibility that we have been needing. I also think we
> should make it easy to except lots of access (e.g., except all access on
> sockets or all access to a source type). This will make the exception
> more robust.
> 
> So - I'd like to hear from some other people. Are these ideas worth
> pursuing? The proposals:
> 
> 1) remove the distinction between attributes / types.
> 2) allow nested types / attributes.
> 3) type_class / type_group
> 4) exceptions

I think that these are all interesting ideas.

> 
> Karl
> 
> 
> 
> 
-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
