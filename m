Message-ID: <41712F74.9020507@redhat.com>
Date: Sat, 16 Oct 2004 10:25:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Not sure the best way to handle this one.
References: <416FCFEB.90504@redhat.com> <200410162344.56706.russell@coker.com.au>
In-Reply-To: <200410162344.56706.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Fri, 15 Oct 2004 23:26, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>Oct 15 08:37:55 dhcppc1 kernel: audit(1097843874.920:692545): avc:
>>denied  { sys_module } for  pid=4338 exe=/usr/bin/nifd capability=16
>>scontext=system_u:system_r:howl_t tcontext=system_u:system_r:howl_t
>>tclass=capability
>>    
>>
>
>What is it trying to do?  Does an strace shed any light on the matter?
>
>  
>
Can't get it to happen regularly but I would submise that it is loading 
a network driver.  This
is happening on a laptop which switches from a builtin ethernet to a 
wireless pcmcia card. 
This behaviour might also occur with a docking station with a built in 
ethernet card.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
