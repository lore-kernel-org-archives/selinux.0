Subject: Re: Mls data structure, Seusers...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, SELinux-dev@tresys.com
In-Reply-To: <43764DDE.1060503@cornell.edu>
References: <43764DDE.1060503@cornell.edu>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 08:58:48 -0500
Message-Id: <1131976728.5415.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-11-12 at 15:17 -0500, Ivan Gyurdiev wrote:
> Anyway, to get to the point of this email... I originally chose to 
> represent MLS data in user/seuser/context objects as a string, rather 
> than a structure. That might have been a mistake, so I raise this issue 
> again - is a string acceptable? It's important to clarify this, because 
> it affects the interface, and also matters for future functions which I 
> plan to write that allow libsemanage to validate seuser mls fields.

I think using a string for the MLS data is fine.  I see no gain from
further data hiding beyond that level.

> By the way, I am assuming that the way this will be done is by 
> introducing (shared) interfaces to deal with mls ranges/levels. An 
> alternative approach is to make sepol learn about seusers (by moving the 
> seuser record into sepol), and dealing with this higher-level object, 
> rather than the mls range directly. However, there's no reason to move 
> the seuser record into sepol, other than for validation - seusers are 
> not loaded into policy.

I don't think we want to move in that direction; seuser records should
not be a sepol abstraction at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
