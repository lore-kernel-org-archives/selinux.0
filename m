Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2JGcIDo029878
	for <selinux@tycho.nsa.gov>; Sat, 19 Mar 2005 11:38:18 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2JGcxwO006319
	for <selinux@tycho.nsa.gov>; Sat, 19 Mar 2005 16:39:00 GMT
Message-ID: <423C54F5.5060205@redhat.com>
Date: Sat, 19 Mar 2005 11:36:05 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Jim Carter <jwcart2@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: latest diff
References: <423BCC68.3090003@redhat.com> <1111248890.5582.20.camel@chris.pebenito.net>
In-Reply-To: <1111248890.5582.20.camel@chris.pebenito.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:

>On Sat, 2005-03-19 at 01:53 -0500, Daniel J Walsh wrote:
>  
>
>>I think we can remove the hostname policy, it adds little value.  
>>    
>>
>[cut]
>  
>
>>I think it would work fine without hostname policy.  I think we could 
>>probably get rid of consoletype also.
>>    
>>
>
>I don't remember why hostname and consoletype were added in the first
>place, but a quick look through them makes me think that its so we don't
>have to give sys_admin capability to initrc_t when these programs are
>run from init scripts.  Sys_admin is a huge set a privileges, so I'd say
>its worthwhile to keep them around.
>
>  
>
Ok, that is what I saw.  I saw the sys_admin avc messages, but there was 
no failure in
setting up the hostname.  So I put a dontaudit in dhcpc and everything 
seems to work.
Does anyone know if these apps actually need this priv or are just 
asking for it even though
they don't need it.    Problem with hostname is that lots of tools are 
doing stuff like

hostname >> logfile.  Which causes hostname to need write access to 
postgress_log_t, ...

>>plain text document attachment (diff)
>>+bool use_syslogng false;
>>+
>>+if (use_syslogng) {
>>+allow syslogd_t proc_kmsg_t:file write;
>>+allow syslogd_t self:capability { sys_admin chown };
>>+}
>>    
>>
>
>Shouldn't this go in the ifdef(`klogd.te',`',`  block?  Its already
>there for syslogds that also do the klogd functions, like syslog-ng.  In
>fact, I think that block was originally added for syslog-ng.  That
>should eliminate the need for a boolean too.
>
>  
>
The protections are not needed for standard syslog, so I think we should 
have a boolean
saying whether you are using standard  syslog of syslog-ng (Targeted 
policy does not
ship klog.  Now maybe the other proc_kmsg stuff should be under the 
boolean?  Maybe
this should be only for Red Hat since we do not ship klog.te in targeted 
policy.  Or should
we ship klog.te for targeted policy?




-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
