Message-ID: <434D6F0D.6090801@tresys.com>
Date: Wed, 12 Oct 2005 16:16:13 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, dwalsh@redhat.com, SELinux-dev@tresys.com,
   Ivan Gyurdiev <ivg2@cornell.edu>
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu>	<1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>	<1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>	<1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>	<1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>	<4346CE4C.1030201@tresys.com>	<1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>	<4346D745.6080203@tresys.com>	<1128716625.1450.96.camel@moss-spartans.epoch.ncsc.mil>	<4346DD70.1070806@tresys.com>	<1129058140.3308.213.camel@moss-spartans.epoch.ncsc.mil>	<434C41D9.7010206@tresys.com>	<1129129084.3308.255.camel@moss-spartans.epoch.ncsc.mil>	<434D2CFB.5040208@tresys.com>	<1129131866.3308.282.camel@moss-spartans.epoch.ncsc.mil>	<434D3792.7020606@tresys.com>	<1129134362.3308.316.camel@moss-spartans.epoch.ncsc.mil>	<434D5097.5060007@tresys.com> <1129146727.26188.77.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129146727.26188.77.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2005-10-12 at 14:06 -0400, Joshua Brindle wrote: 
> 
>>Another idea, instead of downgrading the binary (because of the 
>>possibility of an incompatible downgrade in the future) what about using 
>>the expander in libsepol to build a kernel image from the linked module? 
>>This is basically the same as the libsemanage suggestion but without 
>>using libsemanage.
> 
> 
> "Downgrading" just means setting the desired policy version for the
> binary policy image (via sepol_policydb_set_vers) and then calling
> sepol_policydb_write to write the image to memory or a file.  That is
> what libsemanage already does for expansion after calling
> sepol_expand_module (which merely expands to a policydb, not a binary
> policy image).  The policydb is not versioned in its memory
> representation; it merely carries around a version reflecting its source
> for use in subsequent generation of an image - either the version of the
> original policy image loaded into the policydb via a policydb_read or
> the latest version supported by libsepol when creating a new image via
> expand_module.  So if libsepol doesn't support a "downgrade" of a binary
> policy image to an older version due to incompatibility, it isn't going
> to support expanding to that version either.  It ultimately all comes
> through policydb_write.
> 
This is true assuming policydb_write is always going to do the version 
compatibility. Since that will probably be the case for the foreseeable 
future this is fine.

> Also, libselinux shouldn't be pulling directly from the module store, so
> it would still have some dependency on libsemanage to find that linked
> module file.  At present, libsemanage depends on libselinux and
> libsepol, libselinux depends on libsepol (for load_policy only), and
> libsepol depends on nothing (other than libc, of course).   
> 
Ok, that is true
> 
>>I think downgrading is probably 
>>the best way to do it now.
> 
> 
> I was thinking that the policy pathname could then become versionless,
> but it occurs to me that the version suffix is still useful in allowing
> libselinux to determine the policy version of the file (to decide
> whether a downgrade is required) without needing to parse it, and
> preserving the suffix also lets us unify the loading logic.  So, the
> behavior of libsemanage and libselinux would be as follows:
> - libsemanage always generates the latest policy version supported by
> libsepol (the default), writing it to a versioned policy pathname with
> that version number.  It doesn't use the kernel's policy version at all.
> 
libselinux can do a partial parse to get the version, but this obviously 
isn't as easy as reading the suffix . but this will leave old (albeit 
unused) policies laying around.

it is probably a good idea for libselinux to parse the first few fields 
(magic number, version, etc) anyway before sending an image to the kernel.

> - libselinux always searches for a versioned filename with the highest
> version <= the sepol max, opens and mmaps that file, uses the version
> suffix to determine whether a downgrade is required, and downgrades if
> necessary to the kernel's version.  This same logic applies both for the
> managed case and the unmanaged case.
> 
so, if preserve booleans is on it reads the image, sets the policyvers 
to the kernel version, sets booleans and writes the image, this makes 
sense. If preserve booleans is not on it loads the policy, decides if a 
downgrade is needed and if not sends the image directly to the kernel. 
This sounds optimal for the init case. I'm comfortable with this.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
