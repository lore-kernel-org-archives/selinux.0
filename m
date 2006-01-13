Subject: Re: [SEMANAGE] User extra data (part 1)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43C34AAE.1060908@cornell.edu>
References: <43C33ECB.2020608@cornell.edu>  <43C34AAE.1060908@cornell.edu>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 08:50:55 -0500
Message-Id: <1137160255.3445.118.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-01-09 at 22:48 -0700, Ivan Gyurdiev wrote:
> Bugfix for modified flags attached. I need to write support for re-using 
> the linked policy from the last run - none of the file backed components 
> needs to relink every time. Otherwise those modified flags aren't very 
> useful - they only do something for the case of active booleans (prevent 
> overwrite by policy booleans).

Merged the patch and bugfix as of libsemanage 1.5.12.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
