Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8DMqUrT006648
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 18:52:31 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8DMpZHC013930
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 22:51:35 GMT
Date: Tue, 14 Sep 2004 00:52:21 +0200
From: Erich Schubert <erich@debian.org>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
Subject: Re: Additional rule files
Message-ID: <20040913225221.GA14736@wintermute.xmldesign.de>
References: <1094260356.29689.44.camel@wintermute.xmldesign.de> <200409052019.20060.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409052019.20060.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(this is a repost since i didn't yet get a reply, and the pptp rules
you currently have included will not work)

Hi,

> I made a few cosmetic changes to pptp.te and also removed a couple of network 
> rules that didn't look right.  Please test the network stuff again and send 
> me an update.  I've put the pptp policy in my tree.

-allow pptpd_t { node_t pptpd_t }:rawip_socket { create_socket_perms
node_bind };
-allow pptpd_t { pptpd_t port_t}:tcp_socket { create_socket_perms
name_bind };

The second should better be replaced by:

----
# pptp port 1723
type pptp_port_t, port_type;
allow pptpd_t pptp_port_t:tcp_socket { create_socket_perms name_bind };

and in net_contexts:
ifdef(`pptp.te', `
portcon tcp 1723  system_u:object_r:pptp_port_t
')
----

As for the first line: The pptp daemon does start then, but when
connecting i get the following error:

audit(1094490089.788:0): avc:  denied  { create } for  pid=3524
exe=/usr/sbin/pptpctrl scontext=system_u:system_r:pptpd_t
tcontext=system_u:system_r:pptpd_t tclass=rawip_socket

pptp is IIRC a kind of GRE tunnel. I guess this rawip_socket permission
is needed for that.

The "tightest" set of permissions i found working is by adding

allow pptpd_t self:rawip_socket { create read write bind connect };
allow pptpd_t node_t:rawip_socket node_bind;

So i think the following should be added:
----
allow pptpd_t self:rawip_socket create_socket_perms;
allow pptpd_t node_t:rawip_socket node_bind;
----

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
       The best things in life are free: Friendship and Love.       //\
       Es gibt kein idiotensicheres Programm, weil Idioten so       V_/_
                     genial sind. -- E. Murphy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
