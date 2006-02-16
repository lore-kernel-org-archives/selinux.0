Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1GJQZXf001614
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 14:26:37 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1GJPBTW025655
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 19:25:11 GMT
Subject: [RFC] semodule policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 14:28:46 -0500
Message-Id: <1140118126.13925.211.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So we have the start of a semodule policy [1] that needs some discussion
on its design.  Here are the relevant parts of the discussion:

On Tue, 2006-02-14 at 09:01 -0500, Daniel J Walsh wrote:
> Added semodule policy.  This still needs work.  semodule now wants to
> create lock files in /etc/selinux/TYPE/modules sub directory.  I would
> like to label this policy_config_t, problem is that all tools
> (setfiles, restorecon ...) need write access in order to create the
> lock file.  This is a serious problem.  I think we also need to
> label /usr/share/selinux/TYPE/*.pp files as policy_config_t.

On Tue, 2006-02-14 at 14:03 -0500, Joshua Brindle wrote: 
> setfiles nor restorecon link against libsemanage so they should not be 
> touching the store at all, the store is a private resource of libsemanage.
> 
> The module store labeling strategy should reflect what I did with the 
> access_check function, eg., making module/{active,previous} totally 
> inaccessible to anything except semodule_t, giving 
> module/semodule.read.LOCK and module/semodule.trans.LOCK different 
> labels so we can have legitimate "read only" domains.
> 
> Then, TYPE/contexts and TYPE/policy can have whatever labels they have 
> now with whatever access they have now and it should be fine. 
> Unfortunatly having the 'active' binary policy out of the store 
> eliminates some ability to encapsulate access to it but I suppose that 
> can be addressed some other time.

I agree with Joshua, my current idea would be a .fc like (abbreviated):

modules				-d	selinux_config_t
modules/(active|previous|tmp)(/.*)? 	semodule_store_t
modules/semanage.read.LOCK	--	semodule_read_lock_t
modules/semanage.trans.LOCK	--	semodule_trans_lock_t

Then semodule_t would have a dir type_transition on selinux_config_t.
Then the rest of semodule_t policy should hopefully fall in place.

As for /usr/share/selinux/$NAME/*.pp, I agree that they should have a
different label, but I'm not sure they should be policy_config_t.

[1] http://marc.theaimsgroup.com/?l=selinux&m=113992576831596&w=2

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
