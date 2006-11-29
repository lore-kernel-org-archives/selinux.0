Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATLl8gv002354
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 16:47:09 -0500
Received: from mail6.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kATLjP46018931
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 21:45:25 GMT
Date: Wed, 29 Nov 2006 16:47:29 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Rename class_destroy to prevent namespace conflicts
In-Reply-To: <1164836098.23019.286.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <XMMS.LNX.4.64.0611291646170.24721@d.namei>
References: <XMMS.LNX.4.64.0611291628410.24574@d.namei>
 <1164836098.23019.286.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 29 Nov 2006, Stephen Smalley wrote:

> > Please review.
> 
> That's fine, although you might want to just add a qualifying prefix to
> those functions, like policydb_ or sel_ or whatever.

Yep -- this seemed to be the least invasive, and adding a prefix just for 
class_destroy would be inconsistent.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
