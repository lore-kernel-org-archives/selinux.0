Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3D2ZeDx001740
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2011 22:35:41 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3D2ZdsM020513
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2011 02:35:39 GMT
Message-ID: <4DA50BD4.1090505@windriver.com>
Date: Wed, 13 Apr 2011 10:35:00 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: qingtao.cao@windriver.com
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>
Subject: Re: Here is an updated Eric Paris patch for adding named file trans
 rules.
References: <4D9CD64B.7020207@redhat.com> <4DA454A8.7030005@tresys.com> <4DA47A02.400@redhat.com> <4DA49B88.3040300@redhat.com> <4DA4A602.9090702@tresys.com>
In-Reply-To: <4DA4A602.9090702@tresys.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Steve,

Sorry for all problems caused by me not having taken into consideration
the policy.X < 26.

Lesson learned, I am studying the patches from Dan and Eric now, I would
surely be more comprehensive for further SELinux development.

Thanks Dan and Eric for pointing the problems out and proving quick
solutions!

Best regards,
Harry

Steve Lawrence 写道:
> On 04/12/2011 02:35 PM, Daniel J Walsh wrote:
>   
>> It also has a fix for the ROLE_TRANS patch from Harry Ciao that was
>> blowing up when used with policy less then 26.  IE Everywhere.
>>
>>     
>
> Thanks for the patch. I'm looking into it right now.
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
