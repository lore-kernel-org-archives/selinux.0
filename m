Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA28413
	for <selinux@tycho.nsa.gov>; Fri, 1 Feb 2002 15:26:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA06258
	for <selinux@tycho.nsa.gov>; Fri, 1 Feb 2002 20:25:28 GMT
Received: from vorpal.mcs.drexel.edu (vorpal.mcs.drexel.edu [129.25.6.250])
        by jazzband.ncsc.mil  with ESMTP id UAA06254 for <selinux@tycho.nsa.gov>; Fri, 1 Feb 2002 20:25:27 GMT
Subject: Re: Strange behavior of httpd
From: Justin Smith <jsmith@mcs.drexel.edu>
To: Jen Schommer <jschommer@mitre.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3C5ADC13.A4B39A60@mitre.org>
References: <1012394639.1422.6.camel@jsmith.org>
	<3C5ADC13.A4B39A60@mitre.org>
Content-Type: text/plain
Date: 01 Feb 2002 15:21:43 -0500
Message-Id: <1012594903.9496.14.camel@vorpal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2002-02-01 at 13:18, Jen Schommer wrote:
> Justin,
> 
> I worked on the example Apache policy for Selinux.  
> 
> The files you reference seem to be semaphore files.  Apache is using
> these files to globally synchronize two or more of it's processes. The
> behavior you describe seems legitimate, therefor it is ok to create
> these types and give Apache permisison to them. The same will be done
> for the example Apache policy in Selinux. 
> 
> I am not sure what changed in the Apache environment, where the policy
> is running, to make Apache want to globally synchronzie it's proceses. 
> 
> Jen


Thank you very much! 

I'm running a very active server with Apache interfacing a Tomcat
servlet/jsp engine and it becomes particularly active during exam time
(when more than 100 students submit their online exams in a short time).

It doesn't astound me that apache wants to synchronize its resources. I
didn't know that it used a file like this to do it. Perhaps the resource
in question is the mod_jk.so file...

Thanks again. This list is fantastic!
-- 
______________________________________________________________________
Time blows wildly against my door       | Justin R. Smith
Stirring discarded sorrows      	| Department of Mathematics and
Like dead leaves of summers past        |     Computer Science
Memories of forgotten lore          	| Drexel University
Making way for new tomorrows         	| Philadelphia, PA 19104
New hopes, new fears,                   |
         and new ways that last         | Office: (215) 895-1847
URL: http://vorpal.mcs.drexel.edu       | Fax:    (215) 895-1582



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
