Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5PACRgA013319
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 06:12:27 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5PABis8011180
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 10:11:44 GMT
Message-ID: <42BCD292.3090103@redhat.com>
Date: Fri, 24 Jun 2005 23:42:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: antoine <antoine@nagafix.co.uk>
CC: ivg2@cornell.edu, SELinux <selinux@tycho.nsa.gov>, walters@redhat.com
Subject: Re: mdadm policy
References: <1119569243.9390.77.camel@localhost>	 <1119577846.20101.26.camel@localhost.localdomain>	 <1119605711.9645.28.camel@localhost>	 <1119627684.30464.8.camel@celtics.boston.redhat.com>	 <1119630905.9645.37.camel@localhost>	 <1119635200.31852.16.camel@celtics.boston.redhat.com>	 <1119636160.9645.46.camel@localhost>	 <1119639933.31852.82.camel@celtics.boston.redhat.com> <1119641274.9645.58.camel@localhost>
In-Reply-To: <1119641274.9645.58.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

antoine wrote:

>On Fri, 2005-06-24 at 15:05 -0400, Ivan Gyurdiev wrote:
>  
>
>>>So it looks to me like the transition to sendmail should always be
>>>included - well actually, ifdef(mta.te).
>>>      
>>>
>>cc-ed Dan Walsh.
>>Proposed transition to sendmail from mdadm.te
>>(so it can send alerts to user).
>>
>>Re: can_exec({ bin_t, sbin_t }) rule
>>
>>Antoine, you have to be root/sysadm_t to configure
>>execution of such programs, right? If you have sysadm_t, you
>>can disable any and all security. The only protection
>>from sysadm_t that selinux provides is protection from
>>inadvertently running hostile code that messes w/ selinux
>>files - that's why we have a role called secadm_t
>>(I think this is work in progress).
>>    
>>
>I admit the threat is minimal, but I just don't like the idea of running
>things as mdadm_t when it isn't necessary.
>You would need to know what is run by mdadm (as mdadm.conf is not
>readable by non root/sysadm_t) *and* find a flaw in it *and* trigger the
>mdadm error condition. Very slim indeed.
>On the other hand, any flaw in one of the bin_t/sbin_t programs run by
>mdadm would lead to a full compromise (using raw disks). And there has
>been more than one flaw found in sendmail/postfix/... And since it is
>avoidable, why not remove access to raw disks before launching the
>program. (I think the transition to sendmail_t is the minimum)
>
>  
>
>>So, we can't stop an intentional attack like this.
>>The only question is whether we should stop unintentional
>>attack (sysadm doesn't know bin_t/sbin_t program is hostile,
>>sysadm installed it anyway, sysadm doesn't have capability
>>to write to fixed_disk_device, but mdadm does, and 
>>gives hostile program desired escalation). 
>>    
>>
>Hostile program  *or* shell script with insecure privileges/files, etc.
>
>Antoine
>
>  
>
Add privmail attribute and you will transition to system_mail_t when 
starting sendmai.

-- 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
