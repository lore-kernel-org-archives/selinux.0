Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA03342
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 16:35:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA00869
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 21:33:36 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id VAA00865 for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 21:33:36 GMT
Message-Id: <200211292142.QAA23944@moss-shockers.ncsc.mil>
Date: Fri, 29 Nov 2002 16:42:59 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: label transitions
To: selinux@tycho.nsa.gov, giorgio.zanin@inwind.it
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I'm now investigating the mechanism used in SELinux to change 
> something's security label.
> I know there is a kernel interface and a system call for applications  
> to do it, their name is security_transition_sid.

Not exactly.  security_transition_sid is an interface for obtaining
labeling/transition decisions, e.g. to obtain the default label for a process
transformed by execve or to obtain the default label for a newly created object.
It is strictly a policy decision interface; it does not relabel anything. 
Labeling/transition decisions are a fundamental concept; you'll see them
discussed in the Flask architecture paper as well as the more recent
technical reports.  The SELinux kernel code calls this interface
when a process is transformed or when a new object is created.

security_change_sid is an interface for obtaining relabeling decisions,
e.g. to obtain the SID to use when relabeling a tty for a user session
based on the session's security label.  It is also a policy decision interface; 
it does not relabel anything.  This is not used by the kernel at all, and was 
only added to support functionality like tty relabeling in a policy-independent
manner.

chsid is an interface for changing the SID of an existing file to
a given SID.  An application can pass any SID to chsid, but the policy must
authorize the corresponding relabelfrom and relabelto permissions.
Some applications (e.g. login) will call security_change_sid to
obtain a relabeling SID and will then call chsid with that SID.
But other applications (e.g. setfiles) will just call chsid
with a SID computed in some other manner, e.g. the file contexts
configuration.

> The configuration language has two constructs: type_transition and 
> type_change. The first is used by the kernel and instructs the security 
> server to return a particular label for a type pair and a class when the 
> security_transition_sid is called to label a new object or a transformed 
> process.

Right.  security_transition_sid is computed based on the type_transition
rules in the policy.  security_change_sid is computed based on the
type_change rules in the policy.

> If type_transition is used to label a transformed process, it requires 
> the transition permission of the class process.

You need more than just process transition permission.  See the
domain_trans macro.

> What about type_transition for files? I mean I had a look at 
> file_trans_macro and it seems it's not specified anything like the 
> transition process permission to change the type of a file. How can I 
> control the privilege to change the type of a new object?
> 
> Is it correct to argue that permissions relabelto, relabelfrom and 
> transition of file class are used to grant applications the ability to 
> change labels with a call to security_transition_sid (with the output 
> label specified via type_change)?

The file_type_trans macro has to do with file creations, not relabeling.
Relabeling requires relabelfrom permission to the old SID and relabelto
permission to the new SID (from the current process SID, in both cases).

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
