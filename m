Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1JFweDj028566
	for <selinux@tycho.nsa.gov>; Fri, 19 Feb 2010 10:58:40 -0500
Received: from imr1.ericy.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1JFwPqX016235
	for <selinux@tycho.nsa.gov>; Fri, 19 Feb 2010 15:58:25 GMT
From: Alan Rouse <alan.rouse@ericsson.com>
To: "Justin P. mattock" <justinmattock@gmail.com>
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Date: Fri, 19 Feb 2010 10:58:36 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A780E37@EUSAACMS0703.eamcs.ericsson.se>
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
 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>
 <4B7DB3B4.2070409@gmail.com>
 <5A5E55DF96F73844AF7DFB0F48721F0F529A780AEE@EUSAACMS0703.eamcs.ericsson.se>
 <4B7DCA8D.8010708@gmail.com>
In-Reply-To: <4B7DCA8D.8010708@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

First let me say that I appreciate all the help on this list very much!!!!!

Justin wrote:

> While running the one that they provide I noticed the system is running as 
> system_u:system_r:system_t (or whatever it is) I'm sure you can use this, but for me I 
> like to either run in staff_r, sysadm_r or user_r(roles).

Makes sense...   I think you're saying this is not the underlying problem for the gdm / desktop / boot issues, right?   If so I'd like to get to a clean selinux boot before addressing this type of thing.

> I couldn't find the source from suse(although I'm sure its there), so I just grabbed a 
> copy from tresys...while building the source from tresys I sometimes will hit a syntex
> error(this time I did) with checkpolicy and/or checkmodule

I'm now able to build policy from the source obtained from the OpenSuse 11.2 repository. Do I need a different version of checkpolicy or checkmodule?  Or can I skip this? 

> then after being able to build and install the policy  then I focused in on the 
> booleans, I set(although am not sure if they fixed the errors with avahi)where these:
> 
> allow_polyinstantiation=on

I don't need polyinstantiation right now so I'll skip that unless you think it's pertinent to my main problem.

> init_upstart=on(although I think they use sysvinit(notsure))

Yes, OpenSuse 11.2 seems to be using sysvinit
 
> xdm_sysadm_login=on(this is for sysadm_r role(if I wanted the main context as name:sysadm_r:sysadm_t)) 
> xserver_object_manager=on (although I dont see the SELinux extension in Xorg.0.log)

I've been unable to make persistent changes to policy, booleans etc.  Hopefully Stephen will spot the problem causing that, based on the info I sent out a few minutes ago.  

> keep in mind I don't think these booleans fixed the errors I think after I had 
> relabeled then the errors were fixed(but could be wrong).

I could boot cleanly to a desktop before relabeling (with everything as file_t).  Once I relabeled with fixfiles, runlevel 5 would fail and I'd be dropped back to a console at runlevel 3.  

> then once I was able to get a clean boot(even with the "targeted" dbus
> issue)

If I can get to that point I think I'll be in business.

Thanks 
Alan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
