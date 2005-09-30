Message-ID: <433CB578.6070303@cornell.edu>
Date: Thu, 29 Sep 2005 23:48:08 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux-dev@tresys.com
Subject: Re: [RFC][PATCH] New interface for loading policy
References: <1128028816.27495.182.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128028816.27495.182.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Comments?
>
>  
>
It doesn't belong in libselinux. I've had an implementation of this for 
a long time, but I haven't submitted it, because we're changing the plan 
(right). Boolean and user components will be handled by semanage, using 
the dbase thing which I'm adding there. Genbools/genusers will be 
deprecated. Semanage will compile a module, and put users/booleans into 
that. Then it will re-link modules upon change, and load_policy will ... 
load the policy.

OTOH this may be a good way to get rid of this code from things like 
init, which needs to happen anyway...

P.S. Dan - please take a look at my mail that says that (1) gdm is 
broken, because it doesn't pay attention to enforcing mode, and (2) MCS 
is not transparent upon install if you have defined users in local.users 
(those are rejected post-mcs). Combined those two things prevent you 
from logging in in *permissive* mode.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
