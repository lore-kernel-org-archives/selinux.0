Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NGhvrT010544
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 12:43:58 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NGhuUk023561
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 16:43:57 GMT
Message-ID: <4152FD20.4020302@redhat.com>
Date: Thu, 23 Sep 2004 12:43:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Joshua Brindle <method@gentoo.org>, Russell Coker <russell@coker.com.au>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Upstream policy handling
References: <414DA0A7.1000708@gentoo.org>	 <200409200646.51865.russell@coker.com.au> <414DF5F2.9030700@gentoo.org>	 <200409200729.50087.russell@coker.com.au>  <414E1AC3.2070209@gentoo.org>	 <1095651232.4431.123.camel@nexus.verbum.private>	 <1095684970.8397.117.camel@selinux> <1095695627.4431.157.camel@nexus.verbum.private>
In-Reply-To: <1095695627.4431.157.camel@nexus.verbum.private>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin Walters wrote:

>On Mon, 2004-09-20 at 08:56 -0400, Christopher J. PeBenito wrote:
>
>  
>
>>And my response was that it was not a clean way to do it imo.  I think
>>sysadmfile is an overused attribute.  You're suggesting adding another
>>attribute to fix an attribute problem.  The way I did it was to reduce
>>the sysadmfile types, and then add a tunable that gives back full access
>>if needed by using { file_type -shadow_t }, which is basically what
>>sysadmfile is currently.  If there are other references to sysadmfile,
>>they can also be replaced with the above set.  I don't see how this is
>>less mergeable.
>>    
>>
>
>I'd need to see your patch, but if sysadmfile is really as close to
>{ file_type -shadow_t } as you say, then that sounds fine too.
>
>  
>
With russells latest patches sysadmfile is the same as file_type 
-shadow_t , so we should be able to have a
tunable to restrict sysadm_r access to sysadmfile.


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
