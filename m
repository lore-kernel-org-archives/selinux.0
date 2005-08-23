Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7NFBCOb028914
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 11:11:12 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7NF0wcX026604
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 15:01:00 GMT
Message-ID: <430B3A7B.6020208@redhat.com>
Date: Tue, 23 Aug 2005 11:02:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux category patch
References: <430A33E5.1030100@redhat.com> <1124807226.7874.52.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124807226.7874.52.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Mon, 2005-08-22 at 16:21 -0400, Daniel J Walsh wrote:
>  
>
>>libselinux-rhat.patch is mainly tcs's patch with a couple of changes. 
>>    
>>
>
>Do we truly need to allow whitespace in the (translated) MLS field?
>That change to context_new originated in the TCS patch, but I'd prefer
>to avoid it if possible.
>  
>  
>
I have no problem with not allowing spaces in translated name.  We could 
come up with a third field, in the translation, Printable Name or some 
such, but that could come later...

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
