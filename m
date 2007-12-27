Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBRMWgtF023209
	for <selinux@tycho.nsa.gov>; Thu, 27 Dec 2007 17:32:42 -0500
Received: from DakotaMail.dakotacom.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBRMWeRu002074
	for <selinux@tycho.nsa.gov>; Thu, 27 Dec 2007 22:32:41 GMT
Date: Thu, 27 Dec 2007 15:32:36 -0700 (MST)
From: "Peter A. Bigot" <pab@dakotacom.net>
Reply-To: bigotp@acm.org
To: Ted X Toth <txtoth@gmail.com>
cc: selinux@tycho.nsa.gov
Subject: Re: MLS sensitivity sensitivity
In-Reply-To: <47741BC4.4060105@gmail.com>
Message-ID: <Pine.LNX.4.64.0712271522070.13780@euphrosyne.pab>
References: <Pine.LNX.4.64.0712271318020.32461@euphrosyne.pab>
 <47741BC4.4060105@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Dec 2007, Ted X Toth wrote:
> Peter A. Bigot wrote:
>> Running the HEAD version of the reference policy with strict MLS permissive
>> on Fedora 8, I'm trying to eliminate all the AVC denials I get on boot. 
>> The
>> simplest of them is:
>> 
>> type=SYSCALL msg=audit(12/27/2007 10:11:23.883:128) : arch=i386 
>> syscall=open success=yes exit=1 a0=a0544f8 a1=8541 a2=1a4 a3=8541 items=0 
>> ppid=2213 pid=2214 auid=pab uid=root gid=root euid=root suid=root 
>> fsuid=root egid=root sgid=root fsgid=root tty=(none) comm=rsyslogd 
>> exe=/sbin/rsyslogd subj=system_u:system_r:syslogd_t:s0-s15:c0.c255 
>> key=(null)
>> 
>> type=AVC msg=audit(12/27/2007 10:11:23.883:128) : avc:  denied  { append } 
>> for  pid=2214 comm=rsyslogd name=messages dev=sda5 ino=32066 
>> scontext=system_u:system_r:syslogd_t:s0-s15:c0.c255 
>> tcontext=system_u:object_r:var_log_t:s15:c0.c255 tclass=file
>> 
>> syslogd_t has append rights to var_log_t files, per apol:
>> 
>> allow syslogd_t var_log_t : file { ioctl read write create getattr setattr 
>> lock append unlink link rename };
>> allow syslogd_t var_log_t : dir { ioctl read write create getattr setattr 
>> lock add_name remove_name search };
>> allow syslogd_t var_log_t : fifo_file { ioctl read write getattr lock 
>> append };
>> 
>> and /var/log/messages has the correct type:
>> 
>> # ls -lZ /var/log/secure -rw-------  root root 
>> system_u:object_r:var_log_t:s15:c0.c255 /var/log/messages
>> 
>> The same failure occurs when I manually run_init service rsyslog restart.
>> 
>> If I downgrade the sensitivity on /var/log/messages all the way to s0, then
>> it works without complaint.  s1 through s15 all fail.  But changing the
>> security level can't be the intended solution.
>> 
>> What should I be doing to eliminate this denial?
>> 
>> Thanks.
>> 
>> Peter
>> 
>> -- 
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
>> with
>> the words "unsubscribe selinux" without quotes as the message.
>> 
> Maybe mls_file_write_all_levels(syslogd_t)?
>

Thanks for the pointer.  I started by trying mls_write_to_clearance (on the
theory it was less powerful) and that worked.  Which is the better choice?

This brings up a thought: assume a program operating at level s3 generates a
syslog message for which the facility/level and syslog.conf happens to cause
it to be written to a file that is at level s0.  Would anything stop this
(viz., carry the security level along with the message to the syslog
daemon)?  Or is that why the standard syslog destinations should all be
mls_systemhigh?  The default of s0 for /var/log/.* would result in a
violation if somebody added an entry to syslog.conf but didn't update the
logging file context.

Peter

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
