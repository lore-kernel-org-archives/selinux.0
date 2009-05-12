Subject: Re: Nodecon configuration question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas <selinux-thomas@gonicus.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200905121046.58102.selinux-thomas@gonicus.de>
References: <200905111534.16145.selinux-thomas@gonicus.de>
	 <1242049395.4289.38.camel@localhost.localdomain>
	 <200905121046.58102.selinux-thomas@gonicus.de>
Content-Type: text/plain
Date: Tue, 12 May 2009 07:58:50 -0400
Message-Id: <1242129530.31807.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-05-12 at 10:46 +0200, Thomas wrote:
> Hi Stephen,
> 
> thanks for your fast answer and your informations. they are very helpful.
> 
> > > i've a question for limiting network-access on my selinux installation.
> > > The system which one i'm using is a debian lenny with the default policys
> > > and a selfmade creation of java.pp and wine.pp.
> > >
> > > Now i would limit the access for the wine programms to 5 or 6 ip
> > > addresses from the local network.
> > >
> > > That is what i was trying:
> > > At the first step i changed the inaddr_any_node_t type in the
> > > corenetwork.te file to one of my needed ip addresses to test if it would
> > > work with a minimal configuration change.
> > > like this:
> > >
> > > type inaddr_any_node_t alias node_inaddr_any_t, node_type;
> > > nodecon 10.10.10.10 255.255.255.255
> > > gen_context(system_u:object_r:inaddr_any_node_t,s0)
> is this generally the right way to test the address limit to some allowed ip 
> adresses in the network?

I would have introduced a new type for your purpose and then associated
the desired ip addresses to it rather than overloading the meaning of
inaddr_any_node_t.

> >
> > BTW, semanage now supports configuration of node contexts outside of the
> > base module if you want to try that.
> I saw that this is a feature of the future releases of semanage. At the moment 
> i use the selinux installation from lenny. If i want to configure the nodes i 
> get the message "node not defined". so i think this feature isnt integreated 
> in this installation. can i use only a newer version of semanage to try the 
> ip limit? or have i to update the whole selinux software?

As I recall, the support already existed in the libraries, so only the
semanage/seobject.py code had to be updated to fully support defining
local node contexts.  So you could in theory extract the patch that
updated semanage and apply that without updating the rest of your
SELinux userland.  However, in general, we recommend updating all of the
core SELinux userland together (libsepol, checkpolicy, libselinux,
libsemanage, policycoreutils).

> >
> > > In the selfmade wine.te configuration i typed following:
> > >
> > > allow wine_t inaddr_any_node_t:tcp_socket node_bind;
> > >
> > >
> > > But after starting a wine programm f.e. putty.exe it cant get a right
> > > connection to the test-host. Everytime i get the message from putty:
> > > Unable to open connection to 10.10.10.10 Network error: Permission
> > > denied"
> > >
> > > I think something is not right in my configuration or in my train of
> > > thoughts..
> > >
> > > I would be very happy if someone can give me a food for thought.
> 
> Greetings
> Thomas Bludau
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
