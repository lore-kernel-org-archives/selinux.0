Subject: Re: [ SEMANAGE ] More work on policy_components.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1129827334.2375.429.camel@moss-spartans.epoch.ncsc.mil>
References: <4356F1B3.3060000@cornell.edu>
	 <1129827334.2375.429.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 13:04:36 -0400
Message-Id: <1129827876.2375.432.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-20 at 12:55 -0400, Stephen Smalley wrote:
> Oops, this one causes memory errors on a semodule -b base.pp (per
> valgrind).

Actually, I think it was introduced by the prior one (interface renaming
et al).  That removed an #if 0 around those calls.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
