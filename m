From: Thomas <selinux-thomas@gonicus.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Nodecon configuration question [solved]
Date: Tue, 12 May 2009 15:01:27 +0200
Cc: selinux@tycho.nsa.gov
References: <200905111534.16145.selinux-thomas@gonicus.de> <200905121046.58102.selinux-thomas@gonicus.de> <1242129530.31807.5.camel@localhost.localdomain>
In-Reply-To: <1242129530.31807.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200905121501.27291.selinux-thomas@gonicus.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > > > i've a question for limiting network-access on my selinux
> > > > installation. The system which one i'm using is a debian lenny with
> > > > the default policys and a selfmade creation of java.pp and wine.pp.
> > > >
> > > > Now i would limit the access for the wine programms to 5 or 6 ip
> > > > addresses from the local network.
> > > >
> > > > That is what i was trying:
> > > > At the first step i changed the inaddr_any_node_t type in the
> > > > corenetwork.te file to one of my needed ip addresses to test if it
> > > > would work with a minimal configuration change.
> > > > like this:
> > > >
> > > > type inaddr_any_node_t alias node_inaddr_any_t, node_type;
> > > > nodecon 10.10.10.10 255.255.255.255
> > > > gen_context(system_u:object_r:inaddr_any_node_t,s0)
> >
> > is this generally the right way to test the address limit to some allowed
> > ip adresses in the network?
>
> I would have introduced a new type for your purpose and then associated
> the desired ip addresses to it rather than overloading the meaning of
> inaddr_any_node_t.

Stephen, thank you very much for your answers!

I used this field and node-name to test it generally. Now i've found my 
mistake. I've forgot to add something in the wine.te file.

This is the solution of my problem:
New type in the corenetwork.te file:

type newname_any_node_t alias node_anyname_any_t, node_type;
nodecon 10.10.10.10 255.255.255.255 
gen_context(system_u:object_r:anyname_any_node_t,s0)
nodecon 10.10.10.11 255.255.255.255 
gen_context(system_u:object_r:anyname_any_node_t,s0)
nodecon 10.10.10.12 255.255.255.255 
gen_context(system_u:object_r:anyname_any_node_t,s0)

in my wine.te file i've wrote the following:
# Network - SSH
require {
        type node_t;
        class node tcp_recv;
        class tcp_socket { ioctl recv_msg node_bind };
}

#============= wine_t ==============
allow wine_t inaddr_any_node_t:tcp_socket node_bind;
allow wine_t ssh_port_t:tcp_socket name_connect;
allow wine_t newname_any_node_t:node tcp_recv;
allow wine_t node_t:tcp_socket node_bind;
allow wine_t self:tcp_socket ioctl;
allow wine_t ssh_port_t:tcp_socket recv_msg;

In this way i can only build some ssh connections to the defined server from 
the corenetwork.te file. 

I think this is secure enough, because i don't get any receive from other 
addresses. Thats what i want to have. No Connection can be established.

> > > BTW, semanage now supports configuration of node contexts outside of
> > > the base module if you want to try that.
> >
> > I saw that this is a feature of the future releases of semanage. At the
> > moment i use the selinux installation from lenny. If i want to configure
> > the nodes i get the message "node not defined". so i think this feature
> > isnt integreated in this installation. can i use only a newer version of
> > semanage to try the ip limit? or have i to update the whole selinux
> > software?
>
> As I recall, the support already existed in the libraries, so only the
> semanage/seobject.py code had to be updated to fully support defining
> local node contexts.  So you could in theory extract the patch that
> updated semanage and apply that without updating the rest of your
> SELinux userland.  However, in general, we recommend updating all of the
> core SELinux userland together (libsepol, checkpolicy, libselinux,
> libsemanage, policycoreutils).

Ok, thank you for your hint, i would test it in the next round of the selinux 
implementation. Unfortunately i've not enough time to update the selinux on 
this system.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
