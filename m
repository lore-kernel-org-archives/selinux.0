Message-ID: <40FBB82D.1030909@gentoo.org>
Date: Mon, 19 Jul 2004 08:01:49 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: running interpreted scripts in different domains
References: <40FADE92.7060307@gentoo.org> <20040719082855.GG3066@lkcl.net> <200407192156.56501.russell@coker.com.au>
In-Reply-To: <200407192156.56501.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Mon, 19 Jul 2004 18:28, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
>  
>
>>it sounds to me like you almost need to have _two_ contexts.
>>
>>one method_php_t and the other user_t.
>>
>>and to be able to make access decisions like this:
>>
>>	allow method_php_t+user_t bin_t:lnk_file file_read;
>>
>>meaning "if you have both the method_php_t context AND the user_t
>>context, then allow reading of symbolic links in /bin".
>>    
>>
>
>Currently in SE Linux each process has exactly one context, it can only gain a 
>new context by dropping the old one.  If a process could have two contexts 
>then it could potentially go through a series of operations to collect 
>multiple contexts ending up with a large set of access rights which were not 
>planned by the person who wrote the policy.  Some other security systems have 
>had problems similar to this.
>
>  
>
Right, fastcgi supports having multiple interpreters running (one per 
uid generally)

so the question is not to get the information to fastcgi about what 
context to put in setexeccon().


Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
