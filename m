Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAQBuIIi029597
	for <selinux@tycho.nsa.gov>; Fri, 26 Nov 2004 06:56:18 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAQBuI0E008159
	for <selinux@tycho.nsa.gov>; Fri, 26 Nov 2004 11:56:21 GMT
Message-ID: <41A719C8.1090504@redhat.com>
Date: Fri, 26 Nov 2004 06:55:52 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Stephen Smalley <sds@epoch.ncsc.mil>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
Subject: Re: can_network patch.
References: <41741A2C.8040408@redhat.com> <41A3917F.30104@redhat.com> <1101240468.19785.298.camel@moss-spartans.epoch.ncsc.mil> <200411260640.49790.russell@coker.com.au>
In-Reply-To: <200411260640.49790.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Wednesday 24 November 2004 07:07, Stephen Smalley <sds@epoch.ncsc.mil> 
>wrote:
>  
>
>>If no one agrees with me about preserving can_network() semantics, then
>>I can be overruled.  But I thought that Russell had voiced a similar
>>concern earlier.
>>    
>>
>
>I still think that can_network() should keep it's traditional functionality.
>
>  
>
The latest patch can_network has the same functionality, we now have 
other options to tighten security though.

can_network_tcp
can_network_udp
...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
