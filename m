Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1QNdARb009480
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 18:39:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1QNbYlK018227
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 23:37:34 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id i1QNbXOX018224
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 23:37:34 GMT
Date: Thu, 26 Feb 2004 23:39:00 +0000
From: Dale Amon <amon@vnl.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Proposed patch to policy file_contexts
Message-ID: <20040226233900.GB22602@vnl.com>
References: <403E52AD.5090103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <403E52AD.5090103@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Feb 26, 2004 at 03:10:21PM -0500, Daniel J Walsh wrote:
> Since the file_contexts file is now being build with m4, I am proposing 
> this patch to allow for simpler specifications of alternate 
> homedirectories or staff users.
> 
> As we are roling this out we are finding many users placing their 
> homedirectories in the non standard location.
> 
> What do you think?

Now that you mention it, I resemble that remark. I
do (on some systems) place my administrative accounts
on a different drive than user home dirs. I hadn't
run across the problem yet because my test systems
are dead normal.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
