Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k79E3saA002039
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 10:03:54 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k79E3kFH026831
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 14:03:46 GMT
Subject: Re: What the relationship of "users" file, "rolemap" file,
	"appconfig-strict/seusers" file and so on in Reference policy?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: root <ldm@ercist.iscas.ac.cn>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1155106628.2607.32.camel@localhost.localdomain>
References: <1155106628.2607.32.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 10:03:53 -0400
Message-Id: <1155132233.8722.21.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-09 at 14:57 +0800, root wrote:
> Can anyone tell me what the relationship of the following files?
> 
> policy/users

These are the selinux user identities that are compiled into the policy:

user root roles { sysadm_r staff_r };

> policy/rolemap

This is a mapping between roles, prefixes, and user domains, used for
expanding per-userdomain templates.

These are installed onto the system and are used by selinux-aware
programs:

> config/appconfig-strict/seusers

Linux uid -> selinux identity mapping

> config/appconfig-strict/root_default_contexts
> config/appconfig-strict/default_contexts

Default contexts mainly for login programs.

> config/appconfig-strict/default_type

Default type used in newrole

> I am configuring a port of Reference policy to SEBSD. I configured the
> build.conf use strict policy, make reload, login as root. I got the
> following message:
> 
> Your default context is user_u:sysadm_r:sysadm_t.
> ...:Determining SEBSD label for terminal /dev/ttyv0:Invalid argument

I don't know how the SEBSD internals work, so I can't really help on
this one.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
