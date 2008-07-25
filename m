Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6P2VPLV006730
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 22:31:25 -0400
Received: from tyo202.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6P2VNm4015862
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 02:31:24 GMT
Message-ID: <48893AF7.7030308@ak.jp.nec.com>
Date: Fri, 25 Jul 2008 11:31:19 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: hierarchy_check_constraints() needs reworks?
References: <48881546.6070903@ak.jp.nec.com> <6FE441CD9F0C0C479F2D88F959B015880246B2B9@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880246B2B9@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> KaiGai Kohei wrote:
>> In addition, I found two more potential matter in this code.

Sorry, I also found both of them derived from my code misreading. :(


>> The first one is lack of checks for permissions via attribute.
>> When a child domain has an attribute which does not applied
>> to the parent one, the child can have wider permissions that
>> its parent.
>> I think any attribute attached to child domain also have to
>> be attached to the parent domain.
>> (I guess it derived from legacy attribute implementation.)
>>
> 
> Hierarchy.c:409, expand_avtab will expand all attribute usage into the
> avtab. We don't care about attribute usage, only about net permissions
> granted. 

I understood. The expand_avtab_node() callback indeed expand all
attributes before hierarchy checks.

BTW, is it really needed to expand attributes to check hierarchy
relationship?
I think that comparison for attribute ebitmaps can detect hierarchy
violation between parent and children. In other word, this constraint
can be rewritten as "as attribute of child type has to be attached to
the parent type".
It is also useful to detect privileged attribute like mcssetcats.

>> The later one is dependencies to the state of boolean.
>> Hierarchy constraint allows a child domain to have
>> permissions which are enabled for the parent, only if
>> specific boolean is turned on. It potentially makes a
>> situation that child domain has wider permissions.
>> I think it is difficult to check in the policy toolchain, so
>> checks on an avc entry creation is better way.
>>
> 
> We don't consider the state of booleans when doing analysis of the
> policy. The idea was that the avtab is the maximum permissions allowed
> and we always test on the maximum permissions. Whether a boolean may
> reduce the parents permissions without doing so to the child I think is
> a non-issue. Do you have an example of why this might be detrimental?

It was also my code misreading. Please forget it.

I seemed to me check_avtab_hierarchy_callback() compared unconditional
permissions and conditional one, but this callback is invoked with
NULL of opt_cond_list for unconditional one.

I confirmed the following policy makes hierarchy violation.
   type smbd_t.user;
   allow smbd_t.user user_home_t : file { getattr read };

[root@fedora9 ~]# make -f /usr/share/selinux/devel/Makefile
Compiling targeted foo module
/usr/bin/checkmodule:  loading policy configuration from tmp/foo.tmp
/usr/bin/checkmodule:  policy configuration loaded
/usr/bin/checkmodule:  writing binary representation (version 8) to tmp/foo.mod
Creating targeted foo.pp policy package
rm tmp/foo.mod.fc tmp/foo.mod
[root@fedora9 ~]# semodule -i foo.pp
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types smbd_t.user and user_home_t : file {  read getattr }
libsepol.hierarchy_check_constraints: 1 total errors found during hierarchy check
libsemanage.semanage_expand_sandbox: Expand module failed
semodule:  Failed!

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
