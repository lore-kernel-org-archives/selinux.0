Subject: Re: CentOS and SELinux refpolicy trouble
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Filip Bartmann <filbar@centrum.cz>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1164825664.23019.207.camel@moss-spartans.epoch.ncsc.mil>
References: <1164819458.4109.14.camel@localhost>
	 <1164820193.23019.181.camel@moss-spartans.epoch.ncsc.mil>
	 <1164825158.4109.31.camel@localhost>
	 <1164825664.23019.207.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 15:24:24 -0500
Message-Id: <1164831864.7459.7.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-29 at 13:41 -0500, Stephen Smalley wrote:
> On Wed, 2006-11-29 at 19:32 +0100, Filip Bartmann wrote:
> > OUTPUT_POLICY = 18
> > TYPE = targeted
> > NAME = reftargeted
> > DISTRO = rhel4
> > DIRECT_INITRC=y
> > MONOLITHIC=y
> > POLY=n
> > MLS_SENS=16
> > MLS_CATS=256
> > MCS_CATS=256
> > QUIET=n
> 
> Looks fine.
> (aside:  looks like one also has to run make install with
> SETFILES=/usr/sbin/setfiles on RHEL 4 and derivatives)

Yes, thats an unfortunate problem with moving filesystem locations.

> > > Not sure about the booleans errors - what did that booleans file
> > > contain?
> > The booleans file contain default this values(it's almost defaults from
> > tresys refpolicy):
> 
> Hmm...looks like it is generating boolean entries for booleans that are
> only defined in strict policy even though you are building targeted.

This should get better, we've almost completed a branch of the policy
that moves booleans back to modules where it makes sense (the boolean is
only referenced in that module).  It'll be easier to make sure booleans
are around only when the policy uses them.  Hopefully that will be ready
to be merged to trunk very soon.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
