Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA24490
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 14:09:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA18142
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 19:08:50 GMT
Received: from sendmail (savages.net [208.170.193.18] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id TAA18138
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 19:08:49 GMT
Message-ID: <3C447D5D.3030205@pcez.com>
Date: Tue, 15 Jan 2002 11:05:01 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
CC: selinux@tycho.nsa.gov
Subject: Re: General Users
References: <72222DC86846D411ABD300A0C9EB08A101524289@csoc-mail-box.csoconline.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think a new syntax for checkpolicy is needed.  This new tag would be 
"group"  This tag would the be assigned caps.  Then using kerberos or 
nis the group information is sent with the login.  There are issues I 
see with this

How do you temporary merge that user into the group in the policy.  You 
still want each user to be unique.  "Seperate but equal :-)"

The problem I see with this is "how do you verify the authorization of 
that group to that user"  If that "network" group information can effect 
the policy on that machine, how do you prevent corruption?

Just ideas
Shaun



Westerman, Mark wrote:

>The current implementation of SELinux requires each user to be listed in the
>user policy file
>and the default_context. This is great for single purpose server and
>workstation machines.
>I am currently look at a project that will require hundreds of machines and 
>thousands of users. The user name and password are propagated thru NIS. With
>
>the current implement of SELinux this makes the management of the machines
>non-workable. Requires to much system administration. User are added and 
>removed on a regular basis. We cannot rebuild a policy file for each machine
>for the 
>addition or removal of a user.
>
>
>What would be the best way to modify the current implement to create a
>standard
>user. I was thinking of setting up a standard user for the user policy file
>and 
>for the default context in the /etc/security (cron and default). I am
>looking at modifying
>the libsecure to look at the user, if the user is not found in the
>default_context file
>then assign him the standard user context.
>
>
>Any suggestions would be great.
>
>
>Mark Westerman
>
>--
>You have received this message because you are subscribed to the selinux list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>
>




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
