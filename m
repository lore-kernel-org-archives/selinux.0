Date: Tue, 16 Oct 2007 07:15:12 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
cc: jwcart2@tycho.nsa.gov, SELinux <selinux@tycho.nsa.gov>,
        Steve Smalley <sds@epoch.ncsc.mil>
Subject: Re: Are the reference policy abstractions the right ones?
In-Reply-To: <1192474550.2913.28.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0710160652220.29662@us.intercode.com.au>
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
 <1192474550.2913.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 15 Oct 2007, Karl MacMillan wrote:

> On Mon, 2007-10-15 at 12:50 +1000, James Morris wrote:
> > On Thu, 11 Oct 2007, Karl MacMillan wrote:
> > 
> > > So - I'd like to hear from some other people. Are these ideas worth
> > > pursuing? The proposals:
> > > 
> > > 1) remove the distinction between attributes / types.
> > > 2) allow nested types / attributes.
> > > 3) type_class / type_group
> > > 4) exceptions
> > 
> > I think moving to a general OO model at a higher level is desirable, and 
> > that we need to go beyond simply 'type' in #3 and look at OO classes which 
> > encapsulate all SELinux-related attributes (permissions,
> 
> Do you mean abstract permissions - what are currently interfaces? I
> agree - something like:
> 
> # daemon started from init
> type_class init_daemon {
> 	type process;
> 	type pid_file;
> 	type log_file;
> 	interface manage(type domain) {
> 		# allow r/w to pid and log
> 		# and signal to process
> 	}
> }

Yes.

> > labeling rules, 
> 
> This one is not clear to me. Every time you inherit from a type_class
> you are creating new types which, almost by definition, should have
> separate labeling from parent types. When the labeling should be the
> same you likely want to factor out the type.

The reason for it is twofold:
 - allow binding of the class to OS objects
 - allow the labeling rules to be modified via inheritance

So, someone wanting to customize their httpd would subclass the httpd 
security object, which would also need a new name, and potentially 
override the labeling rules (e.g. different paths to files).

> > network policy,
> 
> Not certain what you mean here - isn't that just packet types?

Things like netfilter contexts, port labels etc. which can be collected 
together into a class under this scheme.

> I agree with the general idea. The devil will be in the details. There
> also isn't really a good container to reuse. Virtual machines are too
> separate, we need something where there is the possibility of controlled
> sharing. Hardened chroots / jails I guess or perhaps one of the other
> light-weight containers.
> 
> Though this won't solve all problems, I do think that making it easy to
> use containers is important.

I was thinking of allowing flexibility with the granularity of the class, 
allowing it to be constructed in a way which matched the granularity at 
which the admin is managing the system.  Containers are just one example, 
where you might have a class composed of other classes, with the top level 
being itself a container, bound to the OS container.

e.g. for a VM, you'd have a "vm" class containing "base_os" class and the 
application class.  So, everything needed is packaged with the VM (or 
whatever: RPM, tarball).  The admin would configure the security of the 
overall system via a relatively simple config file which specifies 
interactions between these encapsulating objects (in this case, vm-vm and 
vm-host policy).

This allows the low-level policy to be hidden via encapsulation, and for 
the admin to be able to think at a higher level in terms of how components 
interact.


- James
-- 
James Morris 
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
