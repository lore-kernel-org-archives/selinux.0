Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0UC2e53003428
	for <selinux@tycho.nsa.gov>; Sun, 30 Jan 2005 07:02:40 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0UC2hVa013703
	for <selinux@tycho.nsa.gov>; Sun, 30 Jan 2005 12:02:43 GMT
Date: Sun, 30 Jan 2005 12:13:02 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: abo@kth.se, openafs-devel@openafs.org, opendce@opengroup.org,
   selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: Re: Using fuse for AFS/DFS (was Re: [OpenAFS-devel] openafs / opendfs collaboration)
Message-ID: <20050130121301.GB10895@lkcl.net>
References: <Pine.A41.4.31.0501181606230.24934-100000@slickville.cac.psu.edu> <Pine.GSO.4.61-042.0501210900060.15636@johnstown.andrew.cmu.edu> <20050121152803.GB29598@jadzia.bu.edu> <Pine.GSO.4.61-042.0501211222080.15636@johnstown.andrew.cmu.edu> <1106923508.7063.37.camel@tudor.e.kth.se> <20050130033020.GE6357@lkcl.net> <E1CvD0q-0006To-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1CvD0q-0006To-00@dorka.pomaz.szeredi.hu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jan 30, 2005 at 12:13:04PM +0100, Miklos Szeredi wrote:
> > > *) Last time I looked at FUSE the security model was: If the current uid
> > > equals the owner of the mountpoint then forward the request to the
> > > userland daemon, without any authentication information like for example
> > > the current uid. This might have or could be changed though.
> > 
> >  as of 2.6.7-ish (last time i looked: 2.5 months) there was
> >  no forwarding of security: in fact there was nothing in any of the
> >  APIs about security at all: in fact, root as a user was banned (with
> >  good justification iirc)
> 
> There are two choices for the security model in FUSE.  The first
> choice is that the userspace filesystem does the permission checking
> in each operation.  Current uid and gid is available, group list is
> presently not.

> The other choice is that the kernel does the normal file mode based
> permission checking.  Obviously in this case the filesystem can still
> implement an additional (stricter) permission policy.

 if your users are okay with having to run a fuse-mount themselves,
 that's okay [to have the kernel do the file mode checking]

 the problem with that is that you can't have a "publicly accessible"
 mount point like you do on an nfs server.

 also if you have a completely different kind of file permission
 checking system (which AFS and DFS do), you're stuffed.


> The "root banning" issue is in fact orthogonal to this.  The default
> operation is that only the user who mounted the filesystem is allowed
> to access the contents.  This behavior can be switched off with a
> mount option, to allow access to all users.
> 
> >  also, the xattr handling was (is?) non-existant and i had to add
> >  it,
> 
> Looking at the changelog it was added on 2004-03-30, so you must be
> using a pretty outdated version.
 
  ... Release 1.3 - 2004-07-14.

 hm, error-at-memory-recall fault, redo from start...

> >  but it was unsuitable for selinux, and that's a design mismatch
> >  between fuse's way of communicating with its userspace daemon (err
> >  -512 "please try later") and selinux's requirement for instant
> >  answers (inability to cope with err -512)
> 
> Heh?  Where did you see error value 512 (ERESTARTSYS)?  It's not
> something that the userspace daemon can return.
 
 userspace no, kernel, yes.

 the kernel-part of fuse tells any kernel-level callers to
 "go away, come back later".

 obviously this gives time for the kernel-part to "wake up" the
 userspace daemon, obtain an answer, such that when the kernel-level
 caller _does_ come back, the information is available.

 the problem with using SELinux to obtain xattrs
 "security.selinux" in order to perform security checks
 is that the checking is done from in the kernel ITSELF
 (security/hooks.c), not by a userspace function call RESULTING
 in a kernel call.

 therefore when you even attempt to _mount_ a selinux-enabled fuse
 filesystem, hooks.c tests to see whether the filesystem supports
 xattrs, gets this silly 512 (ERESTARTSYS) error message and goes "nope,
 doesn't look like it does".

 for various reasons, the details of which i am not aware of,
 from what i can gather, getting selinux to support ERESTARTSYS
 is tricky.


> >  so i started to look at lufs instead, which appeared to be a much
> >  cleaner design.
> 
> That's pretty subjective.  Please back up your statement with concrete
> examples, so maybe then I can do something about it.

 i must apologise for not having sufficient time _at present_
 to do that: please i would therefore as you to treat my
 statement _as_ subjective until/unless demonstrated otherwise.

 sorry about that.

> >  lufs expects the userspace daemon to handle and manage inodes,
> >  whereas fuse instead keeps an in-memory cache of inodes in
> >  the userspace daemon, does a hell of a lot of extra fstat'ing
> >  for you in order to guarantee file consistency, that sort of thing.
> 
> Well, how much "hell of a lot" actually is depends on a lot of things.
> E.g. on whether the backed up filesystem is modified externally (not
> just through the kernel).  If not, then it will stay consistent
> without any extra messaging.  This can be set by a timeout parameter
> for each looked up entry.
> 
> The extra flexibility offered by an inode based kernel interface
> (FUSE) instead of a path based one (LUFS) I think outweighs the
> disadvantage of having to once look up each path element.

 mrr, yehhh... mmmm :)
 
 what about a remote NTFS filesystem which supports NT Security
 Descriptors, which are "inherited" where you not only don't
 have the concept of inodes, but also due to the security
 model, a client must look up every path element _anyway_
 and perform a conglomeration of the "inheritance" parts of
 the ACEs in each security descriptor of the path components?

 :)

 btw so people don't freak out too badly at that concept,
 there _has_ existed for a couple of decades the concept of
 "change notify" in remote NT filesystems, where the client
 can watch for any significant changes on a filesystem, so you
 don't have to end up re-reading all of the path components,
 you can get the remote server to _tell_ you when they've
 changed - cool, huh?

 [btw, nt's change notify is what spurred linux kernel's inotify and
  dnotify to be written]

 
 in a nutshell, inodes is an optimisation from a unix
 perspective: by providing an inode based interface, you are
 burdening _all_ filesystem implementers with that concept.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
