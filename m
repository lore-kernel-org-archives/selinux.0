Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9RIVCXZ023321
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 14:31:12 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9RITqrR019081
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 18:29:54 GMT
Date: Wed, 27 Oct 2004 14:31:02 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [PATCH] devpts xattr support
In-Reply-To: <417FE499.3040405@trustedcs.com>
Message-ID: <Xine.LNX.4.44.0410271428590.10702-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 27 Oct 2004, Darrel Goeddel wrote:

> I'm all for that.  I will play around with a few ideas and see if I can 
> come with anything useful.  I'm thinking along the lines of the 
> permission call which uses i_op->permission if it exists and falls back 
> to vfs_permission if it does not.  Maybe we can create a fallback for 
> *xattr...

Yes, it seems logical that we could have a generic fallback in the VFS
code for getxattr and listxattr, although I guess this would have been
considered before and rejected for some reason (possibly advice from
upstream?).


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
