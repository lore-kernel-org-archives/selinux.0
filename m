Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <434D3792.7020606@tresys.com>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
	 <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
	 <4346CE4C.1030201@tresys.com>
	 <1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>
	 <4346D745.6080203@tresys.com>
	 <1128716625.1450.96.camel@moss-spartans.epoch.ncsc.mil>
	 <4346DD70.1070806@tresys.com>
	 <1129058140.3308.213.camel@moss-spartans.epoch.ncsc.mil>
	 <434C41D9.7010206@tresys.com>
	 <1129129084.3308.255.camel@moss-spartans.epoch.ncsc.mil>
	 <434D2CFB.5040208@tresys.com>
	 <1129131866.3308.282.camel@moss-spartans.epoch.ncsc.mil>
	 <434D3792.7020606@tresys.com>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 12:26:02 -0400
Message-Id: <1129134362.3308.316.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-12 at 12:19 -0400, Joshua Brindle wrote:
> Now that I think of it this can still lead to a stale policy if one was 
> previously generated but the linked policy was since updated.
> 
> I think that we need to make libsemanage remove all binary policies in 
> the binary policy directory when a new policy is install.

No, we would just be changing the libsemanage and libselinux to generate
and load a binary policy path without any version suffix if we have the
load policy logic automatically downgrade the policy to the kernel
version (whether via libsemanage or via libsepol directly).  The load
policy logic would check first for the versionless file and use it if it
exists (which would indicate use of libsemanage on the system);
otherwise, it would fall through to the existing search for the
versioned file for backward compatibility with non-libsemanage'd
systems.

> The boolean preservation case is a special case, I think we should try 
> to limit binary image mutating as much as possible though.

Boolean preservation requires a policydb_read/write sequence already, so
it only requires setting the policyvers explicitly prior to the
policydb_write to simultaneously downgrade the policy.  Regardless I
think we have to do it in memory at init time, as we shouldn't be
writing to the filesystem at that point (fs is read-only then, right?).

> hrm, should the logic in checkpolicy be moved to libsepol/write.c so 
> that it will always be consistent?

Possibly, but may be irrelevant at this point.

> I know the current versions allow downgrading that shouldn't affect the 
> security properties of the policy but I don't see how it can be 
> guaranteed that this is the case for every future version.

That's a case for keeping the version suffixes and just using the
possibly stale file instead, so that you at least have an internally
consistent policy at every point in time, even if it isn't fully
up-to-date.

>From a compatibility POV, one could argue that booting an old kernel
should use that old policy in order to ensure that the kernel continues
to allow precisely what it used to allow (although that is an argument
for binding policies to kernel versions ala kernel modules and
rebuilding them on every kernel update, dropping the compatibility
support entirely from the kernel as suggested by James a while ago, but
no one seemed to want to bind kernel versions to policy versions).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
