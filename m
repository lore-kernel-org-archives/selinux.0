Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1G1cXcw030551
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 20:38:33 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m1G1cWqF024791
	for <selinux@tycho.nsa.gov>; Sat, 16 Feb 2008 01:38:32 GMT
Message-ID: <47B63E7E.4000000@manicmethod.com>
Date: Fri, 15 Feb 2008 20:38:06 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
CC: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Subject: Re: Brindle example of labeled IPSec
References: <FB39F4E77226B448BC1388D3BE4E00CD02AF96FD@blums0008.bluelnk.net> <200802151640.53368.paul.moore@hp.com> <FB39F4E77226B448BC1388D3BE4E00CD02AF9741@blums0008.bluelnk.net> <47B62DAD.2030204@manicmethod.com> <FB39F4E77226B448BC1388D3BE4E00CD02AF976E@blums0008.bluelnk.net> <47B63A37.3080606@manicmethod.com> <FB39F4E77226B448BC1388D3BE4E00CD02AF9774@blums0008.bluelnk.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD02AF9774@blums0008.bluelnk.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Clarkson, Mike R (US SSA) wrote:
>   
>>>> As for the recvfrom part, in your policy you have:
>>>>
>>>> corenet_non_ipsec_sendrecv(brindle_client_t)
>>>>
>>>>
>>>> this interface allows a domain to receive from unlabeled ipsec
>>>> connections, which means it will work regardless of associations
>>>>         
> being
>   
>>>> present, be sure to remove interfaces like this before testing in
>>>> enforcing.
>>>>
>>>>
>>>>
>>>>
>>>>         
>>> True that the non_ipsec interface will allow the client and server
>>>       
> to
>   
>>> communicate, but it wouldn't be a labeled communication, which means
>>>       
> the
>   
>>> output of the client and server should look like this:
>>>
>>> [mr_clarkson@blade5 test]$ ./brindle_server
>>> getsockopt: Protocol not available
>>> server: got connection from 127.0.0.1, (null)
>>>
>>> [mr_clarkson@blade5 test]$ ./brindle_client 127.0.0.1
>>> getpeercon: Protocol not available
>>> Received: Hello, (null) from (null)
>>>
>>> I know that it is sending the packets over the labeled IPSec
>>>       
> loopback,
>   
>>> because it stops working when I remove the SPDs using "setkey -FP"
>>>
>>> In any case, it quits working when I replace
>>> corenet_non_ipsec_sendrecv(brindle_client_t) with
>>> ipsec_labeled(brindle_client_t) and do likewise for the server. And
>>>       
> I
>   
>>> get the following from audit2allow:
>>>
>>> #============= brindle_client_t ==============
>>> # src="brindle_client_t" tgt="unlabeled_t" class="packet",
>>>       
> perms="send"
>   
>>> # comm="brindle_client" exe="" path=""
>>> allow brindle_client_t unlabeled_t:packet send;
>>>
>>> Is there something else that I need to provide?
>>>
>>>
>>>       
>> I think corenet_sendrecv_unlabeled_packets()
>>
>>     
>
> That's the same as corenet_non_ipsec_sendrecv(). They both just call
> kernel_sendrecv_unlabeled_packets().
>   

perhaps just call kernel_sendrecv_unlabeled_packets then?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
