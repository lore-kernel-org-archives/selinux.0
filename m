Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1LD5edW017254
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 08:05:40 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1LD1Epm003942
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 13:01:14 GMT
Message-ID: <4219DB94.1090906@redhat.com>
Date: Mon, 21 Feb 2005 08:01:08 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov
Subject: Re: Java Legacy problem
References: <1108910713.3610.18.camel@cobra.ivg2.net> <20050220154458.GH14038@lkcl.net> <1108914838.5275.10.camel@cobra.ivg2.net> <20050220171743.GJ14038@lkcl.net>
In-Reply-To: <20050220171743.GJ14038@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:

>On Sun, Feb 20, 2005 at 10:53:58AM -0500, Ivan Gyurdiev wrote:
>  
>
>>On Sun, 2005-02-20 at 15:44 +0000, Luke Kenneth Casson Leighton wrote:
>>    
>>
>>>if i was dealing with it, i would create a macro - mozilla_java_domain
>>>with an argument $1 which takes the role (see usage of mozilla_domain).
>>>      
>>>
>>Hi Luke. 
>>Perhaps my mail did not make it clear - I am interested in java usage
>>outside mozilla. The mozilla java policy already exists and works.
>>    
>>
>
> ah, right.
>
> okayyy... well, you would do well to follow the same approach
> (but this time with a macro called java_domain),
> such that any program you intend to be capable of using java
> you could use the macro to give that program the rights it
> needs when executing java.
>
> however, the point i believe that is being made is that 1) is
> user_t sufficient protection and if so don't bother 2) be
> careful if you create a new domain that you don't give it
> _more_ rights than user_t is normally allowed.
>
> l.
>  
>

This is a case where we may want to give an application more rights then 
user_t.
The java_user_t should be user_t + (execmem/execmod privs)

>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
