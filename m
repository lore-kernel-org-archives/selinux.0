Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77EmUkH021174
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 10:48:30 -0400
Received: from mtaout03-winn.ispmail.ntl.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m77EmPl6015878
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 14:48:29 GMT
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080807144824.LQRM10791.mtaout03-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>
          for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 15:48:24 +0100
Received: from [192.168.1.102] (really [82.16.120.156])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080807144824.GFDC29597.aamtaout03-winn.ispmail.ntl.com@[192.168.1.102]>
          for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 15:48:24 +0100
Message-ID: <489B0B2D.60300@martinorr.name>
Date: Thu, 07 Aug 2008 15:48:13 +0100
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Let dpkg scripts ptrace
References: <486272E3.109@martinorr.name> <1216389265.21191.141.camel@gorn>
In-Reply-To: <1216389265.21191.141.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 18/07/08 14:54, Christopher J. PeBenito wrote:
> On Wed, 2008-06-25 at 17:31 +0100, Martin Orr wrote:
>> Some dpkg maintainer scripts run pidof, which needs the sys_ptrace capability.
>>
>> Mar 17 15:14:31 caligula kernel: audit(1205766871.788:13): avc:  denied  {
>> sys_ptrace } for  pid=4214 comm="pidof" capability=19
>> scontext=system_u:system_r:dpkg_script_t:s0
>> tcontext=system_u:system_r:dpkg_script_t:s0 tclass=capability
> 
> Seems odd, since the ptrace process permission is not allowed.  Does it
> work without this in enforcing?

It comes from trying to stat /proc/*/exe - proc_pid_readlink always checks
ptrace access.  It would indeed be strange if pidof really wanted to ptrace
anything.

Best wishes,

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
