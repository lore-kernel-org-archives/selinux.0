Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA29799
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2002 14:40:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA08354
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2002 19:39:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA08348
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2002 19:39:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: devfs_contexts
Date: Thu, 24 Jan 2002 06:40:25 +1100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0201181241010.3743-100000@raven> <20020123020122.13E9F330083@lyta.coker.com.au> <200201231829.g0NIT0q32519@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200201231829.g0NIT0q32519@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DBPEKNZXWNDAIKYFOXYJ"
Message-Id: <20020123194026.04CD5110F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_DBPEKNZXWNDAIKYFOXYJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Thu, 24 Jan 2002 05:29, Richard Gooch wrote:
> > Do you think it would make sense to have a SE version of devfsd that
> > applied SE SID's at the same time as applying regular permissions to
> > devfs managed device nodes?  It makes sense to me to have both
> > regular file system permissions and SE sids applied at the same
> > time.
> >
> > I could do the devfsd patch in a small amount of time if desired
> > (I've written plenty of patches for devfsd already so I know the
> > code reasonably well).
> >
> > NB  I've CC'd Richard Gooch to get his opinions on this matter.
>
> First, can someone answer these questions:
>
> - how much code is required to support this

I have attached the source to chsid.c, the source for the chsid program.  It 
operates in a similar fashion to chown(1).  As you can see there isn't much 
code.  All I have to do is to parse the config file for an extra parameter.

At this stage I wouldn't be volunteering to write it if I though it would 
take a lot of code.  ;)

> - will it break compilation of devfsd on non-SELinux systems

I was thinking of putting #ifdef SELINUX around it all.

> - will an SELinux-enabled devfsd run on normal systems

Yes.  It can detect that there is no SE code running, log a warning message 
and just run with regular functionality.

> - what are these devfs_contexts and where are they kept

Currently devfs_contexts is compiled and stored in the database /ss_policy , 
the kernel loads that file and then processes it accordingly.

> - where are the SELinux SID's kept? In the VFS inode?

It appears to be in the inode in the VFS.

For regular file systems such as Ext2 and ReiserFS the inode number is used 
as an index to a per-file-system database of security permissions which is 
then consulted as necessary.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--------------Boundary-00=_DBPEKNZXWNDAIKYFOXYJ
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="chsid.c"
Content-Transfer-Encoding: base64
Content-Description: chsid.c
Content-Disposition: attachment; filename="chsid.c"

I2luY2x1ZGUgPGZzX3NlY3VyZS5oPgojaW5jbHVkZSA8c3MuaD4KI2luY2x1ZGUgPHN0ZGxpYi5o
PgoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQp7CglzZWN1cml0eV9pZF90IHNpZDsK
CWludCByYywgaTsKCglpZiAoYXJnYyA8IDMpIHsKCQlwcmludGYoInVzYWdlOiAgJXMgc2lkL2Nv
bnRleHQgcGF0aG5hbWUuLi5cbiIsIGFyZ3ZbMF0pOwoJCWV4aXQoMSk7Cgl9CgoJc2lkID0gYXRv
aShhcmd2WzFdKTsKCWlmICghc2lkKSB7CgkJcmMgPSBzZWN1cml0eV9jb250ZXh0X3RvX3NpZChh
cmd2WzFdLCBzdHJsZW4oYXJndlsxXSkgKyAxLAoJCQkJCSAgICAgJnNpZCk7CgkJaWYgKHJjKSB7
CgkJCXBlcnJvcihhcmd2WzFdKTsKCQkJZXhpdCgxKTsKCQl9Cgl9CgoJZm9yIChpID0gMjsgaSA8
IGFyZ2M7IGkrKykgewoJCWlmIChjaHNpZChhcmd2W2ldLCBzaWQpIDwgMCkgewoJCQlwZXJyb3Io
YXJndltpXSk7CgkJCWV4aXQoMik7CgkJfQoJfQoKCWV4aXQoMCk7Cn0K

--------------Boundary-00=_DBPEKNZXWNDAIKYFOXYJ--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
