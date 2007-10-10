Subject: Re: Are the reference policy abstractions the right ones?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <1192035162.15060.57.camel@moss-lions.epoch.ncsc.mil>
References: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>
	 <1191949852.23486.55.camel@dhcp-64-223.iad.redhat.com>
	 <1191956082.2794.107.camel@moss-lions.epoch.ncsc.mil>
	 <1191956863.23486.62.camel@dhcp-64-223.iad.redhat.com>
	 <1191959097.2794.127.camel@moss-lions.epoch.ncsc.mil>
	 <1191960025.23486.70.camel@dhcp-64-223.iad.redhat.com>
	 <1192029823.2898.32.camel@localhost.localdomain>
	 <1192035162.15060.57.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 10 Oct 2007 16:39:37 -0400
Message-Id: <1192048777.7524.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-10-10 at 12:52 -0400, James Carter wrote:
> On Wed, 2007-10-10 at 11:23 -0400, Karl MacMillan wrote:
> [...]
> > 
> > Here's a suggestion (this assumes that hierarchy stops using dot in
> > favor of explicit statements):
> > 
> > type_group daemon {
> > 	type process, domain;
> > 	type exec, exec_file;
> > 	type conf, file_type;
> > 	type log, log_file;
> > }
> > 
> 
> Why not call it type_class?

Or type_struct :) I don't really care . . .

> 
> > allow daemon.process daemon.exec : file entrypoint;
> > # etc., etc. for the exec permissions - could
> > # even have a type_transition.
> > allow daemon.process daemon.conf : file read;
> > allow daemon.process daemon.log : file { read write };
> > 
> So, process, exec, conf, and log are in scope within the type_group
> block and are referred to outside of that block by identifying the
> namespace using a ".".  Sort of like referring to functions in a python
> module.  Is that right?
> 

Yep.

> > # Apache gets all of the types defined in daemon and
> > # access to the apache versions - so apache.process
> > # can read apache.conf.
> > type_group apache, daemon {
> > 	type html_files, file;
> > }
> > 
> > allow apache.process apache.html_files : file read;
> > 
> 
> Would there be allow rules inside the type_group block?  I think that it
> would be needed to distinguish between rules that can be inherited or
> not.
> 
> For example,
> 
> type_group daemon {
> 	type process, domain;
> 
> 	allow process foo_t : file read;
> }
> allow daemon.process bar_t : file read;
> 
> type_group apache, daemon {
> 	...
> }
> 
> apache.process would not have read access on bar_t, but it would on
> foo_t.
> 

That's interesting - I'm having trouble thinking of useful examples
though. And it would need to allow you to add rules "inside" outside of
the original declaration.

> 
> Multiple inheritance would be possible, but tricky.
> 
> If the following was also defined:
> 
> type_group b {
> 	type context;
> 	type process;
> 	...
> }
> 
> type_group c, b, daemon {
> 	type process;
> 	...
> }
> 
> What rules would c.process have?  Maybe a union of all the rules for
> process?

That's actually kind of interesting. The union would allow some
interesting customization:

type_group writable_conf {
	type process;
	type conf;
}

allow writable_conf.process writable_conf.conf : file write;

# add to an existing group
type_group apache, writable_conf;

If we ended up with standard names it would be pretty nice.

>   Maybe the namespacing should look like c.process, c.b.process,
> and c.daemon.process?
> 
> If namsepacing worked in the later way, it could provide some useful
> information. if I see denials on a.daemon.log, b.daemon.log, and
> c.daemon.log, I have an idea where the problem is.  On the other hand,
> it could look pretty ugly: a.b.c.d.e.f.g.daemon.log.  Maybe type aliases
> could help with the ugliness though.  You also might be able to use type
> aliases to define both c.b.process and c.daemon.process to be c_process
> and have a union of the permissions.
> 

Wow - that kind of makes my head explode.

> We still need a way to deny or disallow permissions.  It also might be
> useful to remove types.
> 
> So, using the type_group daemon that you defined:
> 
> type_group d, daemon {
> 	remove_type daemon.conf;
> 	remove_type daemon.log;
> 
> 	disallow daemon.process blah : file read;
> }
> 
> I don't know; maybe I am the crazy one.
> 

Seriously - though excluding types is not a bad idea. What about

type_group d, daemon {
	except type daemon.conf;
}

And that might be really useful with multiple inheritance.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
