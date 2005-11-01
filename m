Subject: Re: [ SEMANAGE ] Fix MLS parsing of users
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <4366F160.2070005@cornell.edu>
References: <4366EE1B.1060303@cornell.edu>  <4366F160.2070005@cornell.edu>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 12:16:36 -0500
Message-Id: <1130865396.22731.203.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-31 at 23:38 -0500, Ivan Gyurdiev wrote:
> By the way, expanding the module (sepol_expand_module) takes an 
> unusually long time to run... commit is very slow (and this is on an 
> Athlon3k computer)....
> 
> 1. Time to modify seuser things: 0.5 sec
> 2. Time to call sepol_expand_module: 9 sec
> 3. Time to merge and commit other policy components, and load the 
> policy: 1 sec
> 
> You can see why I want (2), and most of (3) skipped in the case of 
> seusers...need to add tracking of when the policy is modified.

If you pass a '0' check flag to sepol_expand_module to suppress
assertion and hierarchy checking, it is much faster.   For development,
you can just echo "expand-check = 0" >> /etc/selinux/semanage.conf to
turn it off.  For production, you could make it a flag parameter to
semanage_expand_sandbox rather than just a config setting.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
