Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j34JlODo003356
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2005 15:47:24 -0400 (EDT)
Message-ID: <42519848.7080203@redhat.com>
Date: Mon, 04 Apr 2005 15:40:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: jwcart2@epoch.ncsc.mil, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New Policy Patch
References: <41E57081.4090500@redhat.com>	 <1106339767.25125.31.camel@moss-lions.epoch.ncsc.mil>	 <42518C8A.7040200@redhat.com> <1112643515.31122.3.camel@cobra.ivg2.net>
In-Reply-To: <1112643515.31122.3.camel@cobra.ivg2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>+can_getsecurity(hald_t)
>>    
>>
>
>check_context was sufficient for me.. does it
>need the rest of the things in can_getsecurity?
>
>+# For /usr/libexec/hald-add-selinux-mount-option
>+allow hald_t security_t:dir search;
>+allow hald_t security_t:file { read write };
>+allow hald_t security_t:security check_context;
>
>  
>
>>+# For /usr/sbin/dmidecode
>>+# Violates assertion
>>+#allow hald_t memory_device_t:chr_file read;
>>+allow hald_t self:capability sys_rawio;
>>    
>>
>
>Hold on - this should go into its own domain for dmidecode...
>
>  
>
Since we do not have that policy yet, we need this for strict to work, 
correct?

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
