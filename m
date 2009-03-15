Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2FNO2ep025452
	for <selinux@tycho.nsa.gov>; Sun, 15 Mar 2009 19:24:03 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2FNKEX9004831
	for <selinux@tycho.nsa.gov>; Sun, 15 Mar 2009 23:20:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Martin Orr <martin@martinorr.name>
Subject: Re: [refpolicy] dbus/lvm read domain state
Date: Mon, 16 Mar 2009 10:23:38 +1100
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux List <selinux@tycho.nsa.gov>
References: <49BD282F.2050609@martinorr.name>
In-Reply-To: <49BD282F.2050609@martinorr.name>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903161023.45640.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 16 Mar 2009, Martin Orr <martin@martinorr.name> wrote:
> +domain_read_all_domains_state(system_dbusd_t)

Do we really want all domains?  I think it will do to allow system_dbusd_t to 
read all domains that talk to it.

Why not modify dbus_system_bus_client() to have something like the following?
       allow system_dbusd_t $2:dir search;
       allow system_dbusd_t $2:file read_file_perms;

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
