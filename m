Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4FI1S1o007135
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2007 14:01:28 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l4FI1RWs008204
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2007 18:01:27 GMT
Subject: Re: squid patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <463F3BEE.6060504@redhat.com>
References: <46278600.2010806@redhat.com> <1178545161.25271.5.camel@sgc>
	 <463F3BEE.6060504@redhat.com>
Content-Type: text/plain
Date: Tue, 15 May 2007 14:00:44 -0400
Message-Id: <1179252044.725.4.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-05-07 at 10:47 -0400, Daniel J Walsh wrote:
> Ok here is an updated patch with the missing interfaces.
> 
> snmp is trying to execute sys_module, we are dontauditing
> 
> Switched from using nis_use_ypbind to nsswitch, since snmp is using nsswitch
> 
> Also sneaking in a fix for manage sendmail_log_t.

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
