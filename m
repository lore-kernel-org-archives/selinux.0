Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA4FgxMA027712
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 10:43:00 -0500 (EST)
Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool -P to
	use	libsemanage
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
   James Morris <jmorris@redhat.com>, Chad Sellers <csellers@tresys.com>
In-Reply-To: <436B8185.4050508@cornell.edu>
References: <436915FB.3040500@tresys.com>
	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>
	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu>
	 <1131116390.23420.247.camel@moss-spartans.epoch.ncsc.mil>
	 <436B8185.4050508@cornell.edu>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 10:33:44 -0500
Message-Id: <1131118424.23420.265.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 10:43 -0500, Ivan Gyurdiev wrote:
> So, now that this is taken care of:
> 
> TODO:
> - optimize commit in various ways - do not do unnecessary work, disable 
> checking as you mentioned, move seuser validation inside the section 
> where policydb doesn't have to be re-read back in
> - more seuser validation (MLS fields not currently validated)
> - fix ports, and enable those
> - reduce error message verbosity (do not blindly print the call stack - 
> report only info that adds value)

First, we need to adjust setsebool and/or libsemanage to ensure that
load_policy is called with -b when changing booleans, per the earlier
message.  That should then give us working boolean support via
libsemanage.

BTW, the new setsebool presumes a system that is "managed" via
libsemanage and already has its policy in the sandbox, so it will break
if used on a system that hasn't been converted to that model.  Do we
care?  Do we need to support the old behavior (direct manipulation of
the installed booleans.local file via libselinux) as a fallback on a
non-managed system?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
