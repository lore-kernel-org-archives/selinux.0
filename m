Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OL59sj029723
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 16:05:09 -0500 (EST)
Subject: Re: Sugg. for SELinux enabled Interpreters
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jochen Schmitt <Jochen@herr-schmitt.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <E1CtATI-0008Ib-00@mrelayng.kundenserver.de>
References: <E1CtATI-0008Ib-00@mrelayng.kundenserver.de>
Content-Type: text/plain
Message-Id: <1106600322.19246.270.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 Jan 2005 15:58:42 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-24 at 15:05, Jochen Schmitt wrote:
> Hallo,
> 
> I have bought a book about SELinux form O'Reilly. In this book it
> was discussed, that some applications, like KDE have issues with
> SELinux.
> 
> On KDE the problem is the kdeinit process, which coused, that
> SELinux can not distlinguish the diffent programms started by
> kdeinit.
> 
> So, I have the following idea:
> 
> 1.) Determinate the filecontext of a file based on the file name.
> 
> 2.) Calculate the destination transition based of the context of
> the file.
> 
> 3.) Make the transition.
> 
> I have create a patch for libselinux, which offers a function to
> determinate the destination context and an other function to make
> the transition.
> 
> I have uploaded the patch on:
> 
> http://www.herr-schmitt.de/pub/selinux/libselinux-getdestcon.patch
> 
> For testing, I have wrote a test programm, which you may find at:
> 
> http://www.herr-schmitt.de/pub/selinux/setest.c
> 
> But unfortunately, I have trouble with the third test, so I have
> put the audit log, which I have got on
> 
> http://www.herr-schmitt.de/pub/selinux/audit.txt
> 
> It will be happy for any comments and helps, becouse I am not
> very familar with SELinux.

Given your intended usage by interpreters, you should pass in the
descriptor to the file being interpreted, and use fgetfilecon rather
than getfilecon.  It isn't clear why you split the interface into two
functions, and it seems prone to leakage.  setcon() imposes a much
higher trust burden than setexeccon() on the application, so I'm not
clear on how this would be used safely, and there is a presumption that
the application has already undergone an exec-based transition at
startup to properly protect it from less trusted callers.  The error
suggests that you didn't authorize the role for the domain, i.e. role
system_r types setest_t;.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
