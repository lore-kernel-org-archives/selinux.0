Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5RKYlPh025093
	for <selinux@tycho.nsa.gov>; Tue, 27 Jun 2006 16:34:48 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5RKYjC8010799
	for <selinux@tycho.nsa.gov>; Tue, 27 Jun 2006 20:34:46 GMT
Date: Tue, 27 Jun 2006 16:34:44 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: David Quigley <dpquigl@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 1/3] security:  Extend task_kill hook to handle signals
 sent by AIO completion
In-Reply-To: <1151438496.1294.7.camel@moss-terrapins.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0606271625540.3759@d.namei>
References: <1151438496.1294.7.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Jun 2006, David Quigley wrote:

> + * @task_getsecurityid:
> + *	Retrieve the security identifier of the process @p.
> + *	@p contains the task_struct for the process and place is into @sid.

As long as still LSM exists, we need to avoid SELinux-specific code in the 
core kernel security framework.  This needs to be reworked to use some 
kind of abstract security field.


(Unfortunately, some has crept into Netlink and xfrm hooks, too, and these 
need to be fixed soon.  The audit code also looks like it's been 
accumulating SELinux-specific code as well).


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
