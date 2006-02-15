Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1FI24Xf014991
	for <selinux@tycho.nsa.gov>; Wed, 15 Feb 2006 13:02:04 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1FI0cxb005066
	for <selinux@tycho.nsa.gov>; Wed, 15 Feb 2006 18:00:40 GMT
Subject: Re: [PATCH] refpolicy: external modules
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Spencer Shimko <sshimko@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>,
   Christopher Ashworth <cashworth@tresys.com>
In-Reply-To: <200602101629.58281.sshimko@tresys.com>
References: <200602101629.58281.sshimko@tresys.com>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 13:04:02 -0500
Message-Id: <1140026642.13925.144.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-02-10 at 16:29 -0500, Spencer Shimko wrote:
> Attached is a patch to Makefile, Rules.monolithic, and Rules.modular in 
> reference policy that does two things:

Merged, with a few tweaks.

> 1. It contains an update version of the patch submitted to the list on 
> 1/12/2006 to change policy module state from the command line at build 
> time.  The three variables used are APPS_OFF (disable a policy module 
> off), APPS_ON (enable a policy module and include it in the base module), 
> and APPS_MODS (enable a policy module and build it as a module).  Example 
> usage:
> $make clean
> $make APPS_OFF="gpg" 
> 
> 2. It includes a patch from Chris Ashworth that allows external policy 
> trees to be used when building policy.  The idea for this is two fold: 
> first it allows someone to build a module without having write access to 
> the reference policy directory, second it allows someone to maintain an 
> out-of-tree "third-party" module with little effort.  It expects a 
> similar filesystem layout including layers in the policy/modules 
> directory and support macros (if any) in the policy/support directory.  
> Example usage:
> $make LOCAL_ROOT="/home/spencer/mypolicy"

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
