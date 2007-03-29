Subject: Re: "HASHTAB_OVERFLOW" undeclared
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ken YANG <spng.yang@gmail.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <460B2925.1080403@gmail.com>
References: <460B2925.1080403@gmail.com>
Content-Type: text/plain
Date: Thu, 29 Mar 2007 07:06:51 -0400
Message-Id: <1175166411.3864.504.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-29 at 10:49 +0800, Ken YANG wrote:
> 
> i want to use findcon to find a type "tmpfs_t".
> but in FC, there is setools* package contaning findcon.
> i find that secmds(findcon) is in setools-console subpackage
> why fc has not this subpackage?

That's a question for Dan Walsh (cc'd above) or fedora-selinux-list.

> i down a setools-3.1-1.src.rpm from tresys site, and encounter
> a build error:
> 
> policy_extend.c: In function 'qpol_policy_build_attrs_from_map':
> policy_extend.c:170: error: 'HASHTAB_OVERFLOW' undeclared (first use in 
> this function)
> policy_extend.c:170: error: (Each undeclared identifier is reported only 
> once
> policy_extend.c:170: error: for each function it appears in.)
> policy_extend.c: In function 'qpol_policy_fill_attr_holes':
> policy_extend.c:246: error: 'HASHTAB_OVERFLOW' undeclared (first use in 
> this function)
> make[4]: *** [policy_extend.o] Error 1
> make[4]: Leaving directory 
> `/workbench/rpmbuild/BUILD/setools-3.1/libqpol/src'
> 
> 
> i have not find "HASHTAB_OVERFLOW" in selinux trunk, especially in
> libsepol. where is this symbol defined?

Those error codes were replaced by standard ones
(include/sepol/errcodes.h) in the trunk version of libsepol, so you
would need to build setools against the stable branch version of
libsepol until they update setools.

> by the way, i want checkout setools and try again, but tresys "open
> source project" site can not access, maybe is temporary :-)

Appears to be up now.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
