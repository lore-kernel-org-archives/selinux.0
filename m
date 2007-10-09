Subject: Re: Are the reference policy abstractions the right ones?
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <1191949852.23486.55.camel@dhcp-64-223.iad.redhat.com>
References: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>
	 <1191949852.23486.55.camel@dhcp-64-223.iad.redhat.com>
Content-Type: text/plain
Date: Tue, 09 Oct 2007 14:54:42 -0400
Message-Id: <1191956082.2794.107.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-09 at 13:10 -0400, Karl MacMillan wrote:
> On Tue, 2007-10-09 at 11:08 -0400, James Carter wrote:
> [...]
> > 
> > 1) A way to say, "I want a domain like that one, without this
> > permission, but with that one".  I think that inheritance is the answer,
> > because a macro requires you to know ahead of time that someone might be
> > interested in making something similar.  I believe that Karl tried to
> > start a discussion on inheritance a month ago, but there wasn't any
> > interest.  Let's restart that discussion.  I think that whether through
> > macros or inheritance, a rule to remove permissions is needed, because
> > without one, we have to get the base classes or macros perfect.
> > 
> 
> Like I said I think this would be useful.
> 
> > 2) A way to export types in some manner that would still allow
> > flexibility in renaming or splitting a type locally, without having to
> > change the global name.  That global name would also have to be what
> > shows up in audit logs and other things.  Maybe this is impossible and
> > we are just stuck treating types as global entities.
> > 
> 
> It occurs to me that removing the distinction between types and
> attributes and allowing nesting of them gets a lot of this. Say you have
> a type:
> 
> type foo;
> 
> allow foo etc_t : file read;
> allow foo self : process signal;
> 
> If you could then just say:
> 
> type bar, foo;
> 
> I.e., treat foo as an attribute. That would handle the type splitting
> issues for files as well. Nested attributes would also allow building up
> of more complex attributes:
> 
> attribute domain;
> # rules for a process
> 
> attribute daemon, domain;
> # daemon is also a domain. Add rules related
> # to being a daemon
> 
> attribute network_server, daemon;
> # A daemon that can talk on the network.

Still thinking about this, but why would you use the attribute
statement?

wouldn't it be this?

type domain
type daemon, domain
type network_server, daemon

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
