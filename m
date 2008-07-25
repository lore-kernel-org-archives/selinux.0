Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6P0dMCU027050
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 20:39:22 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6P0dKgJ005387
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 00:39:21 GMT
Message-ID: <488920B2.8030408@ak.jp.nec.com>
Date: Fri, 25 Jul 2008 09:39:14 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <stephen.smalley@gmail.com>
CC: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: hierarchy_check_constraints() needs reworks?
References: <48881546.6070903@ak.jp.nec.com> <1216898673.3881.4.camel@sulphur>
In-Reply-To: <1216898673.3881.4.camel@sulphur>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2008-07-24 at 14:38 +0900, KaiGai Kohei wrote:
>> I found out that hierarchy_check_constraints() in libsepol
>> does not work correctly, as follows:
>>
>> ---- example: foo.te ----
>> module foo 1.0;
>>
>> require {
>>         class file { read write getattr setattr ioctl };
>> };
>>
>> type src;
>> type src.child;
>> type tgt;
>>
>> allow src       tgt : file { read write };
>> allow src.child tgt : file { read write getattr setattr };
>> ----------
>> [root@fedora9 kaigai]# checkmodule -m -M foo.te -o foo.mod
>> checkmodule:  loading policy configuration from foo.te
>> checkmodule:  policy configuration loaded
>> checkmodule:  writing binary representation (version 8) to foo.mod
>> [root@fedora9 kaigai]# /usr/sbin/semodule -i foo.pp
> 
> Check /etc/selinux/semanage.conf to see if you have expand-check=1 set;
> otherwise, there is no hierarchy checking or neverallow checking
> occurring there.  Disabled by default in Fedora due to the overhead and
> the view that it should be handled at policy build time rather than
> insertion time.  refpolicy has a make validate target that runs
> semodule_link followed by semodule_expand manually.

Thanks for your information.

I could get an expected behavior under expand-check=1.

[root@fedora9 ~]# semodule -i ~kaigai/foo.pp
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types sbj.child and tgt : file {  getattr setattr }
libsepol.hierarchy_check_constraints: 1 total errors found during hierarchy check
libsemanage.semanage_expand_sandbox: Expand module failed
semodule:  Failed!
[root@fedora9 ~]#

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
