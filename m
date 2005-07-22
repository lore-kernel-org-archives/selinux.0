Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MFxggA006790
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 11:59:43 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MFstYP028617
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:54:56 GMT
Message-ID: <42E116B8.2050406@tresys.com>
Date: Fri, 22 Jul 2005 11:54:32 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Casey Schaufler <casey@schaufler-ca.com>
CC: Karl MacMillan <kmacmillan@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, gyurdiev@redhat.com,
   selinux@tycho.nsa.gov
Subject: Re: Iptables discussion
References: <20050722154606.21958.qmail@web34309.mail.mud.yahoo.com>
In-Reply-To: <20050722154606.21958.qmail@web34309.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:

>--- Karl MacMillan <kmacmillan@tresys.com> wrote:
>
>
>  
>
>>I know that this is just a motivating example, but I
>>feel compelled to point out
>>that 1) this problem is not really related to MLS in
>>the real world and 
>>    
>>
>
>On the contrary, it is a commonly requested
>scenario, not always with web services but
>often enough. Frequently the situation is an
>application written and owned by a 3rd party
>that provides a "special" service of some kind.
>Running two servers, one at Secret, one at
>TopSecret is the mode they prefer.
>
>  
>
>>2)
>>separation based on ports is _very_ unlikely to meet
>>the requirements of a
>>system that will be processing data at different
>>sensitivities.
>>    
>>
>
>It is done all the time. Yes, policy enforcing
>trusted applications are better, but y'all don't
>seem to have an interface for doing that, and
>most users couldn't change the applications
>anyway.
>  
>
eh? we certainly have userspace object managers, some in production use 
such as dbus, passwd, cron, and others in development like SE-X

We are also working on better support for userspace object managers 
currently, such as adding a userspace security server for providing 
decisions to userspace object managers (thus reducing the policy in the 
kernel) and allowing object managers to register their object classes 
dynamically.

>In Trix 4 we had polyinstantiated sockets. We
>dropped them in Trix 6 to be more like the
>other systems available at the time. I don't
>think anyone noticed because everyone was
>already doing "a server per label".
>
>
>
>
>Casey Schaufler
>casey@schaufler-ca.com
>
>
>		
>____________________________________________________
>Start your day with Yahoo! - make it your home page 
>http://www.yahoo.com/r/hs 
> 
>
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
