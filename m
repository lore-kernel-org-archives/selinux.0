Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i94FDwrT018412
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 11:13:59 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i94FDws6014689
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 15:13:58 GMT
Subject: Re: Role questions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Artur M. Piwko" <pipen@pu.kielce.pl>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <41517FA8.7050207@pu.kielce.pl>
References: <41517FA8.7050207@pu.kielce.pl>
Content-Type: text/plain
Message-Id: <1096902648.32008.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 04 Oct 2004 11:10:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-22 at 09:35, Artur M. Piwko wrote:
> 1. When I su - from myuser:staff_r:staff_t to root I'm still myuser,
>     instead of root:staff_r:staff_t. What I did wrong?
> 2. How can one set up initial sysadm_r password? All i see is:
> 
> # newrole -r sysadm_r
> Authenticating myuser.
> newrole: incorrect password for myser

What distribution are you using as your base?  In Fedora, su uses
pam_selinux and thus changes the SELinux user identity as well.  In
other distros, su typically only changes the Linux user identity and
leaves the SELinux user identity unchanged.

newrole just re-authenticates the current user, and the policy governs
whether or not the current user is authorized for the new role via
policy/users.  The password authentication is not to authorize entrance
into the role; it just acts as a primitive form of user confirmation to
reduce the risk of malicious code changing roles without the user's
consent/awareness.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
