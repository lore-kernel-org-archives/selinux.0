Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3K9S17C029001
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 05:28:01 -0400 (EDT)
Received: from smtp10.atl.mindspring.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3K9KTqS018016
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 09:20:29 GMT
Message-ID: <42661F69.30102@mindspring.com>
Date: Wed, 20 Apr 2005 05:22:49 -0400
From: Richard Hally <rhally@mindspring.com>
MIME-Version: 1.0
To: russell@coker.com.au,
   "Fedora SELinux support list for users &amp; developers." <fedora-selinux-list@redhat.com>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Experiences with selinux enabled targetted on Fedora Core 3
References: <20050221160539.6aba22bd.r.godzilla@comcast.net>	<200504191421.01381.russell@coker.com.au>	<143f0f6c050419060714ce0f8d@mail.gmail.com> <200504201621.46953.russell@coker.com.au>
In-Reply-To: <200504201621.46953.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Tuesday 19 April 2005 23:07, "Christofer C. Bell" 
><christofer.c.bell@gmail.com> wrote:
>  
>
>>On 4/18/05, Russell Coker <russell@coker.com.au> wrote:
>>    
>>
>>>On Tuesday 19 April 2005 12:25, Valdis.Kletnieks@vt.edu wrote:
>>>      
>>>
>>>>Personally, I'm not thrilled by the idea of sticking in dontaudit rules
>>>>to quiet complaints at boot time that are caused by directories that
>>>>are mislabelled.
>>>>        
>>>>
>>>Why not?
>>>      
>>>
>>I can't speak for Valdis, but for me the word "kludge" comes to mind.
>>    
>>
>
>It's not a kludge.  The purpose of dontaudit rules is to prevent auditing of 
>operations that are not permitted, not interesting, and expected to happen.  
>This is exactly the situation.
>
>Using dontaudit rules for such things also gives correct behavior in 
>situations where relabelling will not.  As an example there is the following 
>rule:
>dontaudit lvm_t file_t:dir search;
>
>Without this rule the lvm utilities when run before /var is mounted would 
>create the /var/lock directory on the mount-point.  This is not desired 
>functionality, the machine is in single-user mode at the time (so the lack of 
>locking is not a problem) and creating directories that later get hidden by 
>mounting a file system is not desirable.
>
>So far no-one has provided any reasons not to use dontaudit rules.  
>Accusations of kludging don't count as a reason.
>
>I don't consider file_t labelling for a mount point as "mislabelling".  The 
>mount point directory is expected to be hidden, so generally only mount needs 
>to access it.
>
>  
>
I for one consider the use of "dontaudit" to be unethical but that is 
just my opinion.
Think about preventing someone's software from doing what was designed 
and implemented to do. Shouldn't you at least notify the 
developer/maintainer that there is a problem with their software? That 
seems to be the correct thing to do in the open source community.
If there is a actual security problem shouldn't there be some 
notification of the vulnerability as a minimum? If it is not an actual 
security vulnerability but perhaps a theoretical one, a proof of concept 
is usually appropriate.
If it is a violation of some generally accepted standard, isn't a 
bugzilla the right thing to do?
If it is a "bad idea" according to some peculiar distro's group-think 
approach to Linux, isn't the thing to do, let the developer know what 
you think as a minimum?
If you have to use dontaudit rules to get "correct" behavior from some 
software doesn't that indicated that the software needs to be 
changed(better design or better implementation or RFE)?
If some software contains some "not desired functionality", isn't it 
incumbent upon the person that makes that assertion to at least explain 
the situation to the developer/maintainer so that they have the 
opportunity to make a change or refute the assertion?      
If some action by the software is "uninteresting" shouldn't it be 
allowed absent some reason that makes it in fact "interesting"?

Then there is the "conspiracy theory" point of view where someone says 
"Hey, NSA is using that SELinux to change the behavior of programs and 
not telling anyone that they are doing it."

I would like to hear what others think of  this "dontaudit considered 
harmful"  idea. I understand the use of dontaudit as a temporary 
expedient but other than that it seem that there should be more done 
about the situations where it is used at least in terms of notifying the 
developers/maintainers of the software involved.

Richard Hally


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
