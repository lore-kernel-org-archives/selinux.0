Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o26NDJLA007546
	for <selinux@tycho.nsa.gov>; Sat, 6 Mar 2010 18:13:19 -0500
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o26NDihB003502
	for <selinux@tycho.nsa.gov>; Sat, 6 Mar 2010 23:13:44 GMT
Message-ID: <4B92E188.3050901@manicmethod.com>
Date: Sat, 06 Mar 2010 18:13:12 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patch to run genhomedircon without looking at /etc/passwd
References: <4B86E6CC.9000405@redhat.com> <4B872673.4030806@manicmethod.com>
In-Reply-To: <4B872673.4030806@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>
>
> Daniel J Walsh wrote:
>> I want to change the default of libsemanage to not look for home
>> directories in getpwent. This patch allows you to set the flag
>> usepasswd=false in the semanage.conf file. and genhomedircon will only
>> setup the labeling of /home, /export/home and any confined users
>> homedirs.
>>
>> If this patch is not acceptable because libsemanage is being
>> rewritten, I would like the functionality to be added to the new
>> libsemanage.
>
> This looks completely reasonable. Interesting that the function always
> supported turning it off but we never exposed that.
>
> As a side note, libsemanage isn't being rewritten, some of it may go
> away some day but not anytime soon (at least not until CIL is able to
> fill in all the gaps).
>
> Acked-by: Joshua Brindle <method@manicmethod.com>

Merged in libsemanage 2.0.45

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
