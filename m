Message-ID: <437278BB.1000607@cornell.edu>
Date: Wed, 09 Nov 2005 17:31:23 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: dwalsh@redhat.com, selinux@tycho.nsa.gov, SELinux-dev@tresys.com
Subject: MLS translations for libsemanage and libsepol
References: <20051109134021.GA27310@europium.cip.ifi.lmu.de>	 <1131544327.20591.474.camel@moss-spartans.epoch.ncsc.mil>	 <1131545169.20591.483.camel@moss-spartans.epoch.ncsc.mil>	 <43721FCE.8050308@cornell.edu> <1131552597.20591.554.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131552597.20591.554.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
>
> seusers is a little unclear; it presently has to use the raw definitions
> because it is only a partial context (just the range), so it isn't going
> through conversion.  GUI for seusers modification would likely apply
> translation itself for presentation to admins.
>   

What's the justification for doing translations in libselinux (the 
library), while placing that responsibility on the caller for 
libsemanage, and sepol. Maybe we should be doing translations for:

- policydb_context_isvalid
- any new functions added to libsepol to check validity and dominance of 
mls ranges (for seusers)
- se[pol/manage]_context_from_string
- se[pol/manage]_context_to_string
- se[pol/manage]_context_get_mls
- se[pol/manage]_context_set_mls
- se[pol/manage]_user_get_mlslevel (?? - are categories supposed to be 
rejected here)
- se[pol/manage]_user_set_mlslevel (?? - are they actually rejected, or 
just ignored..hmm)
- se[pol/manage]_user_get_mlsrange
- se[pol/manage]_user_set_mlsrange
- se[pol/manage]_seuser_get_mlsrange
- se[pol/manage]_seuser_set_mlsrange


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
