Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k13JcmXf003784
	for <selinux@tycho.nsa.gov>; Fri, 3 Feb 2006 14:38:48 -0500 (EST)
Received: from mail6.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k13JcZt5001937
	for <selinux@tycho.nsa.gov>; Fri, 3 Feb 2006 19:38:36 GMT
Date: Fri, 3 Feb 2006 14:31:43 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Russell Coker <russell@coker.com.au>
cc: SELinux List <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: MCS policy patch
In-Reply-To: <200602040118.10784.russell@coker.com.au>
Message-ID: <Pine.LNX.4.64.0602031422070.4965@excalibur.intercode>
References: <200602040118.10784.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 4 Feb 2006, Russell Coker wrote:

> The attached patch makes MCS a discretionary policy instead of being an 
> advisory policy as it is at the moment.  This denies a process the ability to 
> launch, kill, or ptrace a process unless it's level dominates that of the 
> target process.  

Ok, I think this makes sense, to stop a malicious process from launching a 
program at a higher level to bypass the category restrictions.  However, 
it raises the question of whether we have all such channels locked down.

Also, do we need dynamic transitions at all in MCS?

> Also the same restriction is placed on creation and relabelto for files, 
> directories etc.

I thought we already had this.

> It still doesn't place any MCS restrictions on read/write for file system 
> objects other than files, but allowing for example a process to create a 
> directory in a context that it could not relabel a directory to or from is 
> bogus.

I'm still not sure what the best model is for directories.  I've had a 
couple of people email and say they want files created under an MCS 
labeled directory to inherit the label.

I like the idea of keeping things as absolutely as simple as possible, and 
leaving MCS as a user-oriented discretionary tool, where the end user (and 
not the admin) is responsible for labeling all of their own files 
indivdually.

> Also my patch denies the ability to create file system objects with ranges.  
> We have no way of using such ranges so I believe that we don't want them 
> created.

Yep, they are pointless in MCS.

> Dan, is it too late for this to be in FC5T3?  I've intentionally removed all 
> the bits that are complex or likely to cause breakage from this patch to 
> allow it to be included...

It looks ok to me, but I'd appreciate any further review.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
