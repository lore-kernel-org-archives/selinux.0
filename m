Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CGwtIi016920
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 11:58:55 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CGwwgF025361
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 16:58:58 GMT
Subject: Re: transition denied
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: johans@gnu.hu
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1105283615.3146.25.camel@medeia.home.hu>
References: <1105283615.3146.25.camel@medeia.home.hu>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1105548781.22495.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 11:53:01 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-01-09 at 10:13, Milus János wrote:
> I modified the user file:
> 
> user system_u roles { system_r games_r }
> 
> And I added the privovner and privrole attribute to initrc_t domain.
> (but I'm not absolutly sure, that this is necessary)
> 
> What am I miss?

privuser, not privowner.  privuser == ability to transition to other
user identities, privowner == ability to create/relabel files with other
user identities.  Also, games_t needs the userdomain attribute as well
as the domain attribute in order to satisfy the constraint.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
