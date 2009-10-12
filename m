Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9CNlLXd029563
	for <selinux@tycho.nsa.gov>; Mon, 12 Oct 2009 19:47:21 -0400
Received: from mailhub247.itcs.purdue.edu (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9CNkT5o026063
	for <selinux@tycho.nsa.gov>; Mon, 12 Oct 2009 23:46:29 GMT
Message-ID: <4AD3C000.70600@cs.purdue.edu>
Date: Mon, 12 Oct 2009 19:47:12 -0400
From: Jacques Thomas <jthomas@cs.purdue.edu>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SECMARK: implementation question
References: <4AD15EA2.9050804@cs.purdue.edu> <200910121846.43931.paul.moore@hp.com>
In-Reply-To: <200910121846.43931.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Sunday 11 October 2009 12:27:14 am Jacques Thomas wrote:
>   
>> Dear All,
>>
>> If I understand correctly, the permission check for inbound packet (the
>> "packet recv" operation) is performed by selinux_socket_sock_recv_skb,
>> which hooks into the socket_sock_recv_skb hook.
>>
>> Does anybody remember the rationale for doing the check there instead of
>> the NF_INET_LOCAL_IN hook ?
>>     
>
> When performing the "packet recv" access control the Secmark label needs to be 
> compared against the receiving socket's label, to the best of my understanding 
> this is not possible with the current netfilter hooks.  At one point there was 
> some discussion of implementing socket level netfilter hooks but I don't 
> believe they ever went anywhere.
>  
>   
>> I am asking that because the permission for outbound packets ("packet
>> send") seems to be performed in the NF_INET_LOCAL_OUT. I am sure there
>> should be a good reason for this asymetry, but I don't get it.
>>     
>
> The NF_INET_LOCAL_OUT hook, selinux_ip_output(), doesn't actually perform any 
> access control, it only handles labeling packets generated from disconnected 
> sockets when NetLabel is in use.  There is outbound Secmark based access 
> control (amongst others) in the NF_INET_POST_ROUTING hook, but it is possible 
> there because the packet (struct sk_buff) has a back pointer to the socket 
> where it originated from enabling us to perform the access check at this point 
> in the stack.
>
>   

This makes sense to me to me now. Thank you for the explanation.

Regards,
Jacques Thomas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
