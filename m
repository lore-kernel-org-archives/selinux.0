Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA4EQ6MA026375
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 09:26:06 -0500 (EST)
Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool -P to
	use	libsemanage
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
   James Morris <jmorris@redhat.com>, Chad Sellers <csellers@tresys.com>
In-Reply-To: <436B6E9E.4050108@cornell.edu>
References: <436915FB.3040500@tresys.com>
	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>
	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu>
	 <1131110455.23420.187.camel@moss-spartans.epoch.ncsc.mil>
	 <436B6E9E.4050108@cornell.edu>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 09:16:52 -0500
Message-Id: <1131113812.23420.236.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 09:22 -0500, Ivan Gyurdiev wrote:
> So, how do I specify that this is not a transient change, and I want my 
> booleans loaded into policy immediately?

Ah, I see - setsebool -P wants to both update the saved settings and
load the result rather than preserving current settings.  So it wants
libsemanage to call load_policy with -b, unlike semodule.  Options are:
- add a semanage interface to set a property on the handle to control
whether booleans are preserved or not (by altering the args to
load_policy for that handle), similar to the existing interface for
controlling whether reloads are performed, or
- do that automatically within your boolean_local interfaces so that all
boolean manipulations via libsemanage will trigger a load_policy -b upon
commit.   

> I think I'll try to add all kinds of shortcuts by tracking exactly what 
> the user is trying to do...
> If there are no module changes, we can reuse the old "base.expanded" file.
> If there are no policy changes, we can skip rebuilding the policy. So, 
> if only seusers
> were changed, we only need to read the policy.kern, instead of 
> reconstructing it.

As a simpler first step, you can simply set sh->conf->expand_check = 0
if there are no module changes, as the expand-time assertion and
hierarchy checking should be unaffected by anything other than a module
change, IIRC.  The heaviest operation is the expand time checking.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
