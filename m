Subject: RE: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A558718@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7AB835.5080008@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558718@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain
Date: Tue, 16 Feb 2010 14:28:17 -0500
Message-Id: <1266348497.5252.123.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-02-16 at 13:04 -0500, Alan Rouse wrote:
> Dominick, thanks for the reply.   These AVC messages occur during
> normal bootup (not from a command line), so it is the boot process
> which is starting these in the wrong context.  
> 
> OpenSuSE 11.2 is still using System V init startup, but Fedora 12 is
> using upstart.  Perhaps that explains why the recent refpolicy is not
> starting OpenSuse processes in the right context.  Is the current
> refpolicy known to work in System V init -based systems?

Current refpolicy should still work fine for distributions using
sysvinit.  Distributions using upstart have to enable a policy
tunable/boolean.

What build.conf settings are you using?  I expect that the distro_suse
settings are obsolete, as no one has actively maintained support for
SUSE in the upstream policy since Thomas Bleher gave up on maintaining
SUSE SELinux packages.

If you want SELinux to work with SUSE, then:
a) you'll need to at least file bugs in their bugzilla so that they have
some reason to believe anyone cares, and
b) ideally you'll help track down and fix some of the problems and
submit those fixes to them (if the fixes involve changes to system
packages, not just policy changes) or to refpolicy as appropriate.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
