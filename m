Message-ID: <1343680740.2346.196.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Questions about the following denials
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Mon, 30 Jul 2012 16:39:00 -0400
In-Reply-To: <CAO-4OdF4Kyt7Cg8-9zkb4zY4HdcK=Vg-M-mXm4nNgA03mVrKcA@mail.gmail.com>
References: 
	<CAO-4OdF4Kyt7Cg8-9zkb4zY4HdcK=Vg-M-mXm4nNgA03mVrKcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-30 at 13:11 -0700, Haiqing Jiang wrote:
> Hi, Stephen,
> 
> 
> Could you give me some suggestions for the understanding the denials
> as shown below?
> 
> 
> #============= release_app ==============
> allow release_app zygote:netlink_selinux_socket getattr;
> 
> <5>[13011.539764] type=1400 audit(1343515886.695:592): avc:  denied
> { getattr } for  pid=10278 comm="ationTestRunner" path="socket:[1516]"
> dev=sockfs ino=1516 scontext=u:r:release_app:s0 tcontext=u:r:zygote:s0
> tclass=netlink_selinux_socket

Just dontaudit it.  No need for the app to be able to use a
NETLINK_SELINUX socket.

> #============= untrusted_app ==============
> allow untrusted_app self:netlink_route_socket create;
> 
> <5>[13900.251708] type=1400 audit(1343516775.406:801): avc:  denied
>  { create } for  pid=15089 comm="WebViewCoreThre"
> scontext=u:r:untrusted_app:s0:c39 tcontext=u:r:untrusted_app:s0:c39
> tclass=netlink_route_socket

Might be required for some apps; should be added under app_network
boolean, as:
# Get route information.
allow untrusted_app self:netlink_route_socket { create bind read
nlmsg_read };


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
