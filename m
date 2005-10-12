Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com, SELinux-dev@tresys.com,
   Ivan Gyurdiev <ivg2@cornell.edu>
In-Reply-To: <434D6F0D.6090801@tresys.com>
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
	 <1129134362.3308.316.camel@moss-spartans.epoch.ncsc.mil>
	 <434D5097.5060007@tresys.com>
	 <1129146727.26188.77.camel@moss-spartans.epoch.ncsc.mil>
	 <434D6F0D.6090801@tresys.com>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 16:43:13 -0400
Message-Id: <1129149793.26188.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-12 at 16:16 -0400, Joshua Brindle wrote:
> libselinux can do a partial parse to get the version, but this obviously 
> isn't as easy as reading the suffix . but this will leave old (albeit 
> unused) policies laying around.

I viewed those files as the fallback position for incompatible policy
changes, i.e. when downgrade isn't supported from the latest file,
search the older files until you find one that can be downgraded or that
doesn't require downgrading.  Yes, it may be stale, but it may be your
only option for booting the system with that older kernel.

> it is probably a good idea for libselinux to parse the first few fields 
> (magic number, version, etc) anyway before sending an image to the kernel.

libsepol could provide an interface for just parsing the header and
extracting the version, but I'm not sure why libselinux would want to do
this (unless using versionless policy pathnames where we need it to
determine the version).  The kernel will check that information anyway
and reject the load attempt if it is invalid.

> so, if preserve booleans is on it reads the image, sets the policyvers 
> to the kernel version, sets booleans and writes the image, this makes 
> sense. If preserve booleans is not on it loads the policy, decides if a 
> downgrade is needed and if not sends the image directly to the kernel. 
> This sounds optimal for the init case. I'm comfortable with this.

In the short term, this logic will likely just precede the existing
genbools_array logic, so that all version selection and downgrading
happens first, and then genbools_array just operates on the resulting
(potentially downgraded) image.  Longer term, we'll likely want the
genbools interface revised so that we can avoid the multiple
policydb_read/write sequences when a downgrade is needed and boolean
preservation is enabled, but that is just an efficiency concern.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
