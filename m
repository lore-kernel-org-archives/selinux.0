Date: Sat, 29 May 2004 09:51:53 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <jbrindle@snu.edu>
Cc: SELinux <SELinux@tycho.nsa.gov>, tng-technical@lists.samba-tng.org,
   samba-technical@samba.org
Subject: Re: se-samba
Message-ID: <20040529095153.GB16927@lkcl.net>
References: <40ACFC0C.9020101@snu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40ACFC0C.9020101@snu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 20, 2004 at 01:42:20PM -0500, Joshua Brindle wrote:
> A few of us talked about samba at a get together a few weeks ago and 
> since it seems like we have a new ambition user on the list who is part 
> of the samba-tng team I thought I'd bring this up.
> 
> Apparently Luke Kenneth Casson Leighton is part of the samba-tng team? 
> (correct me if I'm wrong) So I'll lay out what we talked about for 
> getting samba to support selinux in a meaningful way.
> 
> Basically the idea is that samba runs in it's own domain (ofcourse), but 
> this domain has to be able to access/read/write files in other domains, 
> particularly user domains. However we want the same enforcements over 
> samba that a user would get on the local system, so the idea is to make 
> samba use the userspace-avc library to do permission validation before 
> it allows any access by the user. This would allow samba to access all 
> user files which it has permission to, but rely on it to validate the 
> connecting users permissions by passing the request to the userspace 
> avc. This wouldn't be hard to implement but I'm curious to hear what 
> someone who works on samba thinks of the idea..

hi joshua,

okay, i've calmed down, now.  you weren't to know that even after
three years any mention of samba still hurts like hell.

anyway.  to recap, and also to alert people on the samba mailing lists:
SE/Linux does not provide an equivalent to the seteuid call, for security
reasons, and so a complete redesign / series of workarounds is required.


1) doing user-space avc library calls is fine IF you can guarantee
that the file system to which you are providing access is NOT
accessible by any means other than through se-samba [or that
any such access guarantees no race conditions].

i.e. you must, in effect, write your own userspace file system.

and you must guarantee that there are no race conditions etc.

as an example, given that DCE/DFS is an entirely userspace file server,
at least you know it can be done.

[and so is AFS, which is (oh it's a long story) sort-of DCE/DFS
 version 3 without the DCE/RPC bits and its own RPC system,
 gone off in a different direction, and then DCE/DFS got a
 rewrite and was called v4 etc etc. ]


as an example of what NOT to do, you MUST NOT create a file as root,
then chown it to the new user.  another process could, in the
meantime, access the file in between its creation and chowning,
and you're toast.

if you absolutely MUST do that, then at least create the file
as root in a guaranteed (for a given value of guaranteed of course)
isolated directory (on the same filesystem as the
target one), chown it and then mv it to the required location
[but it's still a bad idea].

... and that's just file create: what about everything else?  can
you guarantee that in between the last userspace avc call to
check access permissions that an NFS client, as root, hasn't
chown'd or recreated the same file?

hence you must ban all uncontrolled access and effectively you
need an isolated userspace file system.

_some_ commercial SMB fileserver companies _have_ actually done this!!


2) all file operations go through the SMB layer: you have to
provide a means to separate user-contexts on the same SMB TCP
connection, and the best - i.e. quickest way with a minimal
coding impact - way to do that is to run two smbd servers,
one proxying to the other and to write an SMB client VFS plugin
that multiplexes out the user-contexts received over the same
TCP connection.


3) an alternative is a rewrite to replace the SMB client VFS
plugin idea with a purpose built inter-process communication
system.


... although to be absolutely honest, when you already _have_
a dedicated IPC mechanism - it's called the SMB protocol - then
why go to all the trouble of writing another one?

arguments for doing your own VFS-dedicated IPC mechamism:

- the samba VFS layer isn't _exactly_ the SMB protocol in
other words you would have to hand-code every single function
in the

- samba's own smbclient code (libsmbclient) is unlikely
to be complete / an exact match for the known complexities
etc. heuristics etc. that have been built up over the last XX
man-years of work over the last X years of its life.

therefore, coding-wise, it's 1) pretty much automatic to auto-generate
an IPC mechanism based on the Samba VFS header files.  2) there
is a lot less to audit.  3) there is no need to hand-write all
fifty VFS layer functions, which you would have to do if you
went down the SMB client VFS layer route.

l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
