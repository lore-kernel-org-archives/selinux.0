Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0BLbtIi011006
	for <selinux@tycho.nsa.gov>; Tue, 11 Jan 2005 16:37:56 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0BLbo1A026635
	for <selinux@tycho.nsa.gov>; Tue, 11 Jan 2005 21:37:54 GMT
Date: Tue, 11 Jan 2005 21:48:18 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
Subject: Re: Multiple contexts
Message-ID: <20050111214818.GE26175@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net> <20050110232312.GI6967@lkcl.net> <1105474191.20566.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105474191.20566.134.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jan 11, 2005 at 03:09:51PM -0500, Stephen Smalley wrote:
> On Mon, 2005-01-10 at 18:23, Luke Kenneth Casson Leighton wrote:
> >  i can only hazard a hazardous guess therefore that the more
> >  "normal" ACL system [that we are used to seeing] was rejected
> >  because it makes the formal proof methodology more difficult.
> 
> With ACLs, you have to traverse the entire filesystem state in order to:
> 1) determine what your policy truly is (and that policy can change
> underneath you during your traversal),
> 2) apply any widespread changes in policy state.
 
> Management and scalability nightmare.
 
 oh - ah.  yes, now it comes back to me.

 microsoft solved this problem partially in NT 3.5 - NT 4.0 by
 only reading the ACL on the file [or directory] and applying that.

 by the time that NT 5 [aka windeuuws teuu thousand, with NT being a
 trademark owned by Northern Telecom, aka Nortel and all] came around,
 this was considered utterly mad.

 recursion was added to ACLs - or "inheritance" - because to fix access
 to subdirectories and all contents you are required in NT 4.0 to change
 ALL permissions on ALL subdirectories and contents!

 basically you now have to traverse the directory tree right
 up to the mount point [as stephen says] in order to determine access
 rights, combining and checking permissions as you go.

 eeuuuw.

 ... was that what you were referring to stephen?

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
