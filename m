Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CEXlIi015547
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 09:33:47 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CEXigF018810
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 14:33:45 GMT
Date: Wed, 12 Jan 2005 14:44:11 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
Subject: Re: Multiple contexts
Message-ID: <20050112144411.GZ26175@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net> <20050110232312.GI6967@lkcl.net> <1105474191.20566.134.camel@moss-spartans.epoch.ncsc.mil> <20050111214818.GE26175@lkcl.net> <1105538449.22495.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105538449.22495.8.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jan 12, 2005 at 09:00:49AM -0500, Stephen Smalley wrote:

> On Tue, 2005-01-11 at 16:48, Luke Kenneth Casson Leighton wrote:
> >  recursion was added to ACLs - or "inheritance" - because to fix access
> >  to subdirectories and all contents you are required in NT 4.0 to change
> >  ALL permissions on ALL subdirectories and contents!
> > 
> >  basically you now have to traverse the directory tree right
> >  up to the mount point [as stephen says] in order to determine access
> >  rights, combining and checking permissions as you go.
> > 
> >  eeuuuw.
> > 
> >  ... was that what you were referring to stephen?
> 
> No.  I'm simply referring to the fact that if your policy is encoded in
> the file attributes themselves, as with ACLs, then you cannot analyze
> the potential information flow among security equivalence classes in the
> system (which is necessary if you want to ensure confidentiality or
> integrity guarantees) without looking at all of the file attributes. 

 ... how about encoding the file attributes in the policy files,
 such that they are ACL-like?

 [i realise this is quite a radical change under-the-hood]

 if nothing else by having the means to apply a list of contexts
 [any of which may apply] to a file.

 the ultimate aim of which would be to make it easier for
 administrators to add permissions and programs without going
 through a complete policy rebuild / reload.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
