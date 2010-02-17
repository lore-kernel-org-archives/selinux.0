Subject: RE: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A780310@EUSAACMS0703.eamcs.ericsson.se>
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
Content-Type: text/plain
Date: Wed, 17 Feb 2010 16:29:18 -0500
Message-Id: <1266442158.4945.144.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-02-17 at 16:11 -0500, Alan Rouse wrote:
> 1.  Is there supposed to be an environment variable $SELINUXTYPE?  I don't have one...

Defined by /etc/selinux/config
. /etc/selinux/config

> 2.  When I do "make load", the policy file in 
> 
> 	/etc/selinux/refpolicy-standard/policy/policy.24 
> 
> is replaced (at least, it gets a new timestamp).  

Ok, and what happens when you run setsebool -P init_upstart=1?
That file should also get regenerated.

> /etc/selinux/config contains:
> 
> SELINUX=permissive
> SELINUXTYPE=refpolicy-standard
> 
> 3.  ls -l /etc/selinux/refpolicy-standard/policy
> 
> -rw-r--r--. 1 root root 3686162 Feb 17 16:05 policy.24
> 
> 4. cat /selinux/policyvers
> 
> <nothing>... File is empty

What?  grep selinuxfs /proc/mounts
ls /selinux

> 5.  checkpolicy -V
> 
> 24 (compatibility range 24-15)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
