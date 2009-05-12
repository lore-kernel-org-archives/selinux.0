From: Thomas <selinux-thomas@gonicus.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Nodecon configuration question
Date: Tue, 12 May 2009 10:46:57 +0200
Cc: selinux@tycho.nsa.gov
References: <200905111534.16145.selinux-thomas@gonicus.de> <1242049395.4289.38.camel@localhost.localdomain>
In-Reply-To: <1242049395.4289.38.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200905121046.58102.selinux-thomas@gonicus.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,

thanks for your fast answer and your informations. they are very helpful.

> > i've a question for limiting network-access on my selinux installation.
> > The system which one i'm using is a debian lenny with the default policys
> > and a selfmade creation of java.pp and wine.pp.
> >
> > Now i would limit the access for the wine programms to 5 or 6 ip
> > addresses from the local network.
> >
> > That is what i was trying:
> > At the first step i changed the inaddr_any_node_t type in the
> > corenetwork.te file to one of my needed ip addresses to test if it would
> > work with a minimal configuration change.
> > like this:
> >
> > type inaddr_any_node_t alias node_inaddr_any_t, node_type;
> > nodecon 10.10.10.10 255.255.255.255
> > gen_context(system_u:object_r:inaddr_any_node_t,s0)
is this generally the right way to test the address limit to some allowed ip 
adresses in the network?

>
> BTW, semanage now supports configuration of node contexts outside of the
> base module if you want to try that.
I saw that this is a feature of the future releases of semanage. At the moment 
i use the selinux installation from lenny. If i want to configure the nodes i 
get the message "node not defined". so i think this feature isnt integreated 
in this installation. can i use only a newer version of semanage to try the 
ip limit? or have i to update the whole selinux software?

>
> > In the selfmade wine.te configuration i typed following:
> >
> > allow wine_t inaddr_any_node_t:tcp_socket node_bind;
> >
> >
> > But after starting a wine programm f.e. putty.exe it cant get a right
> > connection to the test-host. Everytime i get the message from putty:
> > Unable to open connection to 10.10.10.10 Network error: Permission
> > denied"
> >
> > I think something is not right in my configuration or in my train of
> > thoughts..
> >
> > I would be very happy if someone can give me a food for thought.

Greetings
Thomas Bludau

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
