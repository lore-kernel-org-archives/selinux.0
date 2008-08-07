Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77H1Wvd011707
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 13:01:32 -0400
Received: from mtaout03-winn.ispmail.ntl.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m77H1NQx001293
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 17:01:23 GMT
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080807170130.NVVM10791.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>
          for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 18:01:30 +0100
Received: from [192.168.1.102] (really [82.16.120.156])
          by aamtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080807170130.GYNJ5827.aamtaout01-winn.ispmail.ntl.com@[192.168.1.102]>
          for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 18:01:30 +0100
Message-ID: <489B2A60.4020204@martinorr.name>
Date: Thu, 07 Aug 2008 18:01:20 +0100
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Let dhcp use init fds
References: <486277AC.9080801@martinorr.name> <1216391538.21191.149.camel@gorn>
In-Reply-To: <1216391538.21191.149.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 18/07/08 15:32, Christopher J. PeBenito wrote:
> On Wed, 2008-06-25 at 17:51 +0100, Martin Orr wrote:
>> Without this patch, I see no output from dhclient when it is run during boot.
>> There is no avc message because it is dontaudited in init_daemon_domain.
>>
>> Index: policy/modules/system/sysnetwork.te
>> ===================================================================
>> --- policy/modules/system/sysnetwork.te.orig
>> +++ policy/modules/system/sysnetwork.te
>> @@ -126,6 +126,7 @@
>>  files_dontaudit_search_locks(dhcpc_t)
>>
>>  init_rw_utmp(dhcpc_t)
>> +init_use_fds(dhcpc_t)
>>
>>  logging_send_syslog_msg(dhcpc_t)
> 
> I would think that allowing it to write to the console would be required
> to make this work too.  If thats the case I'm not sure we want it; I
> don't think we want daemons writing to the console.

That puzzled me too, and I tracked it down to logging_send_syslog_msg:
	# cjp: this should most likely be removed:
	term_use_console($1)

I want messages from dhcp specifically to appear on the console, because it
takes a long time and can fail e.g. if I knocked the network cable loose,
but I suppose that's not enough reason to put it in refpolicy, and I can
keep it in my local policy quite happily.

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
