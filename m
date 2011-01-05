Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p05EahmM005448
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2011 09:36:43 -0500
Received: from smtp158.iad.emailsrvr.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p05EagcF000370
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2011 14:36:43 GMT
Subject: Re: libsemanage patch for MCS/MLS in user files
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Joe Nall <joe@nall.com>
In-Reply-To: <201101051930.26082.russell@coker.com.au>
Date: Wed, 5 Jan 2011 08:36:41 -0600
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
Message-Id: <0BDFF5FB-FDA3-4AAC-A851-D534AF4402E0@nall.com>
References: <201101051930.26082.russell@coker.com.au>
To: russell@coker.com.au
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jan 5, 2011, at 2:30 AM, Russell Coker wrote:

> The attached patch makes the 
> /etc/selinux/default/contexts/files/file_contexts.homedirs generation process 
> include the MCS/MLS level.
> 
> This means that if you have a user with a MCS/MLS level that isn't SystemLow 
> then their home directory will be labeled such that they can have read/write 
> access to it by default.
> 
> Unless anyone has any better ideas for how to solve this problem I will upload 
> this to Debian shortly.
> 
> What do the MLS users do in this situation?  Just relabel home directories 
> manually?

We don't have any users that are single level > SystemLow. I do think that is a
legitimate use case. We currently symlink most dot files into a polyinstatiated
directory to allow terminal windows and preferences to work at multiple levels.

You could polyinstantiate the home directory and not worry about the specific
level.

joe


> 
> 
> Finally it seems that when you run "semanage user -m" the 
> file_contexts.homedirs doesn't get updated, it's only when you run
> "semanage login -m" that it takes affect.
> 
> -- 
> russell@coker.com.au
> http://etbe.coker.com.au/          My Main Blog
> http://doc.coker.com.au/           My Documents Blog
> <diff>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
