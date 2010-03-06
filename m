Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o26NDJLB007546
	for <selinux@tycho.nsa.gov>; Sat, 6 Mar 2010 18:13:21 -0500
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o26NDYhB003342
	for <selinux@tycho.nsa.gov>; Sat, 6 Mar 2010 23:13:35 GMT
Message-ID: <4B92E170.1070804@manicmethod.com>
Date: Sat, 06 Mar 2010 18:12:48 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Last attempt at upstreaming semodule_disable patch.
References: <4B858311.1010003@redhat.com> <4B92DC33.4010605@manicmethod.com>
In-Reply-To: <4B92DC33.4010605@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> This patch allows you to disable/Enable policy modules.
>>
>> It never seems to get upstreamed. :^(
>
> Acked-By: Joshua Brindle <method@manicmethod.com>
>
> Applied the attached patch on top of it, it fixes an implicit
> declaration warning, makes the errors for disabling or enabling an
> already disabled or enabled module nicer and fixes a comment.
>

Merged in libsemanage 2.0.45

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
