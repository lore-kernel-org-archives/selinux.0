Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA03144
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2001 11:14:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA14128
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2001 15:14:28 GMT
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com [194.25.134.81])
	by jazzswing.ncsc.mil  with ESMTP id PAA14124
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2001 15:14:27 GMT
From: Amon Ott <ao@rsbac.org>
To: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Subject: Re: Rule Set Based Access Control (RSBAC)
Date: Wed, 4 Apr 2001 16:44:23 +0200
Content-Type: text/plain
References: <Pine.LNX.4.10.10104040817380.8824-100000@gargoyle.clark.net>
In-Reply-To: <Pine.LNX.4.10.10104040817380.8824-100000@gargoyle.clark.net>
MIME-Version: 1.0
Message-Id: <01040417141800.00861@marvin>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mit, 04 Apr 2001 Paul D. Robertson wrote:
> On Wed, 4 Apr 2001, Amon Ott wrote:
> > Something special in my point of view is that I distrust all user mode
> > programs, because they come from unknown sources and might have been modified,
> > e.g. trojanized or infected by viruses. In some cases I have to rely on them,
> > e.g. for the (insuffient) Linux style user authentication.
> 
> I'm curious about this- in a best-case scenerio, how do you see user auth?  At
> some point, especially for network aware applications, some user mode
> authenticating piece has to be (probably grudgingly) moved into the TCB.
> For instance with the Dockmaster II stuff, the modified httpd has to be
> part of the TCB because it must be able to allow per-user access.  Is a
> known-goodware scan better than a malware scan for such applications?    

Only the part doing the authentication must be part of the TCB. Take RSBAC
AUTH model as an example, which has been designed to solve this problem:

- User mode process, e.g. running httpd, wants to setuid to access some object
with different rights. It gathers authentication data and calls an independent
auth facility (IPC to a daemon or syscall).
- Authentication facility checks the data and either returns error or adds an
AUTH capability for the requesting process to setuid to the desired uid. This
cap is only valid for this single process.
- Process calls setuid and works on behalf of another user
- If process wants to setuid to another uid (or the original one), the procedure
restarts

In this szenario, the httpd can be mostly untrusted, apart from gathering auth
data - this is difficult to avoid because of the http protocol. Sure the auth
data could be valid for this purpose only, what could be solved on a per-program
basis.

> > Real account management should be in the kernel, with strong data protection,
> > strong on-disk encryption and setuid limitation by this account management to
> > those ids which have been authenticated by the process asking.
> 
> The process asking still has the malware problem though doesn't it?  (Has
> anyone applied RSBAC to an International kernel to get disk encryption?)

I know that several people are planning to combine both in their server
systems. I have not yet tried myself, but in principle it should work.
  
> > > The example configuration provided with SELinux defines 70 domains,
> > > 188 file types, and 38 other types (e.g. network-related types).
> 
> How do the SELinux people expect auditing to take place in such an
> example?  Users switching jobs and system upgrades seem to be difficult to
> audit effectively with that many default permutations, or am I missing
> something?

That's part of what I meant with 'Who keeps the overview'. Just think of adding
a user account and looking the desired role up in a book.
  
> > > I probably wasn't clear.  With SELinux, you edit the human-readable policy
> > > configuration files to set up your policy (starting with the example
> > > configuration we provide if you want), then compile that policy
> > > into a binary representation and install it.  You can then load
> > > the updated policy into your running kernel (if the policy authorizes
> > > such runtime changes) using a new system call, or you can reboot
> > > (in which case the kernel will load the new policy when it
> > > initializes).  My concern was with the need to run a special
> > > set of utilities that use a special set of system calls to
> > > customize the configuration, as opposed to being able to edit
> > > human-readable configuration files.

> [cut]
 
> I'm also still intensely interested in "two man missile key" stuff.  How
> does SELinux handle a model where either multiple adminitstrators should
> be necessary to grant access to something, or granting a subset of grant
> privs. to a subject is possible to stop the subject from granting all
> grant privs. to another subject or itself (which makes it easy to get to
> the first part by requiring both privs. to do something)?  Is it possible to 

These problems have been solved in Simone Fischer-Hübner's Privacy Model
design (RSBAC PM module), where you must be Security Officer *and* need a
'ticket' issued by a Data Protection Officer (or TP Manager in other cases) to
do some administrative task.

Also, RC model separation of admin duty can split admin tasks up into several
roles, which have to work together. E.g., role A sets up role C's rights to
those target types, that role A is allowed to access control, and role B
assigns role C to users.

Of course, all denied changes are logged to syslog and RSBAC internal log.

> set up a system where an administrator doesn't have access to certain
> targets, and whilst they could grant permissions to other targets on the
> same sytem, and even grant access to grant access to other targets, were
> still blocked from seeing the data they're not supposed to have access to
> (obviously along with their grantees)?  [IOW: is granting rights to grant
> rights restrictable in a way other than a binary yes/no fashion?]

RC separation of admin duty does part of this. ACL module administration does
most, but there is currently no way to disallow granting yourself any
additional rights, if you are allowed to grant rights to others.

As often in RSBAC, a combination of RC and ACL does the full trick (full
explanation on request - this is a bit complicated).

Amon.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
