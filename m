Message-ID: <415AC4C0.8010008@redhat.com>
Date: Wed, 29 Sep 2004 10:20:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New policy diff
References: <415AAE8C.5050102@redhat.com> <200409300014.54730.russell@coker.com.au>
In-Reply-To: <200409300014.54730.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Wed, 29 Sep 2004 22:46, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>Added policy for vpnc.
>>Mailman location on redhat is changing.
>>More fixes for xinetd apps
>>    
>>
>
>can_exec(hotplug_t, hostname_exec_t)
>dontaudit hostname_t hotplug_t:fd { use };
>
>If hostname_exec_t is executed in domain hotplug_t then the dontaudit rule 
>will never be needed.
>  
>
Yes, I saw that, but there seems to be a way though transitions where 
hostname_t gets kicked off
from hotplug_t  (dhcpc_t or something), and there is a fd being used 
(Terminal?).

>+usr/lib/mailman/bin/mailmanctl -- system_u:object_r:mailman_mail_exec_t
>
>Typo, missing leading '/'.
>  
>
Oops please fix.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
