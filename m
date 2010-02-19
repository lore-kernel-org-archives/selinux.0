Subject: RE: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E316AFB7@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7C47DB.40602@gmail.com>
	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780280@EUSAACMS0703.eamcs.ericsson.se>
	 <1266437939.4945.132.camel@moss-pluto.epoch.ncsc.mil>
	 <1266438301.4945.134.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A7802A0@EUSAACMS0703.eamcs.ericsson.se>
	 <1266438910.4945.137.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A7802D6@EUSAACMS0703.eamcs.ericsson.se>
	 <1266440973.4945.142.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780310@EUSAACMS0703.eamcs.ericsson.se>
	 <1266442158.4945.144.camel@moss-pluto.epoch.ncsc.mil>
	 <1266442637.4945.147.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78036F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266508987.21209.45.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780863@EUSAACMS0703.eamcs.ericsson.se>
	 <1266515620.21209.47.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A7808E8@EUSAACMS0703.eamcs.ericsson.se>
	 <1266590959.32011.43.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780DE6@EUSAACMS0703.eamcs.ericsson.se>
	 <1266601575.32011.83.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316AFB7@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain
Date: Fri, 19 Feb 2010 16:06:34 -0500
Message-Id: <1266613594.32011.103.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-02-19 at 15:23 -0500, Alan Rouse wrote:
> Stephen wrote:
> > What does this file contain?  It shouldn't exist at all with modular/managed policy; 
> > it was the legacy way of providing distribution-shipped custom boolean definitions 
> > with monolithic policy. Delete it or put SETLOCALDEFS=0 in your /etc/selinux/config to ignore it.
> 
> Excellent!!!   I put SETLOCALDEFS=0 in /etc/selinux/config and now I'm able to boot into the desktop with selinux enabled, in permissive mode.  (BTW, setsebool does create / update the /etc/selinux/refpolicy-standard/modules/active/booleans.local file.)
> 
> Outstanding issues:
> 1) Several pages of AVC messages: getty_t, sysadm_dbsud_t, system_dbusd_t, various others.
> 
> 2) Error messages during the "fixfiles relabel" (running as root, in permissive mode):
> 
> linux-f8dr:/etc/selinux # fixfiles relabel
> 
>     Files in the /tmp directory may be labeled incorrectly, this command 
>     can remove all files in /tmp.  If you choose to remove files from /tmp, 
>     a reboot will be required after completion.
>     
>     Do you wish to clean out the /tmp directory [N]? n
> /sbin/setfiles:  unable to stat file /home/alan/.gvfs: Permission denied
> /sbin/setfiles:  error while labeling /home:  Permission denied
> find: unknown predicate `-context'
> find: unknown predicate `-context'

I'd run fixfiles from single-user mode and then reboot.

You should file bugs against policycoreutils (to update to the latest)
and against findutils (to include the selinux patch).  The first problem
(inability for even root to traverse a FUSE mount that is owned by
another user) was worked around by a change to setfiles in
policycoreutils 2.0.71 to skip inaccessible mounts.  The second problem
(lack of support for the -context predicate in find) indicates that your
findutils package was not built with SELinux support.  It appears that
this support is still a separate patch in the Fedora package rather than
being part of upstream findutils, so they would need to grab it from the
Fedora .src.rpm or source repository.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
