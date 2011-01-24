Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0OJUm2Q019685
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2011 14:30:48 -0500
Received: from mail-pv0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0OJUlvu010076
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2011 19:30:47 GMT
Received: by pvg12 with SMTP id 12so875586pvg.12
        for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2011 11:30:46 -0800 (PST)
Message-ID: <4D3DD360.9090807@gmail.com>
Date: Mon, 24 Jan 2011 11:30:40 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
Subject: Re: [refpolicy] WARNING: at kernel/printk.c:430 do_syslog+0x40d/0x441()
References: <4D372829.5090509@gmail.com> <4D373A36.3050504@tresys.com> <4D373BC5.9080609@gmail.com>
In-Reply-To: <4D373BC5.9080609@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/19/11 11:30, Justin P. Mattock wrote:
> On 01/19/11 11:23, Christopher J. PeBenito wrote:
>> On 01/19/11 13:06, Justin P. Mattock wrote:
>>> this is showing up with the latest kernel in enforcing mode..
>>> (I have not update the policy and/or selinux userspace)
>>>
>>> [ 12.803882] type=1400 audit(1295457694.801:3): avc: denied { syslog
>>> } for pid=1540 comm="rsyslogd" capability=34
>>> scontext=system_u:system_r:init_t:s0
>>> tcontext=system_u:system_r:init_t:s0 tclass=capability2
>> [cut]
>>> when using audit2allow I get:
>>>
>>> allow init_t self:capability2 syslog;
>>>
>>> which gives an error when trying to install the module, due to the
>>> policy not knowing what capability2 is
>>>
>>> system is ubuntu maverick, if this is already in(refpolicy) then I'll
>>> pull the latest when I get a chance..
>>
>> Support for this capability is upstream in refpolicy.
>>
>


well... after building and trying to install, seems I need to do this:

 From dae5d4d75ab5db99fde09a67f9a1df240f85fbdd Mon Sep 17 00:00:00 2001
From: Justin P. Mattock <justinmattock@gmail.com>
Date: Mon, 24 Jan 2011 11:13:31 -0800
Subject: [PATCH] modified:   policy/modules/kernel/domain.te

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>


diff --git a/policy/modules/kernel/domain.te 
b/policy/modules/kernel/domain.te
index bc534c1..77c363b 100644
--- a/policy/modules/kernel/domain.te
+++ b/policy/modules/kernel/domain.te
@@ -24,7 +24,8 @@ attribute unconfined_domain_type;

  # Domains that can mmap low memory.
  attribute mmap_low_domain_type;
-neverallow { domain -mmap_low_domain_type } self:memprotect mmap_zero;
+#neverallow { domain -mmap_low_domain_type } self:memprotect mmap_zero;

  # Domains that can set their current context
  # (perform dynamic transitions)
-- 
1.6.5.GIT


in order for the policy to build all the way... is anybody else hitting 
this, or is this just me..

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
