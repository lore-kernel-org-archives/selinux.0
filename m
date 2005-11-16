Message-ID: <437B41BF.7030002@cornell.edu>
Date: Wed, 16 Nov 2005 09:27:11 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
   Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: rawhide targeted vs. refpolicy rpm
References: <BF9A263D.7FFA%csellers@tresys.com>	 <200511111717.16542.csellers@tresys.com>	 <200511141041.49643.csellers@tresys.com>	 <1131983537.5415.137.camel@moss-spartans.epoch.ncsc.mil>	 <4378B88B.6040003@redhat.com> <4378C285.3080005@tresys.com>	 <4378D6F9.5070301@redhat.com>	 <1131997064.5415.241.camel@moss-spartans.epoch.ncsc.mil>	 <1132053434.5415.269.camel@moss-spartans.epoch.ncsc.mil>	 <1132062002.5415.350.camel@moss-spartans.epoch.ncsc.mil>	 <4379F431.1070908@redhat.com>	 <1132066658.5415.379.camel@moss-spartans.epoch.ncsc.mil>	 <1132067431.5415.383.camel@moss-spartans.epoch.ncsc.mil>	 <1132067881.5415.391.camel@moss-spartans.epoch.ncsc.mil>	 <1132081420.28124.80.camel@moss-spartans.epoch.ncsc.mil>	 <437A3BFA.1080901@cornell.edu>	 <1132146675.12540.16.camel@moss-spartans.epoch.ncsc.mil>	 <437B374B.8040401@cornell.edu>	 <1132148567.12540.28.camel@moss-spartans.epoch.ncsc.mil>	 <437B3D53.1090401@cornell.edu> <1132150483.3425.9.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1132150483.3425.9.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
>
> Even in semanage, defrole is potentially misleading, as the actual
> default role is context-dependent, e.g. root can be set up to login as
> staff_r by default for ssh logins (so that acquiring sysadm_r access
> requires a further step via newrole or su) while logging in as sysadm_r
> by default for console logins.
>   

Well, okay... I guess it's about as easy to add an arbitrary prefix than 
to use the current defrole functions.
It's probably easier, actually...

So, should this go into a separate file? If it's key-ed on the user, why 
shouldn't it go into the user file?
Also, there's the issue of local vs policy. In-policy users that are not 
in the local file also require a labeling prefix.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
