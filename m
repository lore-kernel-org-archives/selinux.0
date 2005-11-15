Message-ID: <4379F431.1070908@redhat.com>
Date: Tue, 15 Nov 2005 09:44:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: rawhide targeted vs. refpolicy rpm
References: <BF9A263D.7FFA%csellers@tresys.com>	 <4374BDEC.4050600@redhat.com> <200511111717.16542.csellers@tresys.com>	 <200511141041.49643.csellers@tresys.com>	 <1131983537.5415.137.camel@moss-spartans.epoch.ncsc.mil>	 <4378B88B.6040003@redhat.com> <4378C285.3080005@tresys.com>	 <4378D6F9.5070301@redhat.com>	 <1131997064.5415.241.camel@moss-spartans.epoch.ncsc.mil>	 <1132053434.5415.269.camel@moss-spartans.epoch.ncsc.mil> <1132062002.5415.350.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1132062002.5415.350.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2005-11-15 at 06:17 -0500, Stephen Smalley wrote:
>   
>> Actually, on second thought, this reflects a bug and possibly design
>> flaw in semanage/sepol, IIUC.  Previously, genhomedircon was using the
>> first role listed in the users files as the "default role" for purposes
>> of labeling the home directory, but that was purely a convention; the
>> kernel policy has no concept of a default role for a user, only a list
>> of authorized roles.  Role and domain selection at login time (or
>> similar events, like su) is performed by dynamically computing the set
>> of contexts reachable for the user from the security context of the
>> entrypoint process (e.g. local login, gdm, sshd, crond, etc) based on
>> policy and then ordering them based on the default_contexts
>> configuration file (which is not part of the kernel policy).
>>
>> Since the kernel policy has no concept of a default role for the user,
>> the user_datum in libsepol merely stores an unordered set of authorized
>> roles; it doesn't preserve the ordering information from the users file
>> at all presently.  The user_to_record() converter function in libsepol
>> merely processes the roles in the order in which they happen to be
>> stored in the ebitmap, which is just a reflection of the bit value
>> ordering of the roles.  Thus, we are returning system_r rather than
>> user_r from sepol to semanage, and propagating that information to
>> genhomedircon.  This is what led Dan to remapping system_r to user_r in
>> his genhomedircon patch.
>>     
>
> So our options would seem to be:
> - Make a change to the module format to explicitly record the "default"
> role when a module is compiled from policy sources, so that libsepol can
> correctly extract the defrole for the user and return it to libsemanage.
> No need to change the kernel format AFAICS, as we only need this support
> for modules, not the expanded policy. -or-
> - Drop the notion of a defrole entirely from the sepol interface and
> code, and handle determination of the default role for users defined in
> the policy in semanage in some manner (possibly paralleling the logic
> used by libselinux to compute the default context, but using the policy
> object rather than the kernel to query reachable contexts, which
> requires encapsulating and exporting the corresponding libsepol
> interface).
>
>   
I would think the latter,  Some logic that takes into account what the 
login program would do. 
Since this also relies on the default_context file, correct?



-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
