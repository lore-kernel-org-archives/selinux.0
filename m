Subject: Re: libselinux patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <305125.10227.qm@web51504.mail.yahoo.com>
References: <305125.10227.qm@web51504.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 22 Feb 2007 09:10:17 -0500
Message-Id: <1172153417.14363.360.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-22 at 05:46 -0800, Steve G wrote:
> >That was intentional; likely should add a comment.
> 
> OK, explanation makes sense. I'll add a comment to the patch.
> 
> >Patch looks basically sane;
> 
> Something else I was thinking about. When the library starts up, it checks for
> the mounts then it checks for enabled. Would there be any situation where an
> selinuxfs would be mounted and selinux is considered disabled? If not, we can
> short circuit the redundant check for /selinux and assume that if selinux_mnt !=
> NULL then selinux is enabled. Does this make sense?

Yes.

> >- SELINUX_MAGIC doesn't need to be exposed outside of the library, so
> >I'd put it into src/policy.h too instead of a public header.
> 
> I have a feeling that people want this. Almost all filesystems have the magic
> exposed or well known. SELINUX_MAGIC isn't even listed in statfs man page while
> most other filesystems are. If you search /usr/include for SELINUX_MAGIC, you'll
> find it defined in:
> 
> /usr/include/sepol/policydb/flask_types.h

There it is used as a magic number in the binary policy file.  Note btw
that sepol/policydb headers aren't part of the shared library interface,
just the static library.

> So, why not have a definition in libselinux and let other subsystems use it?

If a program actually needed the value for some purpose, I'd rather wrap
that in a libselinux interface in some manner rather than directly
expose the value as a fixed definition.   I also think that the
superblock magic number is somewhat meaningless for pseudo filesystems
like selinuxfs, and there isn't any real guarantee of uniqueness.

> >- Why u_int32_t instead of just long (per the statfs man page)?
> 
> SELINUX_MAGIC is 0xf97cff8c and the upper bit is 1, so it gets sign extended in
> 64 bit kernels. Then the direct comparison fails. No other MAGIC has a 1 in the
> upper bit so selinux is unique in that way. Try this little program and you'll
> see:

Hmm...well, (unsigned long) would seem adequate then.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
