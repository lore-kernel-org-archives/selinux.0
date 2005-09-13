Message-ID: <4327425F.8050805@redhat.com>
Date: Tue, 13 Sep 2005 17:19:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Karl MacMillan <kmacmillan@tresys.com>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, SELinux <SELinux@tycho.nsa.gov>,
   Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: New ideas on implementation on libsetrans.
References: <43271BDA.3060403@redhat.com> <43272C09.3050105@trustedcs.com>	 <43272E92.4060400@redhat.com>	 <1126641222.29303.235.camel@moss-spartans.epoch.ncsc.mil>	 <432730B2.8090005@redhat.com>	 <1126641983.29303.249.camel@moss-spartans.epoch.ncsc.mil>	 <43273782.7070600@redhat.com> <1126643563.2940.6.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126643563.2940.6.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2005-09-13 at 16:33 -0400, Daniel J Walsh wrote:
>  
>
>>If no one is listening on  the socket or the socket does not exist you 
>>get the same behavior.
>>    
>>
>
>You get the same behavior (i.e. no translation), but the client-side
>code for the communication and caching is still in libselinux.  Whereas
>with it in libsetrans, you don't have that problem.  You just don't ship
>a libsetrans, and libselinux gracefully proceeds when the dlopen fails.
>
>Further, in the case where you do have translation, when you want to
>modify that translation protocol, you don't have to touch libselinux at
>all.
>
>  
>
>>I see packaging problems and requiring objects to link with -dl.  We are 
>>basically looking at a packaging problem
>>now, which is why we are bringing this up. 
>>    
>>
>
>I understand the issue with prelink due to being statically linked, but
>how many programs that link with libselinux are statically linked?
>Even /sbin/init is dynamically linked (surprisingly to me when I first
>noticed it long ago in Red Hat Linux).
>
>  
>
>>I have added Nalin to the message to get his comments.
>>    
>>
>
>  
>
Ok I succumb, but we will go back to original implementation of 
libsetrans for now, and require anyone wishing to change the behaviour 
to replace our version with their own.  so dlopen(libsetrans.so.1) will 
work.

Eventually our version of libsetrans will use a UDS interface to talk to 
a long running daemon.

Dan


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
