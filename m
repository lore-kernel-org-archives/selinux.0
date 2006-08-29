Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7TJJls0028409
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 15:19:47 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7TJJSx8022820
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 19:19:28 GMT
Subject: Re: [PATCH 1/3] support for extended range_transitions
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        sds <sds@epoch.ncsc.mil>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <44F318B9.6010303@trustedcs.com>
References: <44F318B9.6010303@trustedcs.com>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 15:19:30 -0400
Message-Id: <1156879170.380.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-08-28 at 11:24 -0500, Darrel Goeddel wrote:
> Introduce support for kernel policy format version 21, base policy format version
> 6, and policy module format 6.  These new formats allow for the definition of
> range_transitions on security classes other than "process".  The new module and
> base formats (both 6) also move expansion of the range_transition statements
> from compile time to the actual expansion phase.  This change should allow for
> using range_transitions in policy modules (with a bit more work in the future)
> with another change in format.
> 
> The current range_transition statements are of the form:
>    range_transition <source types> <target types> <new range>
> These statements affect process transitions only.  The new supported format is:
>    range_transition <source types> <target types>:<target classes> <new range>
> With this format it is possible to to specify a new range for operations such
> as file creation.  The old style statements are still allowed and they
> implicitly refer to the "process" security class, thereby retaining the same
> behavior as before.
> 
> The new kernel format now stores the security class on which the rule operates.
> When dealing with older kernel policy formats, the "process" security class is
> implicit.
> 
> The new module and base formats now store a representation of the rule just (the
> new addition to the avrule_decl structure) and are expanded at the proper time.
> The previous implementation expanded the rules at compilation time and could
> produce an incomplete set of transitions if type attributes were used in the
> statement. 
> Here is how range_transition statements are handled for the various formats:
>  for kernel policy version up to 18, there are no range_transition
>  for kernel policy versions 19 and 20, a list of old-style (no class specified)
>    range_trans structures are encoded
>  for kernel policy versions 21 and up, a list of new-style (class specified)
>    range_trans structures are encoded
> 
>  for base policy versions up to 5, there are no range_transitions
>  for base policy version 5, a compile-time generated list of old-style (no
>    class specified) range_trans structures are encoded as they are in kernel
>    formats 19 and 20
>  for base policy versions 6 and up, an expressive rule stating the intention
>    of the statement is stored - that will be properly linked and expanded
>    for further usage
> 
>  for module policy versions up to 6, there are no range_transitions
>  for base policy versions 6 and up, an expressive rule stating the intention
>    of the statement is stored jut like in base policy version 6 (of course we
>    still need more work to get them in there, but the format is supportive).
> 
>  checkpolicy/module_compiler.c               |   12 ++
>  checkpolicy/module_compiler.h               |    1
>  checkpolicy/policy_parse.y                  |  156 ++++++++++++----------------
>  libsepol/include/sepol/policydb/context.h   |    6 -
>  libsepol/include/sepol/policydb/mls_types.h |   18 +++
>  libsepol/include/sepol/policydb/policydb.h  |   25 +++-
>  libsepol/src/avrule_block.c                 |    1
>  libsepol/src/expand.c                       |  134 ++++++++++++++++++++++--
>  libsepol/src/mls.c                          |   21 +--
>  libsepol/src/policydb.c                     |  117 +++++++++++++++++++--
>  libsepol/src/write.c                        |   68 +++++++++++-
>  11 files changed, 430 insertions(+), 129 deletions(-)
> 

Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

<snip>

> @@ -436,7 +436,9 @@
>                          {if (define_compute_type(AVRULE_CHANGE)) return -1;}
>      			;
>  range_trans_def		: RANGE_TRANSITION names names mls_range_def ';'
> -			{ if (define_range_trans()) return -1; }
> +			{ if (define_range_trans(0)) return -1; }
> +			| RANGE_TRANSITION names names ':' names mls_range_def ';'
> +			{ if (define_range_trans(1)) return -1; }

This is just a note - we use names here and in the avrules for object
classes even though this allows '-' which is not supported. It's not a
big deal (it just results in a confusing error message - e.g., 'unknown
class -'). We should probably clean that up at some point.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
