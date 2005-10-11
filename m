Message-ID: <434BD63B.7020003@cornell.edu>
Date: Tue, 11 Oct 2005 11:11:55 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: [ SEPOL ] Another debugging system
References: <434B62B8.4080309@cornell.edu>  <434B7FF2.2090306@cornell.edu> <1129041930.3308.137.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129041930.3308.137.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> - Same comments apply as for the semanage patch.
>   
Allright, I'll redo both of those patches for tomorrow (no time today).
Thanks for the comments.
> - Yes, sepol.h should likely include all external API sepol headers, and
> the current interfaces in sepol.h should likely be moved to separate
> headers that are then included.
>   
Will change that in a later patch..

> - We'll need to preserve versions of the old sepol.h interfaces without
> handles for backward compatibility, since there have been official
> releases with those interfaces.  Some of those interfaces will be
> obsoleted (genusers/genbools) but others will continue to be used
> (genbools_array for load_policy, set_policydb_from_file and
> check_context for setfiles -c).
>   
I'm confused - what's the difference between an "old" interface that has 
a corresponding "new" interface... and an obsoleted interface. Seems 
like the same thing to me. Yes, we'll need need to preserve 
compatibility until all users are fixed, and then we can get rid of the 
old interfaces..right?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
