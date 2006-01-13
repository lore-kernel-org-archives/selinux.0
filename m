Subject: Re: [SEMANAGE] Cleanups after add/set removal
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43C62D3A.1050607@cornell.edu>
References: <43C62D3A.1050607@cornell.edu>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 08:52:25 -0500
Message-Id: <1137160345.3445.124.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-12 at 03:19 -0700, Ivan Gyurdiev wrote:
> This patch removes dead code - add/set functions in ports_local, and add 
> entrypoint in database.c.
> Secondly it removes the check for duplicates in the remaining (internal) 
> copy of add, which we will use for internal purposes.

Merged as of libsemanage 1.5.12.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
