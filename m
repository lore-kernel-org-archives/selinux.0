Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03JomXf023708
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 14:50:48 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03Jnlqa002580
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 19:49:48 GMT
Message-ID: <43BAB9A6.70403@cornell.edu>
Date: Tue, 03 Jan 2006 12:51:34 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: libsemanage performance patch
References: <200601040557.32435.russell@coker.com.au> <43BAB42A.9000507@cornell.edu>
In-Reply-To: <43BAB42A.9000507@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>> @@ -131,10 +128,6 @@ int parse_skip_space(
>>  
>>              return STATUS_SUCCESS;
>>          }
>> -
>> -        next:
>> -        free(buffer);
>> -        buffer = NULL;
>>   
> This introduces a memory leak.
Actually it doesn't, Ok I agree...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
