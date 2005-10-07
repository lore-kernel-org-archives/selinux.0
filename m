Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <434699D7.9040307@cornell.edu>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <434699D7.9040307@cornell.edu>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 12:01:47 -0400
Message-Id: <1128700907.1450.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-07 at 11:52 -0400, Ivan Gyurdiev wrote:
> On second thought that code was likely wrong to begin with, since Tresys 
> put their modules in a special package container, and mark everything 
> with a special magic, and use special functions to read everything.... 
> I'll get it fixed later... not testing the direct case yet.
> 
> -    policydb = (policydb_t*) malloc(sizeof(policydb_t));
> -    if (!policydb)
> +    if (sepol_policydb_create(&policydb, SEPOL_POLICY_KERN))
> 
> Why do I get a feeling of deja-vu when I look at this code... :) I think 
> I've already tried this once - I recall Karl convincing me it policydb 
> shouldn't be opaque. Checkpolicy will be confusing to fix. By the way, 
> is it really necessary to specify KERN type in the create() function. I 
> thought you could detect the policy type, and mark it in the policydb 
> object (rather than propagating it down from the caller).

checkpolicy doesn't require changes, other than the updating of the
header file locations to continue using the include/sepol/policydb/*.h
ones (already done in my working copy), and adjusting for the
elimination of a global sepol_set_policyvers() (also already done in my
working copy).  I'm not trying to enable checkpolicy to use the static
libsepol.  I only want to allow libsemanage (and thus its users) to use
the shared libsepol, so that semodule* no longer require the static
libsepol and any new libsemanage-based programs likewise don't require
it.  Fairly pointless to make libsemanage a shared lib if it depends on
a static lib as a backend.  I might also convert audit2why.  Nothing in
policycoreutils should really depend on the static libsepol, IMHO.

With regard to the policy type in the create interface, I was thinking
that sepol_policydb_create should include calling policydb_init, which
presently takes the type and sets it.  However, there isn't any obvious
reason to do that there, so possibly I should drop it from the
policydb_init internal function interface as well, and just let the
type/version be initialized as appropriate elsewhere (policydb_read for
policydb's created from an existing image; expand_module for policydb's
created from module expansion; possibly via separate set functions for
newly constructed ones if we need that support in libsemanage).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
