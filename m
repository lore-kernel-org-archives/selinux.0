Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j87DRuOb028306
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2005 09:27:56 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j87DOcfE026626
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2005 13:24:38 GMT
Message-ID: <431EEAD3.3000002@redhat.com>
Date: Wed, 07 Sep 2005 09:27:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ntp policy
References: <1125929266.16388.85.camel@sgc>  <431EDA31.9030502@redhat.com> <1126099300.13223.5.camel@sgc>
In-Reply-To: <1126099300.13223.5.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:

>On Wed, 2005-09-07 at 08:16 -0400, Daniel J Walsh wrote:
>  
>
>>Christopher J. PeBenito wrote:
>>
>>    
>>
>>>While converting the ntpd policy over to a reference policy module, I
>>>came across a few lines which bring up questions.
>>>      
>>>
>[cut]
>  
>
>>>	ifdef(`winbind.te', `
>>>	allow ntpd_t winbind_var_run_t:dir r_dir_perms;
>>>	allow ntpd_t winbind_var_run_t:sock_file rw_file_perms;
>>>	')
>>>
>>>Generally when using a sock_file, a domain is connecting/sending to
>>>another domain over a unix domain socket; however, after doing a few
>>>rule searches in apol, I find no evidence that ntpd_t connects/sends to
>>>winbind_t.  Is there some other purpose for these rules, or am I missing
>>>something?
>>>
>>>      
>>>
>>Must be from nscd.
>>    
>>
>
>I don't understand.  If that is the case, wouldn't it be nscd_var_run_t
>instead of winbind_var_run_t?
>
>  
>
I believe that in permissive mode, you would eventually get to the point 
of talking over the winbind socket.  So these rules were porbably added 
for this purpose.  Since ntpd is in nscd_client_domain, these rules are 
probably not necessary.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
