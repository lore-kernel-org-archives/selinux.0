Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB2N8Y3d022378
	for <selinux@tycho.nsa.gov>; Sat, 2 Dec 2006 18:08:35 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB2N7oIB008612
	for <selinux@tycho.nsa.gov>; Sat, 2 Dec 2006 23:07:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Linda Knippers <linda.knippers@hp.com>
Subject: Re: User home directory creation with useradd (rhbz#217441)
Date: Sun, 3 Dec 2006 10:08:50 +1100
Cc: Joshua Brindle <jbrindle@tresys.com>, James Antill <jantill@redhat.com>,
        selinux@tycho.nsa.gov
References: <6FE441CD9F0C0C479F2D88F959B015885C821F@exchange.columbia.tresys.com> <4571D234.5000207@hp.com>
In-Reply-To: <4571D234.5000207@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612031008.53033.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 03 December 2006 06:21, Linda Knippers <linda.knippers@hp.com> 
wrote:
> Ok, here's another example.  secadm_r can manage policy but can't
> 'touch /.autorelabel', only sysadm_r can do that.

The idea of separating sysadm and secadm fundamentally isn't viable.  The only 
separation is an advisory separation (similar to the way that some security 
people demand that tcpdump not be installed on servers so that sys-admins 
can't sniff data).

The sys-admin needs to be able to perform actions such as running debugfs as 
part of their work.  This permits them ultimate access to the system 
regardless of what SE Linux does.  The sys-admin also needs to be able to 
control the system boot process, and again it gives them ultimate access.

It is quite possible to have a locked-down system that no-one can alter 
without physical dis-assembly - but that does not require limiting the 
sysadm_t domain (in fact it would be better to just not permit any user to 
enter the sysadm_r role).

The sysadm/secadm split is always going to be inconvenient and inconsistent.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
