Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k86Era4a010958
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 10:53:36 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k86Eqmjo001793
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 14:52:50 GMT
Message-ID: <44FEE0DC.8030408@trustedcs.com>
Date: Wed, 06 Sep 2006 09:53:16 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Todd Miller <Todd.Miller@sparta.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: current selinux-usr incompatible with refpolicy-20060307?
References: <3F89D16F-5FBA-405B-A179-EC48DF45D6A4@sparta.com>
In-Reply-To: <3F89D16F-5FBA-405B-A179-EC48DF45D6A4@sparta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd Miller wrote:
> In trying to build refpolicy-20060307 on an FC5 machine using an  
> selinux userland with the following svn tags: checkpolicy_1_30_11  
> libselinux_1_30_27 libsemanage_1_6_15 libsepol_1_12_26  
> policycoreutils_1_30_28 I get this error:
> 
> /usr/bin/checkpolicy policy.conf -o policy.21
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> libsepol.expand_terule_helper: duplicate TE rule for initrc_t  
> insmod_exec_t:process insmod_t
> libsepol.expand_module: Error during expand
> Error while expanding policy
> make: *** [policy.21] Error 1
> 
> The selinux userland components that ship with FC5 are able to build  
> the policy.conf into a binary file without problems.  Is there a  newer 
> version of refpolicy that folks are using for development?

The reference policy used to have a conflicting statement in an optional
block of policy that was not caught due to a bug in the toolchain.  The
patchset is outlined in the following email:

http://marc.theaimsgroup.com/?l=selinux&m=115107448603049&w=2

You can always grab the latest snapshot of the reference policy using svn
as described here:

http://oss.tresys.com/projects/refpolicy/wiki/SubversionCheckout

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
