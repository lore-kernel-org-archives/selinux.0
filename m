Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7MEFjrT013253
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 10:15:45 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7MEFiV1007684
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 14:15:44 GMT
Subject: Re: dbus policy
From: Colin Walters <walters@verbum.org>
To: russell@coker.com.au
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200408222241.55215.russell@coker.com.au>
References: <200408222241.55215.russell@coker.com.au>
Content-Type: text/plain
Date: Sun, 22 Aug 2004 10:16:22 -0400
Message-Id: <1093184182.2561.1.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-08-22 at 22:41 +1000, Russell Coker wrote:
> The attached patch grants dbusd_t full access to dbusd_var_run_t (no reason 
> why it shouldn't).
>
> Adds ifdef(`pamconsole.te', to prevent compilation errors if you don't include 
> pamconsole.te.
> 
> Allows dbus clients to search /var/run (can't access dbus otherwise).
> 
> It also adds the below line which may be controversial.  I believe that any 
> domain which is a dbus client will need to send dbus messages to itself and 
> there is no benefit in denying it.  Colin, as the expert in this area please 
> let me know what you think.  Steve, you may consider not applying the last 
> part of this patch unless you receive positive feedback from Colain.
> 
> allow { dbus_client_domain userdomain } { dbusd_t self }:dbus { send_msg };

This all looks good to me.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
