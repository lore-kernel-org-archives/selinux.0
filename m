Subject: Re: Attributes in new binary format
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <42F79427.6020307@tresys.com>
References: <42F7805B.3040607@tresys.com>
	 <1123518614.13654.244.camel@moss-spartans.epoch.ncsc.mil>
	 <42F79427.6020307@tresys.com>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 13:35:26 -0400
Message-Id: <1123522526.13654.305.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-08 at 13:19 -0400, Joshua Brindle wrote:
> No, the hierarchal constraint checker is going to be a standalone 
> verifier that runs during the module verification process.
<snip>
> To do the hierarchal constraint check we walk the avtab, look up the 
> types in the type symtab, find their parents and do avtab lookups to see 
> if the permissions were granted to the parents. Now, after this patch, 
> while walking the avtab, we run into avtab entries with type values not 
> in the type symtab. At that point we'd have to go through every type and 
> build up the same attr->type bitmaps that could just be stored in the 
> binary format since it is already available.

You need to pre-expand the avtab via expand_avtab, just like avtab_write
and check_assertions are doing.  Note that the attribute->type mapping
is built not only upon expansion, but also upon policydb_read (in
libsepol only, not in the kernel). The latter builds an in-memory
attribute->type mapping from the stored type->attribute reverse mapping
for later use by expand_avtab and expand_cond_av_list, because we need
that for performing a policydb_write for an older binary policy version.
I needed that to avoid breaking /sbin/init and load_policy of a
policy.19 file with the new libsepol (upon the genusers/genbools calls,
which pull in the file via policydb_read, mutate it, and then write it
to memory via policydb_write and load the result).  There is some up
front cost to building that mapping and using expand_avtab, but I don't
think it is prohibitive.

> Further, for semodule and policy server, we have some plans to be able 
> to do information flow analysis on the resulting policy to make sure it 
> matches the local security requirements. Having to rebuild attribute 
> maps makes this much slower, and this is when the user is sitting 
> wondering why inserting a 1 line module is taking so long.
> 
> I don't see a good reason not to include this info since it's so useful 
> during the policy verification process.

The information isn't used by the kernel, and I already provided code to
rebuild it upon libsepol's policydb_read, and I haven't seen evidence
that it is prohibitively costly.  Now, if you want to have checkpolicy
emit an additional file with auxiliary data that can be used by
userspace tools, similar to System.map, and have that file installed on
the end systems in a similar manner to System.map, then that may make
sense.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
