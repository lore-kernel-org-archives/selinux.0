Subject: Re: [SEMANAGE] Rename seuser -> seuser_local
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <SELinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43D1737F.6010002@cornell.edu>
References: <43D1737F.6010002@cornell.edu>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 15:52:55 -0500
Message-Id: <1138395175.13075.407.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-20 at 16:34 -0700, Ivan Gyurdiev wrote:
> Seuser functions and dbase have incorrect names, since originally I did 
> not think we'd have seusers.system. I must have asked about this, but 
> regardless, I now think that a systems file will likely be necessary, so 
> this patch renames all seuser-related things to _local, which leaves 
> space for a _policy set of functions. It updates dependencies and 
> manpages. This is an API change.

Merged as of libsemanage 1.5.18 and policycoreutils 1.29.14.

> I think we should add users_extra.system and seusers.system into the 
> package format.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
