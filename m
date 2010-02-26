Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1Q1eDT1020391
	for <selinux@tycho.nsa.gov>; Thu, 25 Feb 2010 20:40:14 -0500
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1Q1duon005645
	for <selinux@tycho.nsa.gov>; Fri, 26 Feb 2010 01:39:56 GMT
Message-ID: <4B872673.4030806@manicmethod.com>
Date: Thu, 25 Feb 2010 20:40:03 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patch to run genhomedircon without looking at /etc/passwd
References: <4B86E6CC.9000405@redhat.com>
In-Reply-To: <4B86E6CC.9000405@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Daniel J Walsh wrote:
> I want to change the default of libsemanage to not look for home 
> directories in getpwent.  This patch allows you to set the flag 
> usepasswd=false in the semanage.conf file. and genhomedircon will only 
> setup the labeling of /home, /export/home and any confined users 
> homedirs.
>
> If this patch is not acceptable because libsemanage is being 
> rewritten, I would like the functionality to be added to the new 
> libsemanage. 

This looks completely reasonable. Interesting that the function always 
supported turning it off but we never exposed that.

As a side note, libsemanage isn't being rewritten, some of it may go 
away some day but not anytime soon (at least not until CIL is able to 
fill in all the gaps).

Acked-by: Joshua Brindle <method@manicmethod.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
