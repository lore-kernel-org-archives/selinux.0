Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA21CbXZ002042
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 20:12:37 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA21CbfG018491
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 01:12:37 GMT
Message-ID: <4186DEE7.9040900@tresys.com>
Date: Mon, 01 Nov 2004 20:12:07 -0500
From: Karl MacMillan <kmacmillan@tresys.com>
MIME-Version: 1.0
To: Chad Hanson <chanson@TrustedCS.com>
CC: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions - a seteuid parallel
References: <36282A1733C57546BE392885C06185924D91F1@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C06185924D91F1@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Hanson wrote:

>Luke Kenneth Casson Leighton wrote:
>  
>
>>what are the alternatives?
>>
>>    
>>
>
>The alternatives are to overprivilege the application which is not
>acceptable or to rewrite all of the applications before they can be used on
>this new platform.
>

It is not clear to me how the application is not overprivileged already 
if it is allowed to freely change between a privileged and unprivileged 
domain. The application must be fully trusted with the maximum access 
that it is granted. A misbehaving application will simply not drop 
access (obviously). Additionally, it seems that from an analysis stand 
point, these domains must be treated as equivalent and so it is not 
clear how the argument can be made that this increases assurance.

Karl

>The latter is goal which can and should be achieved or
>time. Applications can streamlined and reorganized to fit into the modular
>framework and of cooperating applications. This is a considerable effort and
>major roadblock to utilizing SELinux and therefore Linux for these types of
>  
>

>The other main roadblocks are already being addressed with Linux getting
>CAPP EAL3 and soon to be EAL4 certifications. Add LSPP and RBAC and you have
>Linux system suitable to address secure information sharing needs.
>
>-Chad
>
>  
>
>>l.
>>
>>p.s. not that i actually understand MLS enough to understand 
>>any answers
>>[yet] but i'm just encouraging people to bounce ideas.
>>
>>
>>    
>>
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
