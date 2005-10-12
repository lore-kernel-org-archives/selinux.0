Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com, SELinux-dev@tresys.com,
   Ivan Gyurdiev <ivg2@cornell.edu>
In-Reply-To: <1129146727.26188.77.camel@moss-spartans.epoch.ncsc.mil>
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
Content-Type: text/plain
Date: Wed, 12 Oct 2005 16:11:29 -0400
Message-Id: <1129147889.26188.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-12 at 15:52 -0400, Stephen Smalley wrote:
> - libsemanage always generates the latest policy version supported by
> libsepol (the default), writing it to a versioned policy pathname with
> that version number.  It doesn't use the kernel's policy version at all.
> 
> - libselinux always searches for a versioned filename with the highest
> version <= the sepol max, opens and mmaps that file, uses the version
> suffix to determine whether a downgrade is required, and downgrades if
> necessary to the kernel's version.  This same logic applies both for the
> managed case and the unmanaged case.

And, if the downgrade fails, libselinux keeps searching for a lower
versioned filename until it finds one that can be downgraded or it finds
one that doesn't need a downgrade (i.e. already at or below the kernel's
version) or it passes the libsepol min (in which case it will just
fail).  That provides the fallback case for incompatible changes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
