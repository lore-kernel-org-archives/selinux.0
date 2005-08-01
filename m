Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@redhat.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
In-Reply-To: <Lynx.SEL.4.62.0507311149080.22444@thoron.boston.redhat.com>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
	 <Lynx.SEL.4.62.0507311149080.22444@thoron.boston.redhat.com>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 09:41:05 -0400
Message-Id: <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-07-31 at 11:59 -0400, James Morris wrote:
> With these patches, on a 64-bit system, after boot:
> 
>   
>             #objs  objsize   kernmem
> Targeted:
>   Before:  237888       40     9.1MB
>   After:    19968       24     468KB
> 
> Strict:
>   Before:  571680       40   21.81MB
>   After:   221052       24    5.06MB

Ok, this along with the data I posted for 32-bit is certainly
encouraging as far as memory savings are concerned.  Things that we need
to resolve before committing/upstreaming these changes include:

- We need to measure the performance impact of the changes on the
kernel, if any, and possibly optimize the compute_av code if it is
measurable.

- We need to write compatibility code for writing out older binary
policy versions from libsepol/checkpolicy for the latest change.  This
is necessary even just to support loading version 19 policies,
since /sbin/init and load_policy regenerate the binary policy image
in-memory when adjusting them for local boolean and user definitions and
thus need that support in policydb_write.

- We need to improve assertion checking time (neverallow rules), as it
is significantly slowed by the lack of an expanded avtab.

- We need to be sure that we are comfortable with collapsing the type
value space and class value space to 16 bits.  That was done by the
first patchset as part of reducing the avtab node size.  The avtab_read
code checks for value truncation when reading older binary policies; we
should also add checks to checkpolicy to ensure that we don't overflow
during policy compilation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
