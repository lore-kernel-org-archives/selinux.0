Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3OGC3I4008826
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 12:12:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3OGBvVf023640
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 16:11:57 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h3OGBu4D023637
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 16:11:56 GMT
Subject: Re: please offer your good advices / new policies: exim, dovecot,
	maradns, (aptitude)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andreas Schuldei <andreas@schuldei.org>
Cc: Peter Gervai <grin@tolna.net>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <20030423201331.GA14673@lukas>
References: <20030423111231.GV3993@narya.grin.hu>
	 <20030423201331.GA14673@lukas>
Content-Type: text/plain
Message-Id: <1051200706.20300.58.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 24 Apr 2003 12:11:46 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-23 at 16:13, Andreas Schuldei wrote:
> yes, that is what i did, too. (i think i asked the same question
> here, too, and never got an answer.)

Since they use a packet socket, they receive every frame, so SELinux is
correctly checking permission.  They may be filtering the packets via a
socket filter after the permission check has been performed.

> i have here collected over time:
> dontaudit dhcpd_t sshd_t:packet_socket { recvfrom };

It would be simpler to do 'dontaudit dhcpd_t domain:packet_socket
recvfrom;' or 'allow dhcpd_t domain:packet_socket recvfrom;'.  Not clear
it is worth denying this access for locally generated packets, when it
is still free to pick up remote ones (and you can't distinguish among
the remote ones except by interface unless you are using the
experimental labeled networking support). 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
