Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAL58aIi029341
	for <selinux@tycho.nsa.gov>; Sun, 21 Nov 2004 00:08:36 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAL5765J002654
	for <selinux@tycho.nsa.gov>; Sun, 21 Nov 2004 05:07:07 GMT
Message-ID: <41A022C6.8050100@redhat.com>
Date: Sun, 21 Nov 2004 00:08:22 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: petre rodan <kaiowas@gentoo.org>, SELinux <selinux@tycho.nsa.gov>,
   Chris PeBenito <pebenito@gentoo.org>
Subject: Re: gentoo diff for snmpd
References: <4198D752.2020405@gentoo.org>	 <1100808061.26930.18.camel@moss-lions.epoch.ncsc.mil>	 <419DF805.80002@gentoo.org> <1100893806.31793.29.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1100893806.31793.29.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:

>I put an "ifdef(`distro_gentoo'" around all of these rules and merged
>them.
>
>  
>
Are you sure the proc_net changes are specific to gentoo?

>On Fri, 2004-11-19 at 08:41, petre rodan wrote:
>  
>
>>Hi James,
>>
>>James Carter wrote:
>>    
>>
>>>Merged.
>>>
>>>Oops, there is no proc_net_t defined.
>>>Petre, could you send me the proc_net_t stuff as well.
>>>      
>>>
>>please see the attachment.
>>
>>    
>>
>>>On Mon, 2004-11-15 at 11:20, petre rodan wrote:
>>>
>>>      
>>>
>>>>Hi,
>>>>
>>>>gentoo as a special context for /proc/net:
>>>>genfscon proc /net  system_u:object_r:proc_net_t
>>>>
>>>>so a small diff is needed for the snmpd policy. attached.
>>>>        
>>>>
>>bye,
>>peter
>>    
>>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
