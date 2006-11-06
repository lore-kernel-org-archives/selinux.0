Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA6KVOkf012011
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 15:31:25 -0500
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA6KUdiG011149
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 20:30:40 GMT
Date: Mon, 6 Nov 2006 15:31:30 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Chad Sellers <csellers@tresys.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/4] SELinux: export object class and permission definitions
In-Reply-To: <20061106173949.705221428@tresys.com>>
Message-ID: <Pine.LNX.4.64.0611061530270.4553@d.namei>
References: <20061106173814.457967976@tresys.com>> <20061106173949.705221428@tresys.com>>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 6 Nov 2006, Chad Sellers wrote:

> Moves the definition of the 3 structs containing object class and 
> permission definitions from avc.c to avc_ss.h so that the security 
> server can access them for validation on policy load. This also adds a 
> new struct type, defined_classes_perms_t, suitable for allowing the 
> security server to access these data structures from the avc.

Very minor nit, 'defined_classes_perms_t' is now incorrect (don't resend 
just for this).


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
