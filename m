Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j36CYSDo016801
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 08:34:29 -0400 (EDT)
Message-ID: <4253D5C5.60707@redhat.com>
Date: Wed, 06 Apr 2005 08:27:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: More patches
References: <200502032350.40924.russell@coker.com.au>	 <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>	 <4253CD52.1090206@redhat.com> <1112790317.4187.1.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1112790317.4187.1.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:

>On Wed, 2005-04-06 at 07:51 -0400, Daniel J Walsh wrote:
>  
>
>>Ivan has some more cleanup of x_client apps.
>>Also added execmod to httpd for php
>>Moved +r_dir_file(httpd_t, httpd_$1_content_t) outside boolean
>>so you should be able to serve pages with httpd with all booleans turned 
>>off.
>>
>>You are missing NetworkManager from your latest pool, even though 
>>comment says it is there.
>>    
>>
>
>Forgot to cvs add it on sourceforge.  It is committed now.
>
>
>  
>
Hold off on that patch.  Some of the x_client changes are not working 
correctly.  I will submit a fixed patch soon.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
