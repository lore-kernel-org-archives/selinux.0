Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA08493
	for <selinux@tycho.nsa.gov>; Thu, 5 Apr 2001 04:00:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA25493
	for <selinux@tycho.nsa.gov>; Thu, 5 Apr 2001 08:00:35 GMT
Received: from mailout00.sul.t-online.com (mailout00.sul.t-online.com [194.25.134.16])
	by jazzswing.ncsc.mil  with ESMTP id IAA25489
	for <selinux@tycho.nsa.gov>; Thu, 5 Apr 2001 08:00:35 GMT
From: Amon Ott <ao@rsbac.org>
To: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Subject: Re: Rule Set Based Access Control (RSBAC)
Date: Thu, 5 Apr 2001 09:33:27 +0200
Content-Type: text/plain
References: <Pine.SOL.3.95.1010404112221.13906D-100000@clipper.gw.tislabs.com>
In-Reply-To: <Pine.SOL.3.95.1010404112221.13906D-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <01040510000003.00859@marvin>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mit, 04 Apr 2001 Stephen Smalley wrote:
> > The fixed RSBAC models were implemented in such a hardwired way, because it
> > should be conceptually impossible to change them at runtime. Thus I saw no need
> > for type abstraction, and sure the compiler type checks were useful for coding.
> 
> But this is contrary to being flexible in the ability to add, remove,
> or completely replace policy modules in the ADF without affecting the rest
> of the kernel or applications that deal with labels.

No, you can always add or remove policies by kernel configuration, the
unneeded attributes are then simply unused.

One advantage of keeping e.g. all user attributes in one struct is that for a
run through all decision modules, only one full entry lookup is needed. For the
second and following attribute readings or settings for this user, there is a
shortcut pointer.

> > After having another look into RSBAC code: The only such pointer really used is
> > the dentry pointer. How do you handle attribute value inheritance in
> > filesystems? Do you have such a concept?
> > 
> > Inheritance is an important RSBAC concept, because it greatly reduces the
> > number of attribute structs ('labels') and makes administration easier.
> 
> By inheritance, do you simply mean the behavior when a file
> is created and initially assigned a label or do you mean
> an implicit labeling mechanism similar to the implicit
> typing of DTE?  SELinux stores file labels explicitly,
> but it allows labels to be managed using a higher-level
> specification based on pathname regular expressions.
> We support inheritance of attributes when files are
> created, but each file has its own label.  However,
> the technique used to store those labels only needs
> to store each distinct label once.

In RSBAC, each object can also have its own attribute struct object. However,
in most cases all attribute settings are default values, e.g. 'inherit from
parent'. Struct objects with default values only are regularly cleaned up to
keep the lists small.

When a value is set, a new object is created. When a value is requested, but
there is no struct object, the default values are returned.

An attribute value of 'inherit from parent' means that the lookup recurses to
the next higher object level, e.g. the directory a file is in. If there is no
higher level, but also no struct object for the current object, real default
values are returned.

E.g. ACL model has another, more sophisticated inheritance scheme, with
inheritance masks and accumulation of user, role and group rights.

With this inheritance and default scheme, a complicated setup for a server with
a lot of services (like our Communication Server mentioned before) only needs a
few hundred attribute structs. Most of these are necessary, because /lib and
/usr/lib contain a mixture of libraries and non-libraries.

> > And you are sure you do not want to use ACLs instead? How do you keep the
> > overview over 70 domains and filesystems with 188 file types?
> > How many domains are for single users only?
> 
> Most of the domains are simply for the various system daemons
> and for programs that require special access rights.  For example,
> we define domains for init, the rc scripts, getty, syslogd,
> klogd, crond, login, inetd, tcpd, ftpd, etc.  For some
> programs, we define multiple domains depending on the context
> in which they were called, e.g. login runs in different domains
> with different permissions depending on whether it was executed
> by getty, rlogind, or sshd.  Programs that require special
> access rights like insmod or fsck are placed into their
> own domains, and we restrict the ability to enter these
> domains.

OK, I usually group these services into roles, or use the roles of the users
they run for. As they can only run as certain users (AUTH capability
restrictions), they cannot do much harm.
   
> For users, we currently just define two initial login domains, one 
> for ordinary users and one for administrators.  However, as users
> run programs, these domains automatically transition to derived
> domains as needed to gain or shed access rights.  For example,
> when users run netscape, they transition to a less privileged
> domain so that any downloaded code is confined.  When users
> run passwd, they transition to a more privileged domain that
> can modify the passwd file.

This is usually done with RC using forced roles. Netscape gets its own role,
which is used for all users and can only fully access /home dirs (with some
exceptions, e.g. loading files marked as libraries). Home dirs are protected
individually by either Linux flags or ACL entries with masks.
   
> > Out of interest: How is your binary policy representation protected against
> > unwanted modification?
> 
> In the same way that any other file is protected - by labeling
> appropriately and defining the policy so that write access 
> is highly restricted.

So this is done by careful administration, and probably giving write
access to your policy compiler run by special domains only.

Amon.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
