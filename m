Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6ABxDgA002727
	for <selinux@tycho.nsa.gov>; Sun, 10 Jul 2005 07:59:13 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6ABuVRY001669
	for <selinux@tycho.nsa.gov>; Sun, 10 Jul 2005 11:56:31 GMT
Message-ID: <42D10CEA.1070305@redhat.com>
Date: Sun, 10 Jul 2005 07:56:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: crond_t
References: <200507090004.57794.russell@coker.com.au> <42CE8CCF.6000508@redhat.com> <200507091300.07806.russell@coker.com.au>
In-Reply-To: <200507091300.07806.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Saturday 09 July 2005 00:25, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>Russell Coker wrote:
>>    
>>
>>>It seems that the domain crond_t needs the attribute privfd.  The number
>>>of things that are run from cron jobs demands it.  A user of the rawhide
>>>policy reported a problem running ping from a cron job on IRC.
>>>      
>>>
>>crond_t has privfd.
>>    
>>
>
>In which version?  selinux-policy-targeted-sources-1.24-3 doesn't have it.
>
>  
>
>>Are you talking about system_crond_t and friends?
>>    
>>
>
>No, the domain_auto_trans() rules from those domains give the fd use rules 
>that are needed.
>
>  
>
It is in strict policy, not in targeted.
selinux-policy-*-1.25.1-6

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
