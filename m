Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JDtrgA006339
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 09:55:53 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JDpc3G013234
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 13:51:38 GMT
Message-ID: <42DD054E.1030301@redhat.com>
Date: Tue, 19 Jul 2005 09:51:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Casey Schaufler <casey@schaufler-ca.com>
CC: James Morris <jmorris@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: MCS/Targeted Policy...
References: <20050719000022.13983.qmail@web31602.mail.mud.yahoo.com>
In-Reply-To: <20050719000022.13983.qmail@web31602.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:

>--- James Morris <jmorris@redhat.com> wrote:
>
>
>  
>
>>They're permissive in comparison with MCS, which
>>does not permit any 
>>further access to objects.
>>    
>>
>
>I'm sorry. I give up. I do not understand
>what you're trying to tell me. I'll have to
>buy you a beer sometime and have you explain
>real slow like. Thanks for the effort.
>
>
>  
>
Let me try.  SELinux does not give any more access then standard DAC 
Controls.  So I would say SELinux is only restrictive  on top of 
Standard DAC.  ACL, however grant additional access over standard DAC, 
so they are permissive
on standard DAC.

>Casey Schaufler
>casey@schaufler-ca.com
>
>__________________________________________________
>Do You Yahoo!?
>Tired of spam?  Yahoo! Mail has the best spam protection around 
>http://mail.yahoo.com 
>  
>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
