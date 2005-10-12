Message-ID: <434D3792.7020606@tresys.com>
Date: Wed, 12 Oct 2005 12:19:30 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu>	<1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>	<1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>	<1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>	<1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>	<4346CE4C.1030201@tresys.com>	<1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>	<4346D745.6080203@tresys.com>	<1128716625.1450.96.camel@moss-spartans.epoch.ncsc.mil>	<4346DD70.1070806@tresys.com>	<1129058140.3308.213.camel@moss-spartans.epoch.ncsc.mil>	<434C41D9.7010206@tresys.com>	<1129129084.3308.255.camel@moss-spartans.epoch.ncsc.mil>	<434D2CFB.5040208@tresys.com> <1129131866.3308.282.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129131866.3308.282.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2005-10-12 at 11:34 -0400, Joshua Brindle wrote:
> 
>>Alternatively if an appropriate binary cannot be found one can be 
>>expanded from the linked policy in the module store. This would give a 
>>(hopefully) lossless and current binary policy. It would make startup 
>>slower in the case that a policy can't be found but seems better than 
>>loading a stale policy or none at all.
>>
>>This follows on the theme of not mangling the binary image once it gets 
>>to load_policy/init, which I think is important. If semanage is managing 
>>the policy this should be included in that.
>

Now that I think of it this can still lead to a stale policy if one was 
previously generated but the linked policy was since updated.

I think that we need to make libsemanage remove all binary policies in 
the binary policy directory when a new policy is install.

> 
> I can't quite imagine init invoking libsemanage to generate a policy
> file for it to load.  It would also create a circular dependency between
> libselinux (which now contains all of the load policy logic and thus
> would end up being modified for this purpose) and libsemanage (which
> already depends on libselinux).  
> 
> As for modifying the binary policy image at load time, Karl already
> agreed that the preservation of current boolean settings (in the
> load_policy case, not the init case) has to remain part of that logic.
> So regenerating to a different policy version in memory isn't especially
> different/difficult there.

The boolean preservation case is a special case, I think we should try 
to limit binary image mutating as much as possible though.

> 
> Offhand, I think that the only case where neither libsepol nor
> libsemanage will yield the same policy as checkpolicy if downgrading
> policy versions is the netlink class case, as checkpolicy does
> manipulation during the policy source parsing itself there.  But that
> change occurred circa 2.6.9 and was an unusual use of the version
> mechanism, so it likely isn't much of a concern now.
> 

hrm, should the logic in checkpolicy be moved to libsepol/write.c so 
that it will always be consistent?

I know the current versions allow downgrading that shouldn't affect the 
security properties of the policy but I don't see how it can be 
guaranteed that this is the case for every future version.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
