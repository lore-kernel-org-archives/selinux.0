Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i92AHErT008025
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 06:17:14 -0400 (EDT)
Message-ID: <415E8019.6000100@redhat.com>
Date: Sat, 02 Oct 2004 06:16:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
Subject: Re: policy patches
References: <200409292354.15227.russell@coker.com.au> <200410020344.04225.russell@coker.com.au> <415DC1D7.9040109@redhat.com> <200410021042.15371.russell@coker.com.au>
In-Reply-To: <200410021042.15371.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Sat, 2 Oct 2004 06:45, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>Cleaned up patch with some of russells changes.
>>
>>chage has been updated to do a checkPasswdAccess(PASSWD__ROOTOK) now.
>>    
>>
>
>+allow getty_t initrc_devpts_t:chr_file { read write };
>
>What is this for?
>
>  
>
I have been getting AVC messages for it.

>-# /usr/sbin/sendmail asks for w access to utmp, but it will operate
>-# correctly without it.  Do not audit write and lock denials to utmp.
>-allow sendmail_t initrc_var_run_t:file { getattr read };
>-dontaudit sendmail_t initrc_var_run_t:file { lock write };
>+# /usr/sbin/sendmail asks for w access to utmp
>+allow sendmail_t initrc_var_run_t:file { getattr read lock write };
>
>You missed my fix for this problem.
>  
>
No I know about it but Need to wait for sendmail to be fixed to revert 
this change.

> allow $1_xserver_t device_t:dir create;
>+allow $1_xserver_t device_t:dir { setattr };
>
>Probably best to just merge the above two lines with { create setattr }.
>
>  
>
Sounds good.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
