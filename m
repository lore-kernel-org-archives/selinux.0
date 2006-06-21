Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5LGvR7M027266
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 12:57:27 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5LGvQsi023020
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 16:57:26 GMT
Date: Wed, 21 Jun 2006 12:57:24 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        kmacmillan@tresys.com
Subject: Re: [PATCH] repost: new sockcreate interface to specify context of
 socket when they are created
In-Reply-To: <Pine.LNX.4.64.0606211221590.10410@d.namei>
Message-ID: <Pine.LNX.4.64.0606211255300.10633@d.namei>
References: <1150902506.27852.35.camel@localhost.localdomain>
 <1150905799.27531.33.camel@moss-spartans.epoch.ncsc.mil>
 <Pine.LNX.4.64.0606211221590.10410@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Btw, we only have room for two permissions now in the process class:

#define PROCESS__SETSOCKCREATE                    0x20000000UL



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
