Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5N0NQrT012852
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 20:23:26 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5N0NEAb013970
	for <selinux@tycho.nsa.gov>; Wed, 23 Jun 2004 00:23:14 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5N0NKJQ022840
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 20:23:20 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i5N0NKSK022838
	for selinux@tycho.nsa.gov; Tue, 22 Jun 2004 20:23:20 -0400
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5MNbirT012628
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 19:37:44 -0400 (EDT)
Received: from cirrus.av8.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5MNbVAb012695
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 23:37:32 GMT
Date: Tue, 22 Jun 2004 19:37:34 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: Colin Walters <walters@verbum.org>
cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: generic pam authentication
In-Reply-To: <1087940480.17038.96.camel@optimus-prime.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0406221926580.13825-100000@cirrus.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


You would need a macro that provides all the capabilities needed by each 
plugin that is (or might be, I guess) in the pam stack.  Each plugin might 
require different capabilities.  

Idealy, what would be nice is to have capabilities for the code that
belongs to shared libraries---so that as long as that code is executing,
it has certain privileges and those privileges go away as soon as the
shared library code returns to the caller.

		--Dean


On Tue, 22 Jun 2004, Colin Walters wrote:

> Hi,
> 
> I'm trying to configure my system to use Kerberos, and I've been hacking
> Kerry Thompson's kerberos.te.  One issue that has seemed common among
> many programs is that they require many additional privileges when
> pam_krb5 is inserted into the stack.  For example, when I use "passwd",
> I get at least:
> 
> allow passwd_t krb5_conf_t:file { getattr };
> allow passwd_t net_conf_t:file { read };
> allow passwd_t passwd_t:udp_socket { create };
> allow passwd_t urandom_device_t:chr_file { read };
> 
> What I think might be nice is a generic macro, say uses_pam(passwd)
> which would grant any privileges necessary to use the libraries in the
> PAM stack.  This macro would be defined in domains/pam.te, and would be
> intended for customization by the administrator.  For example, if the
> administrator decided to use PostgreSQL for holding user data, they
> could insert the necessary privileges to talk to postgresql_port_t.
> 
> Before doing something this invasive, I'd like to see what opinions are.
> 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
