Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA26920
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 14:04:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA29836
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 19:02:26 GMT
Received: from kenshin.yingternet.org (c-24-126-235-193.we.client2.attbi.com [24.126.235.193])
        by jazzband.ncsc.mil  with ESMTP id TAA29832 for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 19:02:25 GMT
Message-ID: <3DCAB933.1070608@yingternet.com>
Date: Thu, 07 Nov 2002 11:04:19 -0800
From: Ying-Hung Chen <ying@yingternet.com>
MIME-Version: 1.0
To: Subba Rao <sailorn@attglobal.net>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux source
References: <200211071724.RAA23033@jazzband.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

>
> After extracting the compressed file, there are 2 directories.  One is 
> LSM-2.4 and the other is SELINUX.  The LSM-2.4 tree looks
> similar to what I usually download from the kernel.org site.
>  
>
The files in LSM-2.4 is lsm patched kernel source , so it is not the 
same as vanilla kernel source you download from http://www.kernel.org

> If it is similar, can I use "make xconfig" to configure SELinux?  (I 
> am assuming X will work normally in SELinux).
>
yes, you can run make xconfig to configure SELinux (remember, when you 
are configuring SELinux, you are NOT running SELinux). You should not 
run X on SELinux unless you really want to

please refer to http://www.nsa.gov/selinux/doc/readme.html for details

>
> Is the compilation process different for the source in SELINUX 
> directory? Will "make bzImage" take care of the source in SELINUX 
> directory?                                                                                                                
>
>  
>
The above link also explain the compilation details,

-Ying




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
