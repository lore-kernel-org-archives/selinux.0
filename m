Message-ID: <437B3D53.1090401@cornell.edu>
Date: Wed, 16 Nov 2005 09:08:19 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
   Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: rawhide targeted vs. refpolicy rpm
References: <BF9A263D.7FFA%csellers@tresys.com>	 <4374BDEC.4050600@redhat.com> <200511111717.16542.csellers@tresys.com>	 <200511141041.49643.csellers@tresys.com>	 <1131983537.5415.137.camel@moss-spartans.epoch.ncsc.mil>	 <4378B88B.6040003@redhat.com> <4378C285.3080005@tresys.com>	 <4378D6F9.5070301@redhat.com>	 <1131997064.5415.241.camel@moss-spartans.epoch.ncsc.mil>	 <1132053434.5415.269.camel@moss-spartans.epoch.ncsc.mil>	 <1132062002.5415.350.camel@moss-spartans.epoch.ncsc.mil>	 <4379F431.1070908@redhat.com>	 <1132066658.5415.379.camel@moss-spartans.epoch.ncsc.mil>	 <1132067431.5415.383.camel@moss-spartans.epoch.ncsc.mil>	 <1132067881.5415.391.camel@moss-spartans.epoch.ncsc.mil>	 <1132081420.28124.80.camel@moss-spartans.epoch.ncsc.mil>	 <437A3BFA.1080901@cornell.edu>	 <1132146675.12540.16.camel@moss-spartans.epoch.ncsc.mil>	 <437B374B.8040401@cornell.edu> <1132148567.12540.28.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1132148567.12540.28.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> One thing I am still not clear about is why we need a labeling prefix 
>> that's not related to a role.. how is targeted using the system role, 
>> and labeling things with the user prefix? Isn't the whole point of the 
>> labeling prefix to prevent that type of thing (cross-role communication).
>>     
>
> Targeted policy has no notion of user roles/domains.  There is
> effectively only one SELinux user identity and role in targeted policy;
> the others are purely for compatibility with strict policy in file
> contexts and application configuration files.  Targeted policy only uses
> TE domains to confine particular processes.
>   
So why don't we label files in targeted as system_home_t, which seems 
more correct and workaround this issue. The only change that seems 
necessary to me is to move the defrole functions from sepol and into 
semanage, since they don't do anything in sepol, and are misleading - 
that would be additive divergence on the semanage side. If the user 
wants to query sepol, and write records into semanage, he/she would have 
to set the default role in addition to the other data.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
