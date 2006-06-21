Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5LFbjW2025363
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 11:37:46 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5LFbisi012936
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 15:37:44 GMT
Date: Wed, 21 Jun 2006 11:37:40 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
cc: selinux@tycho.nsa.gov, kmacmillan@tresys.com, sds@tycho.nsa.gov
Subject: Re: [PATCH] repost: new sockcreate interface to specify context of
 socket when they are created
In-Reply-To: <1150902506.27852.35.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606211135140.10057@d.namei>
References: <1150902506.27852.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 21 Jun 2006, Eric Paris wrote:

>     S_(SECCLASS_PROCESS, PROCESS__SETEXEC, "setexec")
>     S_(SECCLASS_PROCESS, PROCESS__SETFSCREATE, "setfscreate")
> +   S_(SECCLASS_PROCESS, PROCESS__SETSOCKCREATE, "setsockcreate")

Did you manually place this here, or was it done by mkaccess_vector.sh in 
the policy package?


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
