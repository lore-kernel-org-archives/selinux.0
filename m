Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5H3LkgA006208
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 23:21:46 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5H3CXI8005917
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 03:12:33 GMT
Message-ID: <42B24006.2020706@redhat.com>
Date: Thu, 16 Jun 2005 23:14:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: ivg2@cornell.edu, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: mail_client_macros.te
References: <200506170827.59180.russell@coker.com.au> <1118963954.19768.2.camel@localhost.localdomain> <200506171132.07632.russell@coker.com.au>
In-Reply-To: <200506171132.07632.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Friday 17 June 2005 09:19, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
>  
>
>>On Fri, 2005-06-17 at 08:27 +1000, Russell Coker wrote:
>>    
>>
>>>The attached patch is needed to compile a policy without innd.te.
>>>      
>>>
>>I don't see why the innd port is dependent on the innd policy.
>>    
>>
>
>As long as the type is defined in innd.te it is.  The policy won't compile 
>without innd.te included.
>
>The other option is to move the type to types/network.te.
>
>Do you think we should change the policy to move all port type definitions to 
>types/network.te and have all ports labeled unconditionally?
>
>  
>
Now that we are using named_connect, yes.  The port needs to be defined 
so both the client and server app can connect to it.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
