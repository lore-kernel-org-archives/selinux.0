Message-ID: <43455A9C.7030901@redhat.com>
Date: Thu, 06 Oct 2005 13:10:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: getseuserbyname patch
References: <43398EB2.1050100@redhat.com>	 <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>	 <433BEB18.7000703@redhat.com>	 <1128006623.27495.70.camel@moss-spartans.epoch.ncsc.mil>	 <433C06F0.3020804@redhat.com>  <433C3C5A.4000104@redhat.com>	 <1128028887.27495.184.camel@moss-spartans.epoch.ncsc.mil>	 <1128354729.26285.137.camel@moss-spartans.epoch.ncsc.mil>	 <1128356967.26285.154.camel@moss-spartans.epoch.ncsc.mil>	 <1128604584.15836.67.camel@moss-spartans.epoch.ncsc.mil>	 <43452647.4050205@redhat.com>	 <1128605898.15836.79.camel@moss-spartans.epoch.ncsc.mil>	 <43452C1F.5070708@redhat.com> <1128617540.15836.141.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128617540.15836.141.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2005-10-06 at 09:52 -0400, Daniel J Walsh wrote:
>   
>> Of course if I can get rid of this file, I can probably muck around with 
>> the config file also.   
>> As long as we don't require the flag and default to old behavior.  For 
>> MLS installs we can
>> put in the flag in the config file and change it to fail if the file is 
>> missing.
>>     
>
> Yes, that was the idea.
>
> BTW, it occurs to me that the cases are different for no seusers.conf
> versus a seusers.conf but no matching entry and no default entry.  The
> latter is more dangerous to allow to default to the old behavior,
> because a simple error in the config file could cause it to skip the
> entry for the user.  Is it unreasonable to always treat no match/no
> default as an error?
>
>   
Ok, I was just thinking the level on no match would be SystemLow, but 
that is not easy to state in policy.
So Force there to be a default/match or return error, is ok.
>> There are files in policy now that are marked config(noreplace) like 
>> local.users, ports, devices etc.  So I don't think this is any 
>> differerent. 
>>     
>
> Yes, I just wasn't sure if you ultimately intend to migrate them out,
> particularly if libsemanage takes over control of all customizations.
> At that point, the files from policy are just pushed into the sandbox
> and all modifications occur within the sandbox and to the generated
> files used at runtime, not directly to any files from the policy
> package.
>
>   
But they still will need to exist and be recompiled into the sandbox 
correct?  I would still consider these files to be policy
specific.  So they would need to be in the policy try. 

BTW:  I would like to rename seusers.conf to seusers and put it in 
/etc/selinux/TYPE/seusers

I also am upping sensitivity level to s15 and category to c255, in the 
latest policy and changing the range lines appropriately.
As proposed by Steve Grubb.

As soon as a libselinux changes show up I will put in patch to 
pam_selinux to allow level selection.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
