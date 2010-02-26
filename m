Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1Q1jcfO020742
	for <selinux@tycho.nsa.gov>; Thu, 25 Feb 2010 20:45:38 -0500
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1Q1jMon006707
	for <selinux@tycho.nsa.gov>; Fri, 26 Feb 2010 01:45:22 GMT
Message-ID: <4B8727BA.7090705@manicmethod.com>
Date: Thu, 25 Feb 2010 20:45:30 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Fix memory leak on disabled selinux machines.
References: <4B857AD3.4090701@redhat.com>
In-Reply-To: <4B857AD3.4090701@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Daniel J Walsh wrote:
> I think this patch originally came from Eric Paris and was updated by 
> others but has not been adopted yet.  Not sure why.
>
> Always free buf on exit. 

Acked-by: Joshua Brindle <method@manicmethod.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
