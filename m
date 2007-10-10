Subject: Re: Are the reference policy abstractions the right ones?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <1191960025.23486.70.camel@dhcp-64-223.iad.redhat.com>
References: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>
	 <1191949852.23486.55.camel@dhcp-64-223.iad.redhat.com>
	 <1191956082.2794.107.camel@moss-lions.epoch.ncsc.mil>
	 <1191956863.23486.62.camel@dhcp-64-223.iad.redhat.com>
	 <1191959097.2794.127.camel@moss-lions.epoch.ncsc.mil>
	 <1191960025.23486.70.camel@dhcp-64-223.iad.redhat.com>
Content-Type: text/plain
Date: Wed, 10 Oct 2007 11:23:43 -0400
Message-Id: <1192029823.2898.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-09 at 16:00 -0400, Karl MacMillan wrote:
> On Tue, 2007-10-09 at 15:44 -0400, James Carter wrote:
> > On Tue, 2007-10-09 at 15:07 -0400, Karl MacMillan wrote:
> 
> [...]
> 
> > 
> > > >  but why would you use the attribute
> > > > statement?
> > > > 
> > > > wouldn't it be this?
> > > > 
> > > > type domain
> > > > type daemon, domain
> > > > type network_server, daemon
> > > > 
> > > 
> > > Maybe - if we remove the distinction entirely. The only reason I can
> > > think to leave the attribute statement is to mark a type as "abstract" -
> > > i.e., can't actually be a label on a real subject or object in the
> > > running system.
> > > 
> > There would be a few places where one might use an abstract type, domain
> > being one of them, but I am not sure they would be needed.
> > 
> > Your idea does seem to be simple, but it still won't handle the case
> > where there is type mangling.
> > 
> > if we have:
> > 
> > type foo;
> > allow foo foo_bar : file read;
> > type baz, foo;
> > 
> > Where foo_bar was created in some macro or interface.
> > 
> > It seems like baz would have read permission on foo_bar, when probably
> > we would like it to have read permission on baz_bar.
> > 
> > All of which you know and previously mentioned a month ago:
> > http://marc.info/?l=selinux&m=118961442411429&w=2
> > 
> 
> Yeah - too bad I don't have an answer. We basically need a way to mark
> groups of types as related and do self-like replacements. No good syntax
> suggestions here.
> 

Here's a suggestion (this assumes that hierarchy stops using dot in
favor of explicit statements):

type_group daemon {
	type process, domain;
	type exec, exec_file;
	type conf, file_type;
	type log, log_file;
}

allow daemon.process daemon.exec : file entrypoint;
# etc., etc. for the exec permissions - could
# even have a type_transition.
allow daemon.process daemon.conf : file read;
allow daemon.process daemon.log : file { read write };

# Apache gets all of the types defined in daemon and
# access to the apache versions - so apache.process
# can read apache.conf.
type_group apache, daemon {
	type html_files, file;
}

allow apache.process apache.html_files : file read;

This handles the new set of types that is separate from the existing
set. We could also make some of the groups "abstract" - so that
daemon.process can't be applied to a process.

To handle the need for extension - Dan's java_t example. Assuming we
have unconfined, wouldn't this work:

type java_t, unconfined_t;

allow java_t self : process execmem;

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
