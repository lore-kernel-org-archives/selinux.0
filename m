Date: Mon, 15 Oct 2007 12:50:47 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
cc: jwcart2@tycho.nsa.gov, SELinux <selinux@tycho.nsa.gov>,
        Steve Smalley <sds@epoch.ncsc.mil>
Subject: Re: Are the reference policy abstractions the right ones?
In-Reply-To: <1192122040.26928.61.camel@dhcp-64-223.iad.redhat.com>
Message-ID: <Xine.LNX.4.64.0710151116270.433@us.intercode.com.au>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 11 Oct 2007, Karl MacMillan wrote:

> So - I'd like to hear from some other people. Are these ideas worth
> pursuing? The proposals:
> 
> 1) remove the distinction between attributes / types.
> 2) allow nested types / attributes.
> 3) type_class / type_group
> 4) exceptions

I think moving to a general OO model at a higher level is desirable, and 
that we need to go beyond simply 'type' in #3 and look at OO classes which 
encapsulate all SELinux-related attributes (permissions, labeling rules, 
network policy, booleans etc).

People are increasingly utilizing containers/VMs/appliances to manage and 
isolate their applications, and I think that this is also a means for us 
to provide higher-level SELinux abstractions.

With comprehensive SELinux classes, we could:

- Bind security classes to various levels of system abstraction, and thus 
  bind security objects to a variety of types of encapsulating objects 
  (e.g. RPM, VM, container, tarball, standalone file);

- Modify classes via inheritance (already discussed somewhat);

- Define high-level interactions between classes via well-defined 
  interfaces;

- Compose classes into higher-level classes in a structured, analyzable 
  manner.

With the latter being an important way to allow admins to configure 
overall security at a meaningful level of granularity, matching the level 
of encapsulation which they are already using for managing applications.

The idea generally being that admins/developers not think in terms of low 
level policy constructs (although allow these to be exposed if needed), 
but rather, to think about composing security objects into e.g. a 
container, and then from a system point of view, to be able to broadly 
define how the containers interact with each other and the base system.


Thoughts?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
