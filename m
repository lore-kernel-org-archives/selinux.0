Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1G1KIiO029067
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 20:20:18 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m1G1KIqF020296
	for <selinux@tycho.nsa.gov>; Sat, 16 Feb 2008 01:20:18 GMT
Message-ID: <47B63A37.3080606@manicmethod.com>
Date: Fri, 15 Feb 2008 20:19:51 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
CC: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Subject: Re: Brindle example of labeled IPSec
References: <FB39F4E77226B448BC1388D3BE4E00CD02AF96FD@blums0008.bluelnk.net> <200802151640.53368.paul.moore@hp.com> <FB39F4E77226B448BC1388D3BE4E00CD02AF9741@blums0008.bluelnk.net> <47B62DAD.2030204@manicmethod.com> <FB39F4E77226B448BC1388D3BE4E00CD02AF976E@blums0008.bluelnk.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD02AF976E@blums0008.bluelnk.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Clarkson, Mike R (US SSA) wrote:
>   
>> -----Original Message-----
>> From: Joshua Brindle [mailto:method@manicmethod.com]
>> Sent: Friday, February 15, 2008 4:26 PM
>> To: Clarkson, Mike R (US SSA)
>> Cc: Paul Moore; selinux@tycho.nsa.gov
>> Subject: Re: Brindle example of labeled IPSec
>>
>> Clarkson, Mike R (US SSA) wrote:
>>     
>>> Hi Paul,
>>>
>>> I didn't make my original question clear enough. Please see comments
>>> below.
>>>
>>> Thanks,
>>>   Mike
>>>
>>>
>>>       
>>>> -----Original Message-----
>>>> From: Paul Moore [mailto:paul.moore@hp.com]
>>>> Sent: Friday, February 15, 2008 1:41 PM
>>>> To: Clarkson, Mike R (US SSA)
>>>> Cc: selinux@tycho.nsa.gov
>>>> Subject: Re: Brindle example of labeled IPSec
>>>>
>>>> On Friday 15 February 2008 3:15:16 pm Clarkson, Mike R (US SSA)
>>>>         
> wrote:
>   
>>>>> I'm running the server client example that Joshua Brindle provided
>>>>>
>>>>>           
>>> in
>>>
>>>       
>>>>> his article on labeled IPSec.
>>>>>
>>>>>           
>>>> ...
>>>>
>>>>
>>>>         
>>>>> The output of the client and server show that the labels are being
>>>>> sent over the loopback, but just to convince myself that the
>>>>>           
> labeled
>   
>>>>> IPSec loopback was indeed being used, I flushed the SPDs and SADs
>>>>> using "setkey -FP" and "setkey -F". Afterward, I get the following
>>>>> output, which is expected when labeled IPSec is not being used:
>>>>>
>>>>> [mr_clarkson@blade5 test]$ ./brindle_server
>>>>> getsockopt: Protocol not available
>>>>> server: got connection from 127.0.0.1, (null)
>>>>>
>>>>> [mr_clarkson@blade5 test]$ ./brindle_client 127.0.0.1
>>>>> getpeercon: Protocol not available
>>>>> Received: Hello, (null) from (null)
>>>>>
>>>>> I need the missing association rules (shown above) to be able to
>>>>> apply MLS constraints on the connection between the client and
>>>>> server. Any suggestions on how to fix this would be greatly
>>>>> appreciated.
>>>>>
>>>>>           
>>>> The problem is that you removed all of the IPsec labeling rules
>>>>         
> from
>   
>>> the
>>>
>>>       
>>>> SPD when you ran 'setkey -FP'.  This means there is no IPsec
>>>>
>>>>         
>>> processing
>>>
>>>       
>>>> taking place and hence no labeling.  You should be able to flush
>>>>         
> the
>   
>>>> SAD as racoon will repopulate it on the fly, but clearing the SPD
>>>> removes the IPsec configuration from the kernel which is something
>>>>         
> you
>   
>>>> probably didn't intend to do.
>>>>
>>>>
>>>>         
>>> I understand why there is no labeling after doing "setkey -FP". That
>>>       
> was
>   
>>> expected.
>>>
>>> My question is why does the labeling work in enforcing mode, even
>>>       
> though
>   
>>> my policy does not provide the following rules:
>>> allow brindle_client_t ipsec_spd_t:association polmatch;
>>> allow brindle_client_t brindle_server_t:association recvfrom;
>>>
>>>
>>>       
>> Hopefully this will clear up the questions, though it may sound very
>> very confusing...
>>
>> So, in this article I didn't cover dynamic security associations using
>> racoon (this was just an introduction on the topic and racoon makes it
>> more complicated). Therefore I didn't cover the use of SPD entries and
>> that is why polmatch was never used. Even though polmatch uses the
>>     
> same
>   
>> object class as the other permissions it is really referring to the
>> ipsec SPD associations and not the actual associations used for
>> communication.
>>
>> So that explains the polmatch part, hopefully..
>>
>> As for the recvfrom part, in your policy you have:
>>
>> corenet_non_ipsec_sendrecv(brindle_client_t)
>>
>>
>> this interface allows a domain to receive from unlabeled ipsec
>> connections, which means it will work regardless of associations being
>> present, be sure to remove interfaces like this before testing in
>> enforcing.
>>
>>
>>
>>     
>
> True that the non_ipsec interface will allow the client and server to
> communicate, but it wouldn't be a labeled communication, which means the
> output of the client and server should look like this:
>
> [mr_clarkson@blade5 test]$ ./brindle_server
> getsockopt: Protocol not available
> server: got connection from 127.0.0.1, (null)
>
> [mr_clarkson@blade5 test]$ ./brindle_client 127.0.0.1
> getpeercon: Protocol not available
> Received: Hello, (null) from (null)
>
> I know that it is sending the packets over the labeled IPSec loopback,
> because it stops working when I remove the SPDs using "setkey -FP"
>
> In any case, it quits working when I replace
> corenet_non_ipsec_sendrecv(brindle_client_t) with
> ipsec_labeled(brindle_client_t) and do likewise for the server. And I
> get the following from audit2allow:
>
> #============= brindle_client_t ==============
> # src="brindle_client_t" tgt="unlabeled_t" class="packet", perms="send"
> # comm="brindle_client" exe="" path=""
> allow brindle_client_t unlabeled_t:packet send;
>
> Is there something else that I need to provide?
>
>   

I think corenet_sendrecv_unlabeled_packets()

>> With labeled IPSec over the loopback, I did not have to provide any
>>     
>>> rules in my brindle_client module or my brindle_server module with
>>> respect to the association object class. Without the association
>>>       
> rules,
>   
>>> the policy doesn't have any way of enforcing MLS constraints, or TE
>>>       
> on
>   
>>> the client server connections, which is the reason that I set up
>>>       
> labeled
>   
>>> IPSec over loopback in the first place.
>>>
>>> Any help would be much appreciated,
>>>   Thanks
>>>
>>>
>>>       
>> Right, I think the idea that we had here was to combine ipsec for
>> 'course labels with TE and a level range' and netlabel for fine
>>     
> grained
>   
>> MLS labels. This, of course, was not something I covered in the
>>     
> article.
>   
>> This should also work fine over loopback.
>>
>>     



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
