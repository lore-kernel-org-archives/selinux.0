Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9506BrT022595
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 20:06:12 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i95052YE022463
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 00:05:03 GMT
Date: Tue, 5 Oct 2004 01:17:16 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Trent Jaeger <jaegert@us.ibm.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Add a new class
Message-ID: <20041005001716.GA25251@lkcl.net>
References: <OF459C4AF8.918C9B11-ON85256F23.00798D88-85256F23.0079ECBE@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF459C4AF8.918C9B11-ON85256F23.00798D88-85256F23.0079ECBE@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi trent,

as i understand it, it depends on what kind of operation you intend to
add.

for example if it's a new filesystem type, you don't _need_ to add a new
class: selinux is smart enough to pick up the name from the vfs
(superblock?) name, e.g. "fuse" or "proc" and you can add an association
from there.

... but if you're _genuinely_ adding something new such as, oh
i dunno, optimised kernel-level support for Wine win32 calls
where you need to support oh i dunno mmmm the concept of a
NT named pipe because you've written a special authenticated
pipe which can support NT security descriptors, then yes you
would need to add a class...

... along with the corresponding support in the kernel _for_
that type, inside the selinux kernel.

basically it boils down to this:

do you _really_ need to extend the types of operations which selinux can
"vet"

such as oh i dunno:

	"allow openssl_exec_t port_t { add_rsa_key_to_connection }
								   ^^^^^^^^^^^^^^^^^^^^^^^^^

because if so, then the vetting can only be done in the linux kernel,
therefore you have no alternative but to add new stuff (like with the
recent x.org classes) into the selinux security module.

l.

On Mon, Oct 04, 2004 at 06:11:43PM -0400, Trent Jaeger wrote:
> Hi,
> 
> I think this is something I could find in the docs or code, but I don't 
> see it. 
> 
> How do I add a new class?  There are a variety of files in 
> security/selinux/include, such as av_permissions.h, that are 
> "automatically generated", but they are already in the distribution, so it 
> is not clear how they are generated.  If I add a class, operations, etc., 
> these files have to be modified and I would rather do it the proper way.
> 
> BTW -- this is for adding IPSec security associations for classes, so we 
> can label network connections.  Prototype code should be available soon.
> 
> Regards,
> Trent.
> ------------------------------------------------------------
> Trent Jaeger
> IBM T.J. Watson Research Center
> 19 Skyline Drive, Hawthorne, NY 10532
> (914) 784-7225, FAX (914) 784-7225
-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
