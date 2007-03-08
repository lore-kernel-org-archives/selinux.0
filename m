Subject: Re: CKRM and SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Pravin <shindepravin@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <9d1b82480703080853v137069a7h338108de5dc1e480@mail.gmail.com>
References: <9d1b82480702262223o37921e5cubc8506efaa225e2d@mail.gmail.com>
	 <9d1b82480702262236r6cab8167qcf73a68f0fcd7c1@mail.gmail.com>
	 <1172581266.19041.312.camel@moss-spartans.epoch.ncsc.mil>
	 <9d1b82480702271307q45bfc167mff78dc03a6c9b482@mail.gmail.com>
	 <1172611097.19041.428.camel@moss-spartans.epoch.ncsc.mil>
	 <9d1b82480703080853v137069a7h338108de5dc1e480@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 12:00:23 -0500
Message-Id: <1173373223.10467.112.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 22:23 +0530, Pravin wrote:
> > I think you misunderstand my intent - I'm not talking about control over
> > resource management decisions; I'm talking about ensuring that the
> > interface used to configure CKRM (e.g. the pseudo filesystem interface)
> > can be properly access controlled via SELinux.  At more than just a
> > global "can I configure CKRM or not?" granularity, ideally.
> 
> Please correct me if I am wrong here.
> One of the way to configure CKRM is to use pseudo filesystem called "configfs".
> I am not very sure but I think that in order to have access control on
> this "configfs", we already have security context assosicated
> "configfs" filesystem,
> If we write policies on these security contexts, we can have quite
> fine grained access control over CKRM configuration, just like any
> other file-system.

That usually isn't adequate for control; you'd have a single security
context on all configfs files (unless you introduce support for
individual labeling of them), and the file-level interface may not be
sufficiently granular (e.g. you can say "only process P can write to
configfs files", but you can't say "process P can only configure
resource limits for particular security contexts".  To do that, you need
security hooks in the underlying code at the appropriate points where
you have enough semantic information to make a security check.  As a
simple example, consider the cpuset pseudo filesystem.  Processes may
write a pid in string form to one of the files in order to act on the
process with that pid.  Simply controlling writes to the file doesn't
enable us to control what processes you can affect; we needed a security
hook in that code after looking up the pid to check whether you could
affect that particular process (based on its context).

> Another way in which processes are grouped into classes for CKRM is
> when they are getting created.
> Here, they inherit the class of their parent.
> I was considering the possibility of using security-context of process
> and some policies ( these policies can be similar to selinux policies
> which can use role, type, user of security-context ) which will decide
> the class of new process.
> 
> There is Rule Based Classification Engine which already automiatically
> classifies processes into classes depending on task parameters ( pid,
> gid, uid, executable ).
> I am considering the possibility of having similar classification
> Engine which will be using security-context's and policies based on
> these context to do the classification.

To do that for security contexts, you need to interact with the SELinux
policy engine, because only it can interpret security contexts and make
sense of them.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
