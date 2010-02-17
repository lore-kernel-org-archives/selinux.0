Subject: RE: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A558C14@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <1266413701.4945.3.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C14@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain
Date: Wed, 17 Feb 2010 10:33:49 -0500
Message-Id: <1266420829.4945.100.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-02-17 at 10:14 -0500, Alan Rouse wrote:
> I actually did do a make load but then rebooted so I figured it was an
> unnecessary step. 

With a monolithic policy (MONOLITHIC=y), make install installs the
policy files under /etc/selinux/$SELINUXTYPE and make load loads it into
the kernel, so a make load is unnecessary if you plan to reboot.  With a
modular policy (MONOLITHIC=n), make install installs the modules
under /usr/share/selinux/$SELINUXTYPE and make load runs semodule on
them to actually insert them into your policy store
under /etc/selinux/$SELINUXTYPE/modules and then to generate a kernel
policy image from them.  So you do need the make load in the modular
case.

> It has been my understanding that Novell is not doing any SELinux
> policy development.  The policy package currently in the OpenSuse 11.2
> repository doesn't work, which supports that understanding... As does
> Thomas's recent message on this list.  So I figured I'd need to move
> to the current edition of the reference policy to find active
> development going on, so there would be hope of bug fixes.  In any
> case, the same issues seem to be present in both versions.

Fair enough - I just wanted to ensure that you had in fact tried the
opensuse-provided policy first and confirmed that it didn't work before
moving onto the upstream one.  In the Fedora case, it is often the other
way around due to Fedora policy customizations, where the upstream
refpolicy won't boot cleanly on a Fedora system without some work.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
