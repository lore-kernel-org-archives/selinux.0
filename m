Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7EFpIQ4025529
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 11:51:18 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7EFokCQ029587
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 15:50:47 GMT
Message-ID: <4A8587D4.2040208@redhat.com>
Date: Fri, 14 Aug 2009 11:50:44 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Stefano Carucci <stecarucci@hotmail.com>, selinux@tycho.nsa.gov
Subject: Re: SElinux protection
References: <SNT115-W6FF8468946D002609BC73C1020@phx.gbl> <alpine.LRH.2.00.0908142117440.17571@tundra.namei.org> <SNT115-W34F722C08C53D234FB37CEC1020@phx.gbl> <alpine.LRH.2.00.0908142229560.18040@tundra.namei.org>
In-Reply-To: <alpine.LRH.2.00.0908142229560.18040@tundra.namei.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> 2. I read about the possibility of keeping processes from forking. 
>> Wouldn't you consider this as a protection from DoS attacks?
> 
> That could be effective in this case (as would resource limits), but 
> SELinux is not generally designed to counteract DoS attacks.

SELinux has the theoretical (has anyone done this yet) ability to take away "fork" from an entire process context, ie. killing all your webservers. This  isn't really protection so much as something you can do in reaction to an attack. Resource limits on the other hand actually provide a protection to this. Then again you can also just use kill at that point.

In response to your first question of what sort of attacks are inhibited the simple answer is that SELinux is a way of enforcing the intentions of application designers. In that sense SELinux doesn't prevent any application from being exploited it simply prevents exploited applications from doing anything they can't do anyway. The current fedora default policy targets servers as there a major source of exploits and usually behave in fairly standard ways, at least compared to user applications.

Chris Pardy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
