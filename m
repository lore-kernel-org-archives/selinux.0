Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA03868
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2001 12:32:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA18602
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2001 16:32:28 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA18598
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2001 16:32:27 GMT
Date: Wed, 4 Apr 2001 12:31:39 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Amon Ott <ao@rsbac.org>
cc: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Subject: Re: Rule Set Based Access Control (RSBAC)
In-Reply-To: <01040412163501.00989@marvin>
Message-ID: <Pine.SOL.3.95.1010404112221.13906D-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> So does it really e.g. change the access bits on open file descriptors or close
> them, when the policy setting that originally granted access is now set so that
> access would be denied?

For open file descriptions, SELinux simply revalidates permission on use,
so it doesn't need to modify the file flags or close the descriptors.
The AVC entry references allow SELinux to perform such revalidation
without the overhead of a full permission check computation unless
the policy has changed.  For memory-mapped files, SELinux
invalidates the page cache entries for the relevant file and 
revalidates permission on the subsequent page fault (this support is 
not yet complete in our 2.4 version). 

> The fixed RSBAC models were implemented in such a hardwired way, because it
> should be conceptually impossible to change them at runtime. Thus I saw no need
> for type abstraction, and sure the compiler type checks were useful for coding.

But this is contrary to being flexible in the ability to add, remove,
or completely replace policy modules in the ADF without affecting the rest
of the kernel or applications that deal with labels.

> After having another look into RSBAC code: The only such pointer really used is
> the dentry pointer. How do you handle attribute value inheritance in
> filesystems? Do you have such a concept?
> 
> Inheritance is an important RSBAC concept, because it greatly reduces the
> number of attribute structs ('labels') and makes administration easier.

By inheritance, do you simply mean the behavior when a file
is created and initially assigned a label or do you mean
an implicit labeling mechanism similar to the implicit
typing of DTE?  SELinux stores file labels explicitly,
but it allows labels to be managed using a higher-level
specification based on pathname regular expressions.
We support inheritance of attributes when files are
created, but each file has its own label.  However,
the technique used to store those labels only needs
to store each distinct label once.

> Not having to change the tool is sure an advantage, but policy independent ps
> output must somehow be connected to the policy afterwards to be of any use, or
> am I mistaken here? How is this problem handled? Sure you are not just moving
> it to the administrators.

The two policy-independent data types for security labels are
the security context and the security identifier (SID).  The
security context is simply a human-readable string representation of the
security attributes, while the security identifier is simply
a nonpersistent, local integer that refers to a security context.
Applications such as the modified ps can simply handle and display
security contexts without needing to deal with the internal content and
format of such contexts.  The file system code can likewise handle and
store security contexts for persistent labels (using an intermediate
mapping of persistent security identifiers for efficiency) without
needing to deal with the internals of labels.  Most of the kernel
can simply deal with SIDs for active subjects and objects.  So
you can add or remove attribute fields or completely replace
the security label format/contents without any impact on 
applications or kernel code that deals with labels.

> We still seem to have some difference in the way we look at security models:
> For me, labelling by a subject should be an exception from the rule, because it
> is a discretionary element. Whenever possible, the labels should be mandatory,
> chosen by predefined security settings, which are done with as much separation
> of duty as possible.
> 
> Something special in my point of view is that I distrust all user mode
> programs, because they come from unknown sources and might have been modified,
> e.g. trojanized or infected by viruses. In some cases I have to rely on them,
> e.g. for the (insuffient) Linux style user authentication.

I don't think we really disagree here.  As much as possible, we try to
provide complete transparency to applications through default labeling
behaviors.  But we also believe that there are valid reasons for
providing extended APIs to certain applications.  Providing those
extended APIs doesn't weaken our security, because a single set
of consistent controls is defined that addresses both the ordinary
calls and the extended calls.

> But here you interfere with the existing Linux access control scheme, which
> might want to set the capabilities differently.
> Or are you only talking about the place of interception of the object access?
> Then you have a point here, it could really reduce the modifications, but it
> gives you less data to decide upon.

In addition to our other controls, we provide a parallel
"interception"/control for each of the Linux capabilities that is
implemented in the existing capable function.  That allow us to
leverage what the Linux-Privs people have done to trivially
control a number of privileged operations.  We aren't interfering
with the Linux capabilities scheme any more than we are interfering
with the Linux DAC scheme - we simply provide an additional,
orthogonal control that must also authorize the operation.

> How do you authenticate and set another id then? Do you provide modified
> programs with extra calls for all such cases?

We provide a slightly modified login program to set the initial
security context for the user's login session.  Alternatively,
we could have left login alone and provided a new program
for authenticating and setting our user identity after login,
but it was cleaner to modify login.  Otherwise, we don't care
about changes in the Linux identity attributes during a login
session - they aren't relevant to our controls.

> And you are sure you do not want to use ACLs instead? How do you keep the
> overview over 70 domains and filesystems with 188 file types?
> How many domains are for single users only?

Most of the domains are simply for the various system daemons
and for programs that require special access rights.  For example,
we define domains for init, the rc scripts, getty, syslogd,
klogd, crond, login, inetd, tcpd, ftpd, etc.  For some
programs, we define multiple domains depending on the context
in which they were called, e.g. login runs in different domains
with different permissions depending on whether it was executed
by getty, rlogind, or sshd.  Programs that require special
access rights like insmod or fsck are placed into their
own domains, and we restrict the ability to enter these
domains.

For users, we currently just define two initial login domains, one 
for ordinary users and one for administrators.  However, as users
run programs, these domains automatically transition to derived
domains as needed to gain or shed access rights.  For example,
when users run netscape, they transition to a less privileged
domain so that any downloaded code is confined.  When users
run passwd, they transition to a more privileged domain that
can modify the passwd file.

> Out of interest: How is your binary policy representation protected against
> unwanted modification?

In the same way that any other file is protected - by labeling
appropriately and defining the policy so that write access 
is highly restricted.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
