Subject: Re: Announce: SELinux conditional policy extensions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: Russell Coker <russell@coker.com.au>, Frank Mayer <mayerf@tresys.com>,
   "'Joshua D. Guttman disp: current'" <guttman@mitre.org>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>,
   "'Amy L. Herzog'" <aherzog@mitre.org>,
   "'Galen B. Williamson'" <gwilliam@mitre.org>,
   "'Grant M. Wagner'" <gmw@tycho.ncsc.mil>, "'David Caplan'" <dac@tresys.com>
In-Reply-To: <ogtu11lyk7i.fsf@divan.mitre.org>
References: <000c01c3f265$9139f860$020d010a@columbia.tresys.com>
	 <200402141451.08044.russell@coker.com.au> <ogtu11lyk7i.fsf@divan.mitre.org>
Content-Type: text/plain
Message-Id: <1077283395.4023.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 20 Feb 2004 08:23:15 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-02-20 at 08:05, John D. Ramsdell wrote:
> I have one suggestion for making SE Linux policies more
> comprehensible.  Suppose the semantics of a class is defined by
> binding it to one or more LSM hook functions that perform access
> control.  In this way, the author of a policy file would know that an
> allow statement that refers to, say, the file class is making a
> statement about permissions associated with the LSM file access
> control hooks, and statements that refer to the inode class is making
> a statement about permissions associated with the LSM inode access
> control hooks.
> 
> Of course, the SE Linux Security Module implements a binding of
> classes to access control hooks, but documentation available to policy
> writers I've seen does not encourage the writers to rely on any
> particular binding.

The set of security classes and permissions were originally defined long
before LSM was even considered, and were based on an analysis of the set
of kernel abstractions and logical operations.  Changing them to conform
to the LSM hooks would be pointless, and likely lead to greater
confusion, as multiple LSM hooks map to a single permission (or set of
permissions) in the SELinux model.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
