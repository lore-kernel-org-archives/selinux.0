Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAUEEU8U027368
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 09:14:30 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lAUEEPUB020957
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 14:14:25 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: missing rules in newrole domain (RHEL5.1)
Date: Fri, 30 Nov 2007 09:11:04 -0500
Message-ID: <1196431864.4298.28.camel@gorn.columbia.tresys.com>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD02555890@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD02555890@blums0008.bluelnk.net>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-11-29 at 17:49 -0800, Clarkson, Mike R (US SSA) wrote:
> I recently switched from a targeted-mls policy to the RHEL5.1 mls
> policy. I found that "newrole -r sysadm" failed in enforcing mode, even
> though my selinux user was "root". 
> 
> I had to add "files_search_default(newrole_t)" and
> "files_getattr_default_dirs(newrole_t)" to the selinuxutil.te file to
> allow newrole to getattr and search the /tmp-inst directory (type
> default_t).
> 
> This was happening even with the read_default_t boolean set to true.
> 
> Here are the avc denial messages that I was getting:
> 
> type=AVC msg=audit(1196385320.559:722): avc:  denied  { getattr } for
> pid=5092 comm="newrole" path="/tmp-inst" dev=sda1 ino=5341337
> scontext=root:staff_r:newrole_t:s0-s4:c0.c255
> tcontext=system_u:object_r:default_t:s0 tclass=dir
> 
> type=AVC msg=audit(1196385320.559:723): avc:  denied  { search } for
> pid=5092 comm="newrole" name="tmp-inst" dev=sda1 ino=5341337
> scontext=root:staff_r:newrole_t:s0-s4:c0.c255
> tcontext=system_u:object_r:default_t:s0 tclass=dir
> 
> I'm assuming this should have worked out of the box without having to
> add these rules. Is there some configuration step that I missed?

It just means that you newroled while you were in this directory.
Newrole doesn't utilize read_default_t because we don't want privileged
programs like newrole accessing random default_t objects.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
