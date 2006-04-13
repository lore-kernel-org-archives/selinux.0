Message-ID: <443DB529.60508@us.ibm.com>
Date: Wed, 12 Apr 2006 22:19:21 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: jvdias@redhat.com, jfs@computer.org, ciaranm@gentoo.org, dwalsh@redhat.com,
        sgrubb@redhat.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: [RFC] [PATCH] Extend vixie-cron to allow cron jobs at multiple
 security contexts
References: <1144422989.7681.6.camel@hobbes.atlanta.ibm.com> <200604121859.50999.russell@coker.com.au>
In-Reply-To: <200604121859.50999.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Saturday 08 April 2006 01:16, JANAK DESAI <janak@us.ibm.com> wrote:
>  
>
>>+				if ((strlen(pw->pw_name) +
>>+				     strlen((char *)context)) >= sizeof User) {
>>    
>>
>
>Shouldn't that be the following instead?
> 				if ((strlen(pw->pw_name) +
> 				     strlen((char *)context)) + 2 > sizeof User) {
>
>  
>
>>+			if (strlen(optarg) >= sizeof User)
>>    
>>
>
>Shouldn't that be the following instead?
>			if (strlen(optarg) + 1 >= sizeof(User) )
>
>  
>
Thanks Russell. You are correct. I will fix both of the above problems.

Javier, I will forward you my original posting of the patch in a 
seperate email.

-Janak

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
