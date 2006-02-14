Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1EJ3DXf029698
	for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2006 14:03:14 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1EJ1n3j010711
	for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2006 19:01:49 GMT
Message-ID: <43F22966.5020907@tresys.com>
Date: Tue, 14 Feb 2006 14:03:02 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
References: <43EB8C6D.7060809@redhat.com> <1139868484.13925.134.camel@sgc> <43F1E2AC.40603@redhat.com>
In-Reply-To: <43F1E2AC.40603@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> Added semodule policy.  This still needs work.  semodule now wants to 
> create lock files in /etc/selinux/TYPE/modules sub directory.  I would 
> like to label this policy_config_t, problem is that all tools 
> (setfiles, restorecon ...) need write access in order
> to create the lock file.  This is a serious problem.  I think we also 
> need to label /usr/share/selinux/TYPE/*.pp files as policy_config_t.
>
setfiles nor restorecon link against libsemanage so they should not be 
touching the store at all, the store is a private resource of libsemanage.

The module store labeling strategy should reflect what I did with the 
access_check function, eg., making module/{active,previous} totally 
inaccessible to anything except semodule_t, giving 
module/semodule.read.LOCK and module/semodule.trans.LOCK different 
labels so we can have legitimate "read only" domains.

Then, TYPE/contexts and TYPE/policy can have whatever labels they have 
now with whatever access they have now and it should be fine. 
Unfortunatly having the 'active' binary policy out of the store 
eliminates some ability to encapsulate access to it but I suppose that 
can be addressed some other time.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
