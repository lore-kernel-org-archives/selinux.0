From: Alan Rouse <alan.rouse@ericsson.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Date: Wed, 17 Feb 2010 15:49:40 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A7802D6@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
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
In-Reply-To: <1266438910.4945.137.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Today, up until now, I've been working with the binary policy package in the native OpenSuse 11.2 repository (without installing source).  But I've just now installed the corresponding source package and built it as monolithic=n.  As before, "setsebool -P init_upstart=1" gives an error message:
----------------
Libsemanage.get_home_dirs: nobody homedir /var/lib/nobody or its parent directory conflicts with a file context already specified in the policy.  This usually indicates an incorrectly defined system account.  If it is a system account please make sure its uid is less than 1000 or its log in shell is /sbin/nologin.
----------------

So I did "usermod -s /sbin/nologin nobody" and repeated the setsebool. No error message returned, and "getsebool init_upstart" reports that it was on.  But after reboot it is off again...  And, yes, I did issue "setsebool -P init_upstart=1" before reboot, and confirmed with "getsebool init_upstart" that it worked.

It is still giving the gdm /selinux error that I quoted in my first email on this thread (despite the fact that selinux is in permissive mode, confirmed by sestatus).  The following services in runlevel 5 fail:  earlyxdm, xdm, avahi-daemon.   So boot drops me into runlevel 3.  The sestatus -v and pstree -Z are unchanged from what I sent most recently (since the setsebool -P isn't persistent across a boot.)

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Wednesday, February 17, 2010 3:35 PM
To: Alan Rouse
Subject: RE: SELinux Policy in OpenSUSE 11.2

On Wed, 2010-02-17 at 15:18 -0500, Alan Rouse wrote:
> Ok, for that I'll have to get the source and build it as a non-monolithic policy, right? 

Oh, I thought you were already building it with MONOLITHIC=n.
If it is monolithic, then just change the init_upstart = false line in policy/booleans.conf to init_upstart = true and do a make load.

--
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
