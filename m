Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hARFjBRb024466
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 10:45:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hARFiZp5000168
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 15:44:36 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
	by jazzswing.ncsc.mil  with ESMTP id hARFiZt0000165
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 15:44:35 GMT
Message-ID: <3FC61C05.90400@diyab.net>
Date: Thu, 27 Nov 2003 10:45:09 -0500
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: BSD Secure levels for linux
References: <3FC54560.5050303@diyab.net> <200311271326.53583.russell@coker.com.au>
In-Reply-To: <200311271326.53583.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

> On Thu, 27 Nov 2003 11:29, Diyab <diyab@diyab.net> wrote:
> 
>>Has anyone else run across the kernel patch that implements something
>>similar to the BSD secure levels?  Has anyone tried to use this with
>>selinux?  I'm also curious what the general thought of the idea is.
>>Good idea? Bad idea?  What do you think?
> 
> 
> The concept of secure levels is to have an option to put the system into a 
> mode where module loading and various other things are denied.
> 
> You could of course have a SE Linux configuration where you have multiple 
> policydb binaries, the one that loads on boot would have the current 
> functionality.  Other policydb's would have limited functionality (EG prevent 
> insmod_t from doing anything other than sending sigchld to init_t and 
> preventing load_policy).  Then loading a new policy would give a similar 
> result to changing a BSD secure level.

I never thought about something like that.  On the plus side not only 
would you have more control over what your specific "levels" will do but 
you can easily and securely switch between levels.  The patch I 
mentioned does not have that functionality.

> 
> If someone else wants to make a start on this then I would be interested in 
> merging patches into my policy tree as I think that the functionality is 
> useful.
> 

I'm going to try this when I get a chance. I do not have time to do it 
right away though.

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
