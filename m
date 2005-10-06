Message-ID: <43452C1F.5070708@redhat.com>
Date: Thu, 06 Oct 2005 09:52:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: getseuserbyname patch
References: <43398EB2.1050100@redhat.com>	 <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>	 <433BEB18.7000703@redhat.com>	 <1128006623.27495.70.camel@moss-spartans.epoch.ncsc.mil>	 <433C06F0.3020804@redhat.com>  <433C3C5A.4000104@redhat.com>	 <1128028887.27495.184.camel@moss-spartans.epoch.ncsc.mil>	 <1128354729.26285.137.camel@moss-spartans.epoch.ncsc.mil>	 <1128356967.26285.154.camel@moss-spartans.epoch.ncsc.mil>	 <1128604584.15836.67.camel@moss-spartans.epoch.ncsc.mil>	 <43452647.4050205@redhat.com> <1128605898.15836.79.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128605898.15836.79.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2005-10-06 at 09:27 -0400, Daniel J Walsh wrote:
>   
>> A couple of things I was thinking about.  
>>
>> 1.  The call should be to just return the username and level "" if the 
>> file does not exist or if there is not default value and no match.  So 
>> the only time the call would return an error was if no memory.
>>     
>
> The problem with always doing this is that it could lead to insecurity,
> e.g. accidental (or malicious) removal of seusers.conf or filesystem
> corruption could end up allowing the user to login with a much greater
> level of access than desired, because we will be using seusers.conf to
> control the authorized categories for individual Linux users rather than
> the kernel policy.  That's why I suggested making it a configurable
> setting in /etc/selinux/config, so that we have the option of treating
> it as an error condition that prevents login rather than falling back.
> For MCS or MLS, I think we would actually want to make it an error
> condition and require the presence of seusers.conf and a default entry.
> For existing systems (e.g. FC4) and any system that doesn't want/need a
> separate user mapping, we'd leave it as a non-error condition so that
> nothing breaks there.  Note btw that it is *level = NULL that we want,
> so that get_ordered_context_with_level and
> get_default_context_with_level fall back to the ordinary functions.
>
>   
Of course if I can get rid of this file, I can probably muck around with 
the config file also.   
As long as we don't require the flag and default to old behavior.  For 
MLS installs we can
put in the flag in the config file and change it to fail if the file is 
missing.
>> 2. The file should be put into a policy specific directories and be 
>> shipped with the policy.  When we move to LDAP, we will require a policy 
>> type in the key for retrieving users.  This way we can continue to allow 
>> users to switch from one type of policy to another.
>>     
>
> That's ok, as long as you are fine with the notion that some files in
> the policy package can be customized by the user.  If you want the
> policy package to ultimately become "pristine" files shipped by the
> distributor and keep all user customizations separate, then it seems
> like it needs to go in a separate package, much as /etc/passwd et al are
> in their own special setup package.  It would be nice if ultimately rpm
> -V selinux-policy-targeted (or strict) would report no changes from mere
> local customizations.
>
>   
There are files in policy now that are marked config(noreplace) like 
local.users, ports, devices etc.  So I don't think this is any 
differerent. 

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
