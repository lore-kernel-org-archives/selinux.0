From: Alan Rouse <alan.rouse@ericsson.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Date: Wed, 17 Feb 2010 10:14:44 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A558C14@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
 <1266413701.4945.3.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266413701.4945.3.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I actually did do a make load but then rebooted so I figured it was an unnecessary step.  

It has been my understanding that Novell is not doing any SELinux policy development.  The policy package currently in the OpenSuse 11.2 repository doesn't work, which supports that understanding... As does Thomas's recent message on this list.  So I figured I'd need to move to the current edition of the reference policy to find active development going on, so there would be hope of bug fixes.  In any case, the same issues seem to be present in both versions.


-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Wednesday, February 17, 2010 8:35 AM
To: Alan Rouse
Cc: 'selinux@tycho.nsa.gov'
Subject: RE: SELinux Policy in OpenSUSE 11.2

On Tue, 2010-02-16 at 16:30 -0500, Alan Rouse wrote:
> I had been trying various things in this image.  So, just to be sure I have a repeatable state, I've rebuilt my system from scratch as follows:
> 
> 1. standard OpenSuse 11.2 install (using Gnome);  boot; start 
> terminal; su - 2.  install packages:
> 
> selinux-tools
> selinux-policy
> libselinux*
> libsemanage*
> policycoreutils 
> checkpolicy   
> make
> m4
> gcc
> findutils-locate
> git
> 
> 3.  add "3 security=selinux selinux=1 enforcing=0" to the grub boot line (boot to runlevel 3 with selinux in permissive mode) and reboot.
> 4.  git clone http://oss.tresys.com/git/refpolicy.git
> 5.  change build.conf:  "DIST = suse"  and "MONOLITHIC = n"
> 6.  make clean; make conf; make; make install-src;

You didn't do a make install or a make load?
Given that you are doing a modular build, you have to do both to actually install the modules and link/expand them to kernel policy.
make install-src isn't needed.

In any event, I would suggest trying to use the OpenSUSE-provided policy first and seeing what issues arise there before you go switching to the upstream refpolicy.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
