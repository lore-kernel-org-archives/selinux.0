Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i29E6FRb012423
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 09:06:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i29E4X6Q027314
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 14:04:33 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i29E4V5t027154
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 14:04:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: XFS and SE Linux
Date: Wed, 10 Mar 2004 01:04:46 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200403100014.03542.russell@coker.com.au> <1078840842.4022.32.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1078840842.4022.32.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403100104.46690.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 10 Mar 2004 01:00, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Tue, 2004-03-09 at 08:14, Russell Coker wrote:
> > Currently in SE Linux the contexts for files are of the form
> > "system_u:object_r:file_t", why not express them on disk as
> > "system_u:file_t"?  Saving 9 bytes in this manner could make some of them
> > fit into a 256 byte Inode in XFS which would be a significant advantage. 
> > Also for Ext2/Ext3 it will save some space as well.
>
> Why not just fix XFS to handle xattrs sanely?

I have sent an email to some SGI people with some ideas that I think would be 
beneficial.  However doing such changes would take some time.  They need to 
have some sort of compatibility flag in the on-disk structure, some new data 
structures on disk, and a new fsck that understands both old and new formats.  
This isn't going to happen overnight.  While a change to the way 
security.selinux is used by the kernel can be implemented much more easily.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
