Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7I6Jmex030543
 for <selinux@tycho.nsa.gov>; Tue, 18 Aug 2015 02:19:48 -0400
Message-ID: <BLU437-SMTP2918BBD69D59CFD313FDDB9D780@phx.gbl>
From: rowan <rowanPang_selinux@hotmail.com>
To: "'Dominick Grift'" <dac.override@gmail.com>, <selinux@tycho.nsa.gov>
References: <BLU436-SMTP8926E1E94C430CC9C28B0F9D7C0@phx.gbl>
 <20150814082256.GA26540@x250>
In-Reply-To: <20150814082256.GA26540@x250>
Subject: =?gb2312?B?tPC4tDogc2VsaW51eCBtbHMvbWNzIHJhbmcgbW9kaWZ5?=
Date: Tue, 18 Aug 2015 14:19:39 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="gb2312"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dear Dominick,
	Thanks for your help
	At first I unmap all the linux uid from system_u, then I change the
rang back successfully.

Thanks
rowan

-----邮件原件-----
发件人: Selinux [mailto:selinux-bounces@tycho.nsa.gov] 代表 Dominick Grift
发送时间: 2015年8月14日 16:23
收件人: selinux@tycho.nsa.gov
主题: Re: selinux mls/mcs rang modify

On Fri, Aug 14, 2015 at 02:45:05PM +0800, rowan wrote:
> Dear all,
> 
>          When do test, I use semanage change the mls/mcs range of 
> selinux user 'system_u' from 's0-s0:c0.c1023' to 's0-s0:c0.c1020',cmd 
> as bleow
> 
>                    'semanage user -m -r s0-s0:c0.c1020 system_u'
> 
>  
> 
> How do I change it back?

I think I know what you are getting at here. Libsemanage does not do a good
job with validation.

you could try to remove or change  any login mappings of system_u that
authorize use of categories that exceeds the range associated with system_u
user mapping first , or change that range so that it is equal to or fall in
the range of the system_u user mapping.

What, i think happened was, is that libsemanage allowed you to change the
range associated with the system_u id, even though there is a login mapping
in place that associates one or more linux uids with system_u and a range
that exceeds the range that is associated with system_u

libsemanage shouldnt have let you done that in the first place. It should
have said instead: " Hey! i noticed you are trying to change the levelrange
associated with system_u, but there currently is a login mapping in place
that associates system_u, and a range that exceeds that of system_u with a
linux id. I can't do that!"

Now when you try to change the range associated with system_u back to the
old state. libsemanage wont allow you to because there is a login mapping of
system_u with a range that exceeds the current range.

So if this is at all possible without manually editting
/etc/selinux/*/seusers(.local)? then try and use semanage to make the range
of any login mapping that applies to system_u equal or less than the range
associated with system_u id

I hope this makes sense, i realise that it is kind of confusing

> 
>  
> 
> Thanks
> 
> rowan
> 

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.
gov.


--
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
