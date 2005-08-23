Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7NERgOb028483
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 10:27:42 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7NEHScX019375
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 14:17:29 GMT
Message-ID: <430B3049.5070402@redhat.com>
Date: Tue, 23 Aug 2005 10:18:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux category patch
References: <430A33E5.1030100@redhat.com> <430B2D6A.5010105@tresys.com>
In-Reply-To: <430B2D6A.5010105@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:

> Daniel J Walsh wrote:
>
>>     range=context_range_get(con);
>>     if (range) {
>>         if(strcmp(range,"s0") == 0 ) {
>>             context_range_set(con,NULL);
>>         }
>>         else         {
>>             ptr=strrchr(range,':');
>>  
>>
> Why is s0 hardcoded here? s0 should be part of the context to be 
> translated, if you don't want the users to see it whatever tool to 
> edit the mappings should hide it, not libselinux.

This code is not part of libselinux,  it is a library that SELinux calls 
out to that will be specific to the vendor that ships it.
I see this library being different between our version of MCS/MLS and 
other third party versions of MLS, IE one that translates using the 
Mitre Libraries.

MCS version of libtrans.so translates s0->"".

MLS policy can do what ever it wants with this part of the range.


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
