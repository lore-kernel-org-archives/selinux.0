Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA01630
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2001 06:17:15 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA27718
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2001 10:17:03 GMT
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com [194.25.134.80])
	by jazzband.ncsc.mil  with ESMTP id KAA27714
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2001 10:17:02 GMT
From: Amon Ott <ao@rsbac.org>
To: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Subject: Re: Rule Set Based Access Control (RSBAC)
Date: Wed, 4 Apr 2001 11:00:07 +0200
Content-Type: text/plain
References: <Pine.SOL.3.95.1010403133151.12927O-100000@clipper.gw.tislabs.com>
In-Reply-To: <Pine.SOL.3.95.1010403133151.12927O-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <01040412163501.00989@marvin>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Die, 03 Apr 2001 Stephen Smalley wrote:
> > All policy changes get into effect at once, so the next access control decision
> > will be based on the new settings. If you e.g. want to revoke file access, turn
> > on READ/WRITE interception, and after revoking the rights, all following read
> > attempts will fail.
> 
> Our paper from the 8th USENIX Security Symposium (available via
> http://www.nsa.gov/selinux/flask-abs.html) about the Flask
> security architecture talks at length about the difficulty
> in truly supporting dynamic security policies.  You need to
> address the potential interleaving of policy changes with
> the execution of controlled operations and provide an effective
> atomicity for policy changes so that you know when the new policy
> is truly in effect.  You also need a mechanism to revoke permissions that
> are implicitly retained in the state of the system, e.g. open file
> descriptions, memory-mapped files, established TCP connections,
> and even operations currently in progress that have already checked
> permissions.  The Flask architecture and interfaces were designed to
> address these issues, and the SELinux controls were designed to permit
> efficient revalidation of permissions on use for many services.  Although

OK, full revoking on policy changes as well as atomicity on whole policy
changes has not been a goal for RSBAC. The revoking will probably not be done,
but atomicity might come. It should be rather easy to do for runtime loaded
policies.

> it is true that RSBAC now provides optional READ/WRITE interception on
> read/write calls, I don't think it fully addresses these issues.  SELinux
> isn't perfect in this area either, but it provides the basic
> infrastructure needed to support policy changes and it performs
> revalidation of permissions for many services.

So does it really e.g. change the access bits on open file descriptors or close
them, when the policy setting that originally granted access is now set so that
access would be denied?

RSBAC design never meant to address such very dynamic behaviour, because policy
changes were thought of as rare. I also did not like the idea of interfering
with such data structures - just thinking of different kernel branches with
different ways of working. There are already too many kernel version checks
necessary in the common RSBAC code.

How do you handle this with a common code base?
        
> > This is true, there had been no need for them. I rather wanted to have the
> > compiler control all data types. For the extended runtime policy registration
> > (REG), generic data storage is in progress.
> 
> This issue is also discussed further in the aforementioned paper.
> The content and format of security labels is dependent on the particular
> security policy, so you need policy-independent data types for labels
> in order to truly encapsulate the security policy.  In SELinux,
> the security server interfaces for the kernel, the new system calls,
> and the file labels make use of these policy-independent data types.
> Hence, the content and format of security labels can be radically
> revised without needing to change or even recompile anything other
> than the security server.  Also, since the security contexts for
> files are stored in each file system, human-readable and meaningful
> security information is available if the file system is moved to
> another system or the policy is changed, so translation of
> security attributes is feasible. 

The fixed RSBAC models were implemented in such a hardwired way, because it
should be conceptually impossible to change them at runtime. Thus I saw no need
for type abstraction, and sure the compiler type checks were useful for coding.

Runtime loaded and registered policies are different. They already have their
opaque data types for registered syscalls, and they will get their persistent,
abstract data storage some time soon.

> > Yes, there are pointers given, e.g. dentry pointers. This is necessary
for
> > attribute value inheritance from parent objects (or do you know a
better way?). > > However, no data in kernel structs is ever modified. Most of
these extra > > attributes contain simple integer values, e.g. the uid for a
CHANGE_OWNER > > request.
> > You also have to provide kernel data somehow, because you want to decide about
> > subjects and objects identified by this data.
> 
> I would encourage you to take a look at the SELinux/Flask interfaces
> described in the documentation.  We do not pass any pointers to
> any private kernel objects to the security server.  The security
> server only needs to know the security labels of the relevant
> subjects and objects, not kernel objects or identifiers.  
> In part, this difference is architectural - the GFAC subdivides
> the responsibility between the enforcement code and the decision
> facility differently than Flask.

After having another look into RSBAC code: The only such pointer really used is
the dentry pointer. How do you handle attribute value inheritance in
filesystems? Do you have such a concept?

Inheritance is an important RSBAC concept, because it greatly reduces the
number of attribute structs ('labels') and makes administration easier.

> > For me, this is a clear RSBAC advantage. How many applications are you going to
> > change for your access control system? How will you keep up to date? How does
> > the user get support for arbitrary applications?
> 
> Perhaps I was unclear.  SELinux is mostly transparent to applications
> (except upon access failures, of course).  We provide a set of
> extended and new API calls to allow modified and new applications
> to be developed that have some degree of awareness of the new
> security features.  But existing applications can certainly
> run unchanged on SELinux and appropriate default behaviors
> are applied when the ordinary API calls are used.  As an
> example, we provide a modified ps program that displays
> the security contexts of processes.  But you can run the
> ordinary ps program if you want - you just won't see the
> security contexts with it.  And notice that since we
> provide policy-independent data types for security labels,
> our modified ps program never needs to be changed even if
> the format or content of security labels is radically revised.

Apart from really providing the programs, I do not see a big difference. The
application can handle extended or extra APIs as well as a limited set of data
types.

Not having to change the tool is sure an advantage, but policy independent ps
output must somehow be connected to the policy afterwards to be of any use, or
am I mistaken here? How is this problem handled? Sure you are not just moving
it to the administrators.

 > > If the (small) time window is a problem, then you
have an argument here. You > > would have to create in a protected directory,
set attributes and move the file > > to its final destination.
> > BTW: For PM model, there are specific calls to create files of certain object
> > types - the model design does not provide default types.
> 
> Ok, so you already have a case where a policy module requires the
> ability to allow applications to create files with a particular label.
> By using policy-independent data types for labels, you can have
> a single set of APIs (open_secure, mkdir_secure, etc) that can provide
> this functionality for any policy.  And yes, it is important to be
> able to create objects with a particular label rather than just
> creating them with a default and then relabeling them.  Relabeling
> has its own complications - do you fully address the revocation problem
> for open file descriptions and memory-mapped files?

As stated above, I do see the problem of time windows. The workaround stated
above still holds: Create the object in a fully controlled environment and move
it after setting the values.

We still seem to have some difference in the way we look at security models:
For me, labelling by a subject should be an exception from the rule, because it
is a discretionary element. Whenever possible, the labels should be mandatory,
chosen by predefined security settings, which are done with as much separation
of duty as possible.

Something special in my point of view is that I distrust all user mode
programs, because they come from unknown sources and might have been modified,
e.g. trojanized or infected by viruses. In some cases I have to rely on them,
e.g. for the (insuffient) Linux style user authentication.

Here we are again with my hardwired policies: They can only be changed by
modifying the kernel source, recompiling the kernel, installing it and
rebooting. Most of the steps can be easily prevented by security settings.

> > As to subjects: User accounts are not (yet) controlled by
the kernel anyway. > > This has to be changed soon to get real kernel security.
> 
> I'm not entirely sure what you mean by this statement.

For me, the current Linux authentication scheme with free setuid for all
programs running as root, files containing passwords with weak encryption,
daemon communication over insecure protocols etc. is a terrible mess, inviting
people to break into the system.

Real account management should be in the kernel, with strong data protection,
strong on-disk encryption and setuid limitation by this account management to
those ids which have been authenticated by the process asking.

> > So let's come to processes. Here you are wrong: Process attributes are
> > initialized by the decision modules directly after creation, and before control
> > is returned to the forking or the new process.
> 
> Sure, process attributes are initialized on fork.  But I was talking
> about an extended form of execve to allow changes in attributes
> upon program execution.  That is the most natural point for
> a change in attributes, because you can easily control the
> inheritance of state and the initialization in the new label,
> and you can establish a binding between the new label and
> the executable.  RSBAC supports default label changes on execve
> (e.g. RC forced role transitions), but doesn't provide any
> way for an application to explicitly request such a transition.

S.a.: I never saw this as something that important, because the model and not
the subject should provide the labels.

Taking the fork example: After forking, the new process usually is a full copy
of the old one. So all labels are simply copied by the models, because the
processes differ by pid only . If the new process wants to do something
different, it can execute another program (labels are changed by the models), or
it can e.g. ask to be allowed to work with another role (RC example).

> > OK, if you think that security relevant *and* not sufficiently covered by
> > existing mechanisms.
> 
> With regard to specific controls, I would encourage you to look at
> the Control Requirements sections in our design and implementation
> document (available via http://www.nsa.gov/selinux/slinux-abs.html).
> They specify the precise set of controls for each system call that
> we defined.
> 
> > > controls on
> > > the use of Linux capabilities, 
> > 
> > What for? I do not mess with the existing discretionary access control, it is
> > completely independent. I only control access control data that is relevant for
> > RSBAC.
> 
> A number of the capabilities are used to control highly privileged
> system operations.  We could define our own separate set of permissions
> and add checks to each such privileged operation, but it seems better
> to leverage the work being done by the Linux-Privs people and
> add a hook to the capable function to perform a permission check as well.
> That allows the security policy to control all capability usage, and
> thus control a large number of privileged operations with minimal
> code modifications.
 
But here you interfere with the existing Linux access control scheme, which
might want to set the capabilities differently.
Or are you only talking about the place of interception of the object access?
Then you have a point here, it could really reduce the modifications, but it
gives you less data to decide upon.

> > > 6) RSBAC uses the Linux real user identity attribute for its decisions
> > > and must control changes to this attribute, so it is not completely
> > > orthogonal to the existing Linux access controls.
> > 
> > I believe that a common thing in all access control models that reside on a
> > single system is the identity of a user. This is what authentication is meant
> > to be about.
> > 
> > If users need more than one identity, the model is wrong. She should rather
> > need several roles, or transaction procedures with additional rights, or
> > whatever.
> 
> The SELinux controls themselves are only based on a single user identity
> - the user identity in the security context.  By providing a separate
> usre identity attribute, we can enforce whatever controls we want
> over changes to it without affecting compatibility.  I agree
> that we want to establish the user's identity and then handle
> any needed changes in access rights by changing the role/domain
> rather than the user identity itself.  The concern with using the
> existing Linux real uid is that we must then balance between
> providing rigorous controls over changes to it and maintaining
> compatibility.  There is also an acceptability concern; it
> seems like the kernel developers would be more open to an
> access control scheme that is orthogonal to the existing scheme
> than one that is intermingled with it.

How do you authenticate and set another id then? Do you provide modified
programs with extra calls for all such cases?

You already pointed out that RSBAC originally had its own process owner
attribute. For usability, I ended up setting it at the same places where the
real uid was set. So I made it optional. Later I realized that I never used
that option, so it got removed. All instability problems could have been
solved, but I just did not see the point in this extra complexity.

> > This was a compromise with performance. Still, I won't agree to it being a
> > limitation until you give me an example, where you need more than 64 roles in a
> > single system, and do not think ACLs to be a better solution.
> 
> The example configuration provided with SELinux defines 70 domains,
> 188 file types, and 38 other types (e.g. network-related types).

And you are sure you do not want to use ACLs instead? How do you keep the
overview over 70 domains and filesystems with 188 file types?

How many domains are for single users only?

> I don't think that supporting arbitrary numbers of domains and types
> has much affect on the performance of our TE implementation.

Access control decisions in RC model are based on bit vectors, combined by
simple and fast logical operations, e.g. if(a & b).  So the limit to 64 bits by
the largest integer type was natural. An unlimited scheme would have needed
lists with search operations or at least dynamical arrays.

> > > RSBAC does not appear to have an equivalent
> > > to the human-readable SELinux policy configuration files, and it requires
> > > that the policy be configured through a set of new utilities that use new
> > > system calls. 
> > 
> > As explained above, I believe separate mechanisms for RSBAC administration to
> > be a much better solution than hacking it into existing interfaces. What is the
> > problem with some extra system calls?
> 
> I probably wasn't clear.  With SELinux, you edit the human-readable policy
> configuration files to set up your policy (starting with the example
> configuration we provide if you want), then compile that policy
> into a binary representation and install it.  You can then load
> the updated policy into your running kernel (if the policy authorizes
> such runtime changes) using a new system call, or you can reboot
> (in which case the kernel will load the new policy when it
> initializes).  My concern was with the need to run a special
> set of utilities that use a special set of system calls to
> customize the configuration, as opposed to being able to edit
> human-readable configuration files.

To keep in these terms: With RSBAC, you can either
1) change your model implementation module, recompile and replace the old one
(under control of the old module), or
2) Make a backup script out of your configuration settings, modify the
(human readable) script and run it to get the new settings.

For security reasons, RSBAC does not allow to modify the settings file
directly, but you could simply run a setup script at boot time - if this script
is allowed to modify the settings.

Out of interest: How is your binary policy representation protected against
unwanted modification?

Amon.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
