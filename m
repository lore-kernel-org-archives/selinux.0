Message-ID: <434D5097.5060007@tresys.com>
Date: Wed, 12 Oct 2005 14:06:15 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu>	<1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>	<1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>	<1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>	<1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>	<4346CE4C.1030201@tresys.com>	<1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>	<4346D745.6080203@tresys.com>	<1128716625.1450.96.camel@moss-spartans.epoch.ncsc.mil>	<4346DD70.1070806@tresys.com>	<1129058140.3308.213.camel@moss-spartans.epoch.ncsc.mil>	<434C41D9.7010206@tresys.com>	<1129129084.3308.255.camel@moss-spartans.epoch.ncsc.mil>	<434D2CFB.5040208@tresys.com>	<1129131866.3308.282.camel@moss-spartans.epoch.ncsc.mil>	<434D3792.7020606@tresys.com> <1129134362.3308.316.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129134362.3308.316.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2005-10-12 at 12:19 -0400, Joshua Brindle wrote:
> 
>>Now that I think of it this can still lead to a stale policy if one was 
>>previously generated but the linked policy was since updated.
>>
>>I think that we need to make libsemanage remove all binary policies in 
>>the binary policy directory when a new policy is install.
> 
> 
> No, we would just be changing the libsemanage and libselinux to generate
> and load a binary policy path without any version suffix if we have the
> load policy logic automatically downgrade the policy to the kernel
> version (whether via libsemanage or via libsepol directly).  The load
> policy logic would check first for the versionless file and use it if it
> exists (which would indicate use of libsemanage on the system);
> otherwise, it would fall through to the existing search for the
> versioned file for backward compatibility with non-libsemanage'd
> systems.
> 
Another idea, instead of downgrading the binary (because of the 
possibility of an incompatible downgrade in the future) what about using 
the expander in libsepol to build a kernel image from the linked module? 
This is basically the same as the libsemanage suggestion but without 
using libsemanage.

This seems to be getting fairly complicated, expanding a module 
(possibly) at boot time but stale or no policy, again, seems worse.

This also introduces more error conditions and something else would have 
to be done for unmanaged systems but in the long run this should 
guarantee that the policy is current and the kernel gets the version it 
needs, whether it was previously built or not.

OTOH, downgrading will probably work fine for now since there is 
compatibility and since the loading (and thus downgrading) will be 
encapsulated if there is ever a non-compatible policy version it can be 
switched to expanding the linked module. I think downgrading is probably 
the best way to do it now.

> 
>>The boolean preservation case is a special case, I think we should try 
>>to limit binary image mutating as much as possible though.
> 
> 
> Boolean preservation requires a policydb_read/write sequence already, so
> it only requires setting the policyvers explicitly prior to the
> policydb_write to simultaneously downgrade the policy.  Regardless I
> think we have to do it in memory at init time, as we shouldn't be
> writing to the filesystem at that point (fs is read-only then, right?).
> 
Right, and in the init case it would have to expand the module in memory 
and use that without writing to disk, this causes the situation where 
the latest policy version is never written to disk and the policy is 
re-expanded on every boot, which is not desirable.

Also, in the downgrade case, since init does not preserve booleans it 
doesn't have a need to read/write the image and could get away with 
loading the image straight off disk if an appropriate one is found, 
otherwise it will have to downgrade in memory.

> 
>>hrm, should the logic in checkpolicy be moved to libsepol/write.c so 
>>that it will always be consistent?
> 
> 
> Possibly, but may be irrelevant at this point.
> 
> 
>>I know the current versions allow downgrading that shouldn't affect the 
>>security properties of the policy but I don't see how it can be 
>>guaranteed that this is the case for every future version.
> 
> 
> That's a case for keeping the version suffixes and just using the
> possibly stale file instead, so that you at least have an internally
> consistent policy at every point in time, even if it isn't fully
> up-to-date.
> 
Expanding the linked policy could address this, ideally the module 
format should be able to support any binary version supported by libsepol.

>>From a compatibility POV, one could argue that booting an old kernel
> should use that old policy in order to ensure that the kernel continues
> to allow precisely what it used to allow (although that is an argument
> for binding policies to kernel versions ala kernel modules and
> rebuilding them on every kernel update, dropping the compatibility
> support entirely from the kernel as suggested by James a while ago, but
> no one seemed to want to bind kernel versions to policy versions).
> 

If policy updates have occured it is possible that the filesystem is not 
  labeled the same way, and could have invalid labels.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
