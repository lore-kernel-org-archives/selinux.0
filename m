Subject: Re: [ SEMANAGE ] Cleanup : move some things around
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov
In-Reply-To: <436F811C.1010306@tresys.com>
References: <436DDB51.2080903@cornell.edu>
	 <1131377599.20591.32.camel@moss-spartans.epoch.ncsc.mil>
	 <436F7F36.5080308@cornell.edu>
	 <1131379914.20591.70.camel@moss-spartans.epoch.ncsc.mil>
	 <436F811C.1010306@tresys.com>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 11:31:29 -0500
Message-Id: <1131381089.20591.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-07 at 11:30 -0500, Joshua Brindle wrote:
> Please see my other email about the semanage_set_reload_bools() patch, I 
>   believe it is flawed in a couple ways and should be reverted.

I saw it, but:
a) it is functional, and we do need this functionality for using
setsebool with libsemanage, so until I have an alternate implementation,
I'm not likely to discard it, and
b) it isn't clear why one wants to be generating the argument array at
load time (with the potential for failure there) rather than when the
caller sets the desired property.

I viewed the question of whether we should be loading policy or using
security_set_boolean_list as orthogonal to how one goes about setting
the -b argument; the former can be addressed by a separate patch (hint,
hint).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
