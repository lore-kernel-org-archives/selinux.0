Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA12724
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 13:13:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA15956
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 18:12:39 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id SAA15952 for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 18:12:38 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: devfs permissions
Date: Mon, 25 Feb 2002 19:13:26 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0202251238390.16566-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0202251238390.16566-100000@raven>
MIME-Version: 1.0
Message-Id: <20020225181326.AD2C713553@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Feb 2002 18:40, Stephen Smalley wrote:
> On Sun, 24 Feb 2002, Russell Coker wrote:
> > In either case we need to have devfsd manage SIDs on devfs nodes,
> > currently /dev/initctl and /dev/log don't get assigned a SID on devfs
> > (also other pipes and sockets would have the same problem - but aren't as
> > important and don't fail as spectacularly).
>
> Files created at runtime, such as /dev/initctl and /dev/log, should be
> labeled based on the file_type_auto_trans() rules that already exist for
> the appropriate domains.  Of course, the current rules assume that the
> parent directory type is device_t.  I see that you changed the / entry in
> devfs_contexts from device_t to devfs_t.  I'm not sure I agree with that
> change - it will require additional file_type_auto_trans rules for the
> devfs case.  Why not use device_t for both devfs and traditional /dev?

At the time it seemed like a good idea to have different permissions for 
devfs than for a regular directory, one reason for this is that there are 
system programs which have a genuine need for dynamically running mknod on a 
non-devfs system (such as LVM, and other systems that do similar things).  
Also on a non-devfs system an upgrade that installs a new version of the 
makedev package will generally want to install new device nodes (and 
sys-admins occasionally remove nodes they don't need or add nodes to match 
new hardware or drivers).  On a devfs system there are only three programs 
that should create anything under /dev, they are init, the devfsd startup 
script, and devfsd itself.

Having a different type for /dev on a devfs system is one way of locking 
things down to prevent mknod from being run.  Another way is to change the 
policy for device_t to prevent these things.  I'm still not certain which is 
the best option.

-- 
Signatures >4 lines are rude.  If you send email to me or to a mailing list
that I am subscribed to which has >4 lines of legalistic junk at the end
then you are specifically authorizing me to do whatever I wish with the
message (the sig won't be read).

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
