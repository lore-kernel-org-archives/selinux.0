Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA26316
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2002 04:05:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id JAA06968
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2002 09:04:13 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id JAA06951 for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2002 09:04:11 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <selinux@tycho.nsa.gov>
Subject: Re: devfs_contexts
Date: Wed, 23 Jan 2002 00:48:21 +1100
Cc: rgooch@ras.ucalgary.ca
References: <Pine.GSO.4.33.0201181241010.3743-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0201181241010.3743-100000@raven>
MIME-Version: 1.0
Message-Id: <20020123020122.13E9F330083@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 19 Jan 2002 04:50, Stephen Smalley wrote:
> For filesystems that use the persistent label mapping (e.g. ext2, ext3,
> reiserfs), the label will set by the chsid call be retained across reboots
> since it is stored in that mapping.  For pseudo filesystems like devfs,
> the label won't be retained across reboots unless you also add it to
> devfs_contexts, because there is no persistent storage of the label.  So,
> if you want the labels to persist, you'll need to update devfs_contexts
> and then reboot.

Do you think it would make sense to have a SE version of devfsd that applied 
SE SID's at the same time as applying regular permissions to devfs managed 
device nodes?  It makes sense to me to have both regular file system 
permissions and SE sids applied at the same time.

I could do the devfsd patch in a small amount of time if desired (I've 
written plenty of patches for devfsd already so I know the code reasonably 
well).

NB  I've CC'd Richard Gooch to get his opinions on this matter.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
