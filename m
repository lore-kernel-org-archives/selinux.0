Message-ID: <43580118.1060909@cornell.edu>
Date: Thu, 20 Oct 2005 16:42:00 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEPOL ] Reorganize users.c
References: <4357F5DF.30905@cornell.edu> <1129839038.2375.507.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129839038.2375.507.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I thought delete was going away from sepol, as all local customizations
> outside of policy modules will be add-or-modify or modify-if-exists.  
>   
Hmm, sure we can get rid of delete...
> For genusers, we processed both system.users (generated from the policy
> users file) and local.users, marking each user in the policydb as
> defined if it had an entry in either of those files, and then (if
> delusers was enabled) purged users that had no definition at all in the
> flat files.  Hence, you could remove a user by modifying a flat file.
> However, as that was viewed as too dangerous (risk of losing your
> system_u, user_u, and root entries), it was disabled by default.
>   
Where do you set defined = 0 ? Calloc?
What's the benefit of this - should we remove this function (and the 
corresponding policydb field)?
(or are you thinking of adding a preserve users flag to load_policy ? )

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
