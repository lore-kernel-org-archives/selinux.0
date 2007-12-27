Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBRLgsgQ019463
	for <selinux@tycho.nsa.gov>; Thu, 27 Dec 2007 16:42:54 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBRLgqu4026322
	for <selinux@tycho.nsa.gov>; Thu, 27 Dec 2007 21:42:54 GMT
Received: by py-out-1112.google.com with SMTP id u77so6444241pyb.15
        for <selinux@tycho.nsa.gov>; Thu, 27 Dec 2007 13:42:43 -0800 (PST)
Message-ID: <47741BC4.4060105@gmail.com>
Date: Thu, 27 Dec 2007 15:40:20 -0600
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: bigotp@acm.org
CC: selinux@tycho.nsa.gov
Subject: Re: MLS sensitivity sensitivity
References: <Pine.LNX.4.64.0712271318020.32461@euphrosyne.pab>
In-Reply-To: <Pine.LNX.4.64.0712271318020.32461@euphrosyne.pab>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Peter A. Bigot wrote:
> Running the HEAD version of the reference policy with strict MLS 
> permissive
> on Fedora 8, I'm trying to eliminate all the AVC denials I get on 
> boot.  The
> simplest of them is:
>
> type=SYSCALL msg=audit(12/27/2007 10:11:23.883:128) : arch=i386 
> syscall=open success=yes exit=1 a0=a0544f8 a1=8541 a2=1a4 a3=8541 
> items=0 ppid=2213 pid=2214 auid=pab uid=root gid=root euid=root 
> suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) 
> comm=rsyslogd exe=/sbin/rsyslogd 
> subj=system_u:system_r:syslogd_t:s0-s15:c0.c255 key=(null)
>
> type=AVC msg=audit(12/27/2007 10:11:23.883:128) : avc:  denied  { 
> append } for  pid=2214 comm=rsyslogd name=messages dev=sda5 ino=32066 
> scontext=system_u:system_r:syslogd_t:s0-s15:c0.c255 
> tcontext=system_u:object_r:var_log_t:s15:c0.c255 tclass=file
>
> syslogd_t has append rights to var_log_t files, per apol:
>
> allow syslogd_t var_log_t : file { ioctl read write create getattr 
> setattr lock append unlink link rename };
> allow syslogd_t var_log_t : dir { ioctl read write create getattr 
> setattr lock add_name remove_name search };
> allow syslogd_t var_log_t : fifo_file { ioctl read write getattr lock 
> append };
>
> and /var/log/messages has the correct type:
>
> # ls -lZ /var/log/secure -rw-------  root root 
> system_u:object_r:var_log_t:s15:c0.c255 /var/log/messages
>
> The same failure occurs when I manually run_init service rsyslog restart.
>
> If I downgrade the sensitivity on /var/log/messages all the way to s0, 
> then
> it works without complaint.  s1 through s15 all fail.  But changing the
> security level can't be the intended solution.
>
> What should I be doing to eliminate this denial?
>
> Thanks.
>
> Peter
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>   
Maybe mls_file_write_all_levels(syslogd_t)?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
