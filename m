Subject: Re: [ SEPOL 3 ] Fix MLS memory leaks: interfaces/ports/users
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <435F0EC9.5010407@cornell.edu>
References: <435F0EC9.5010407@cornell.edu>
Content-Type: text/plain
Date: Wed, 26 Oct 2005 09:33:18 -0400
Message-Id: <1130333598.17609.500.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-26 at 01:06 -0400, Ivan Gyurdiev wrote:
> This fixes the tricky memory leaks that I've been trying to find...
> There are no more sepol leaks that I'm aware of at the moment.

All 5 patches (sepol/semanage debug, sepol debug2, semanage seusers,
semaange policydb cache, sepol fix leaks) merged as of libsepol 1.9.31
and libsemanage 1.3.35.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
