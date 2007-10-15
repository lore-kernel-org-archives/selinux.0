Subject: Re: Are the reference policy abstractions the right ones?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: James Morris <jmorris@namei.org>
Cc: jwcart2@tycho.nsa.gov, SELinux <selinux@tycho.nsa.gov>,
        Steve Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <Xine.LNX.4.64.0710151116270.433@us.intercode.com.au>
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
	 <Xine.LNX.4.64.0710151116270.433@us.intercode.com.au>
Content-Type: text/plain
Date: Mon, 15 Oct 2007 14:55:50 -0400
Message-Id: <1192474550.2913.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-10-15 at 12:50 +1000, James Morris wrote:
> On Thu, 11 Oct 2007, Karl MacMillan wrote:
> 
> > So - I'd like to hear from some other people. Are these ideas worth
> > pursuing? The proposals:
> > 
> > 1) remove the distinction between attributes / types.
> > 2) allow nested types / attributes.
> > 3) type_class / type_group
> > 4) exceptions
> 
> I think moving to a general OO model at a higher level is desirable, and 
> that we need to go beyond simply 'type' in #3 and look at OO classes which 
> encapsulate all SELinux-related attributes (permissions,

Do you mean abstract permissions - what are currently interfaces? I
agree - something like:

# daemon started from init
type_class init_daemon {
	type process;
	type pid_file;
	type log_file;
	interface manage(type domain) {
		# allow r/w to pid and log
		# and signal to process
	}
}

# daemon that uses the network
type_class network_daemon, init_daemon {
	interface manage(type domain) {
		# add access unique to this type_class
		# other access should chain by default.
		# May need to be able to disable chaining.
	}
}

type_class apache, network_daemon;

# call the interface - this looks backwards to me
apache.manage(sysadm_t);

# alternative syntax - this keeps subject / object ordering,
# but we can't pass multiple args this way. And should the
# separator be something other than "."?
allow sysadm_t apache.manage;

Of course there are details - like we want to be able to add these after
the initial type_class definition. Actually, I'd like the definitions to
be "open" for later modification in general. That way I could add a new
type to every network_daemon for example.

> labeling rules, 

This one is not clear to me. Every time you inherit from a type_class
you are creating new types which, almost by definition, should have
separate labeling from parent types. When the labeling should be the
same you likely want to factor out the type.

Take exec types as an example - you likely want those outside of the
type class.

type firefox_exec_t; # shared among all firefox domains
type_class firefox {
	type process, domain;
	type config, file_type; # likely polyinstantiated ~/.mozilla
}

# new firefox - still gets entrypoint for
# firefox_exec_t
type class intranet_firefox, firefox;

Of course, this brings up questions about transitions. Transitions to
the process types should likely be dropped (auto-inserting them would
just cause conflicts), but transitions from the process types (like for
helper apps) should likely be kept. They can be excluded if desired.

> network policy,

Not certain what you mean here - isn't that just packet types?

>  booleans etc).
> 

Agreed. So in generaly I definitely agree and we may need to call it
something other than type_class. Suggestions welcome.

> People are increasingly utilizing containers/VMs/appliances to manage and 
> isolate their applications, and I think that this is also a means for us 
> to provide higher-level SELinux abstractions.
> 
> With comprehensive SELinux classes, we could:
> 
> - Bind security classes to various levels of system abstraction, and thus 
>   bind security objects to a variety of types of encapsulating objects 
>   (e.g. RPM, VM, container, tarball, standalone file);
> 
> - Modify classes via inheritance (already discussed somewhat);
> 
> - Define high-level interactions between classes via well-defined 
>   interfaces;
> 
> - Compose classes into higher-level classes in a structured, analyzable 
>   manner.
> 
> With the latter being an important way to allow admins to configure 
> overall security at a meaningful level of granularity, matching the level 
> of encapsulation which they are already using for managing applications.
> 
> The idea generally being that admins/developers not think in terms of low 
> level policy constructs (although allow these to be exposed if needed), 
> but rather, to think about composing security objects into e.g. a 
> container, and then from a system point of view, to be able to broadly 
> define how the containers interact with each other and the base system.

I agree with the general idea. The devil will be in the details. There
also isn't really a good container to reuse. Virtual machines are too
separate, we need something where there is the possibility of controlled
sharing. Hardened chroots / jails I guess or perhaps one of the other
light-weight containers.

Though this won't solve all problems, I do think that making it easy to
use containers is important.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
