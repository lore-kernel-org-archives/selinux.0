Return-Path: <SRS0=P1AD=VJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B834CC742D2
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 18:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4FA205ED
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 18:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="R9Lg1z3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfGLSZa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jul 2019 14:25:30 -0400
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:15029 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLSZa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jul 2019 14:25:30 -0400
X-EEMSG-check-017: 239478235|UPBD19PA08_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Jul 2019 18:25:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1562955921; x=1594491921;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=twyBvw+m+WEOC9bop/bjQaAJx38n2Xs/Ayswb4Hzy6k=;
  b=R9Lg1z3Kd2ZZ3Kx3MNOpPsSopghyr7vJC0O0v07ZQyPeWzoDADG/LnUd
   qOAUxpsJ6d55yAKaNS4Kmwq2e1f7D5m3QX/5G60213/RqzMWVlmF3zec6
   X1PdJ8ek4lv091QuDsHj3W7MC/tOomPE5WRxlDd51X+pImv+9rYN6gUNW
   CERQ1RuNdIQTWhg/8I9yBeGER+PfdVM3zpA7t5bwbmoPz9ewMXymsSZDC
   XFEPk3/iom+zxbqPU7Mx/i9rPYKeUlSatdObxV4nkVxx8+FTMNYG7M0Q6
   iB6sbke3lZyBWbDlLDF4/BBYf3dJtNmRG+S0gPnmWHNDk94LRJarwSh5V
   A==;
X-IronPort-AV: E=Sophos;i="5.63,483,1557187200"; 
   d="scan'208";a="25661791"
IronPort-PHdr: =?us-ascii?q?9a23=3A+GiAwRSHci4bs0hhn+4sZBQNUdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YBWCt8tkgFKBZ4jH8fUM07OQ7/m6HzFYqs/b6TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrswndrMkbjZdtJqos1B?=
 =?us-ascii?q?fFv2ZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSsAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oPsUXMAi/2mELsgK+Qakok4fSn5/7iYrXnop+QL450igfgPaQygsGzHOs1Pw?=
 =?us-ascii?q?cUU2Wb5OiwzqPv8ELnTLlQk/E6iqzZv4rbJcQfqK65GQhV0oM75hakEjimy8?=
 =?us-ascii?q?8VnWUHLV1ZeBKHiJLlO1fVIP/iF/u/jFOskClzy/DcIrLhGonNLmTEkLr5Yb?=
 =?us-ascii?q?ly8VVcxxQzzN1E/JJbFrEBL+juWk//sNzXEAU5PxWozOn9EtlyyoQeWWeXCK?=
 =?us-ascii?q?+DLKzSqUOI5v4oI+SUfI8aoiv9K/w+6v72l3A5hFsdcbCs3ZsQb3C4BOppL1?=
 =?us-ascii?q?+Fbnrrh9cLCX0KsRYmTOz2lF2CViZeZ22sUKI45zE7Dp+mDIjYS4Czj7yOwj?=
 =?us-ascii?q?27EodVZm9YEFCMF2nnd4GeV/cLciKSLddrkiYYWri5V48hyRauuRf+y7pmKO?=
 =?us-ascii?q?rU5yIZuYv41Ndr++LTiAsy9T1oD8Wdym2NSmZ0kX4VRz8ywq9yulJ9ylid3q?=
 =?us-ascii?q?himfBYFsJc5+lPUggkMZ7Q1et6C8r9WgjZZNeGVE6mQsm6ATE2Vt8xx8IOY1?=
 =?us-ascii?q?p6G9i5lB/D2jClDKMPmLyTBZw07rjT33zrK8Z71XnGyLErj0M6TctXKW2mmq?=
 =?us-ascii?q?l/+hDRB47MlEWZjbyqdaUH3CPW8meM12+Os19ZUAJqVqXFR38fbFPMrdvl/k?=
 =?us-ascii?q?PCU6OuCbM/PwtC18GNNLBKZcHujVVBR/fuI8jRY2Krm2e3ABaIx66MbI/wd2?=
 =?us-ascii?q?UaxiXdB1AOkxoP8naeKQg+GiChrnrFDDNwD1LvbF3j/PJ+qHyhSk80ywGLb0?=
 =?us-ascii?q?t727Wp/R4VgOSWS+kP0bIcpCchtzJ0EU6/39LRC9qAoRBtfKdbYdM9+lhH03?=
 =?us-ascii?q?nZuBJ7PpG7M69tnFgecwNxv0Pvyxp4EIFAndI2o3MtyQp4MbiY309ZdzOEwZ?=
 =?us-ascii?q?DwPaXaKmz1/BC1d67W3Vfe0NON96gT6PQ4sVLjvASoFko/9nVryd5V02GT5s?=
 =?us-ascii?q?aCMA1HepvqX1d/zBN6rqzUZiQnr9ff3GZhIIGvuT/LxtwtCfFgwR/mdNBaZu?=
 =?us-ascii?q?fMMg75E8oeDtPmBvYjnVOqJkYCPO5I/ahuF9+3fPuBnqiwNaBvmyzwySxf6Z?=
 =?us-ascii?q?15+lqF6i45T+nPxZtDyPadjSWdUDKpt0usqsD6n8h/YDgWGmeugXz/CJV5er?=
 =?us-ascii?q?x5fYFND3ynZcKw2IMt1NbWR3dE+Qv7VBs908izdE/XNgGs0A=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DUAAB3zyhd/wHyM5BbAggbAQEBAQMBAQEHAwEBAYFng?=
 =?us-ascii?q?WgFKoFuKIQckzABAQEBAQEGgQktfohiiX2FMYFnCQEBAQEBAQEBATQBAgEBh?=
 =?us-ascii?q?EACglYjOBMBAwEBAQQBAQEBBAEBbIVIgjopAYJmAQEBAQIBGgkEETQKAwULC?=
 =?us-ascii?q?xgCAhEVAgJXBgEMBAICAQGCXz+BdwUPrCl/M4VHgy6BR4EMKItfF3iBB4ERJ?=
 =?us-ascii?q?4I2NT6DfxoGZIJLglgEjFGIIJVxCYIbgh+RZgYbmActjQeZXCGBWCsIAhgII?=
 =?us-ascii?q?Q+DJ4JNFxSOKSMDBCyBBgEBj2IBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Jul 2019 18:25:18 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x6CIPHpu022434;
        Fri, 12 Jul 2019 14:25:17 -0400
Subject: Re: [RFC PATCH] security, capability: pass object information to
 security_capable
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        luto@amacapital.net, jmorris@namei.org, keescook@chromium.org,
        serge@hallyn.com, john.johansen@canonical.com, mortonm@chromium.org
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
 <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov>
Date:   Fri, 12 Jul 2019 14:25:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/12/19 1:58 PM, Casey Schaufler wrote:
> On 7/12/2019 10:34 AM, Nicholas Franck wrote:
>> At present security_capable does not pass any object information
>> and therefore can neither audit the particular object nor take it
>> into account. Augment the security_capable interface to support
>> passing supplementary data. Use this facility initially to convey
>> the inode for capability checks relevant to inodes. This only
>> addresses capable_wrt_inode_uidgid calls; other capability checks
>> relevant to inodes will be addressed in subsequent changes. In the
>> future, this will be further extended to pass object information for
>> other capability checks such as the target task for CAP_KILL.
> 
> This seems wrong to me. The capability system has nothing to do
> with objects. Passing object information through security_capable()
> may be convenient, but isn't relevant to the purpose of the interface.
> It appears that there are very few places where the object information
> is actually useful.

A fair number of capabilities are checked upon some attempted object 
access (often right after comparing UIDs or other per-object state), and 
the particular object can be very helpful in both audit and in access 
control.  More below.

> 
>> In SELinux this new information is leveraged here to include the inode
>> in the audit message. In the future, it could also be used to perform
>> a per inode capability checks.
> 
> I suggest that you want a mechanism for adding the inode information
> to the audit record instead.

That is part of what we want, but not the entire picture.  But with 
respect to audit, the problem today is that one sees SELinux 
dac_read_search, dac_override, etc denials with no indication as to the 
particular file, which is unfortunate both from a security auditing 
perspective and from a policy development perspective.  The only option 
today to gain that information is by enabling system call audit and 
setting at least one audit filter so that the audit framework will 
collect that information and include it in the audit records that are 
emitted upon syscall exit after any such AVC denial.  Unfortunately, 
that is all disabled by default on most systems due to its associated 
performance overhead, and one doesn't even have the option of enabling 
it on some systems, e.g. Android devices.  And even when one can enable 
syscall audit, one must correlate the syscall audit record to the 
associated AVC record to identify the object rather than having the 
information directly included in the same record.


> What would a "per inode" capability check be? Capability checks are
> process checks, not object checks.

Ideally it would be possible to scope dac_override and other 
capabilities to specific objects rather than having to allow it for all 
or none.  Just because a process needs to override DAC on one file or 
one set of files is not a reason to allow it to do so on every file it 
can access at all.  If we want to apply least privilege, then this is a 
desirable facility.  I understand that doesn't mesh with Smack's mental 
model but it would probably be useful to both SELinux and AppArmor, 
among others.


> 
>> It would be possible to fold the existing opts argument into this new
>> supplementary data structure. This was omitted from this change to
>> minimize changes.
>>
>> Signed-off-by: Nicholas Franck <nhfran2@tycho.nsa.gov>
>> ---
>>   include/linux/capability.h             |  7 ++++++
>>   include/linux/lsm_audit.h              |  5 +++-
>>   include/linux/lsm_hooks.h              |  3 ++-
>>   include/linux/security.h               | 23 +++++++++++++-----
>>   kernel/capability.c                    | 33 ++++++++++++++++++--------
>>   kernel/seccomp.c                       |  2 +-
>>   security/apparmor/capability.c         |  8 ++++---
>>   security/apparmor/include/capability.h |  4 +++-
>>   security/apparmor/ipc.c                |  2 +-
>>   security/apparmor/lsm.c                |  5 ++--
>>   security/apparmor/resource.c           |  2 +-
>>   security/commoncap.c                   | 11 +++++----
>>   security/lsm_audit.c                   | 21 ++++++++++++++--
>>   security/safesetid/lsm.c               |  3 ++-
>>   security/security.c                    |  5 ++--
>>   security/selinux/hooks.c               | 20 +++++++++-------
>>   security/smack/smack_access.c          |  2 +-
>>   17 files changed, 110 insertions(+), 46 deletions(-)
>>
>> diff --git a/include/linux/capability.h b/include/linux/capability.h
>> index ecce0f43c73a..f72de64c179d 100644
>> --- a/include/linux/capability.h
>> +++ b/include/linux/capability.h
>> @@ -211,6 +211,8 @@ extern bool capable(int cap);
>>   extern bool ns_capable(struct user_namespace *ns, int cap);
>>   extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
>>   extern bool ns_capable_setid(struct user_namespace *ns, int cap);
>> +extern bool ns_capable_inode(struct user_namespace *ns, int cap,
>> +			     const struct inode *inode);
>>   #else
>>   static inline bool has_capability(struct task_struct *t, int cap)
>>   {
>> @@ -246,6 +248,11 @@ static inline bool ns_capable_setid(struct user_namespace *ns, int cap)
>>   {
>>   	return true;
>>   }
>> +static bool ns_capable_inode(struct user_namespace *ns, int cap,
>> +			     const struct inode *inode)
>> +{
>> +	return true;
>> +}
>>   #endif /* CONFIG_MULTIUSER */
>>   extern bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct inode *inode);
>>   extern bool capable_wrt_inode_uidgid(const struct inode *inode, int cap);
>> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
>> index 915330abf6e5..15d2a62639f0 100644
>> --- a/include/linux/lsm_audit.h
>> +++ b/include/linux/lsm_audit.h
>> @@ -79,7 +79,10 @@ struct common_audit_data {
>>   		struct dentry *dentry;
>>   		struct inode *inode;
>>   		struct lsm_network_audit *net;
>> -		int cap;
>> +		struct  {
>> +			int cap;
> 
>> +			struct cap_aux_data *cad;
>> +		} cap_struct;
>>   		int ipc_id;
>>   		struct task_struct *tsk;
>>   #ifdef CONFIG_KEYS
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 47f58cfb6a19..b2a37d613030 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -1469,7 +1469,8 @@ union security_list_options {
>>   	int (*capable)(const struct cred *cred,
>>   			struct user_namespace *ns,
>>   			int cap,
>> -			unsigned int opts);
>> +			unsigned int opts,
>> +			struct cap_aux_data *cad);
>>   	int (*quotactl)(int cmds, int type, int id, struct super_block *sb);
>>   	int (*quota_on)(struct dentry *dentry);
>>   	int (*syslog)(int type);
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 659071c2e57c..8fce5e69dc52 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -77,9 +77,18 @@ enum lsm_event {
>>   	LSM_POLICY_CHANGE,
>>   };
>>   
>> +
>> +struct cap_aux_data {
>> +	char type;
>> +#define CAP_AUX_DATA_INODE	1
>> +	union	{
>> +		const struct inode *inode;
>> +	} u;
>> +};
>> +
>>   /* These functions are in security/commoncap.c */
>>   extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>> -		       int cap, unsigned int opts);
>> +		       int cap, unsigned int opts, struct cap_aux_data *cad);
>>   extern int cap_settime(const struct timespec64 *ts, const struct timezone *tz);
>>   extern int cap_ptrace_access_check(struct task_struct *child, unsigned int mode);
>>   extern int cap_ptrace_traceme(struct task_struct *parent);
>> @@ -215,9 +224,10 @@ int security_capset(struct cred *new, const struct cred *old,
>>   		    const kernel_cap_t *inheritable,
>>   		    const kernel_cap_t *permitted);
>>   int security_capable(const struct cred *cred,
>> -		       struct user_namespace *ns,
>> -		       int cap,
>> -		       unsigned int opts);
>> +		     struct user_namespace *ns,
>> +		     int cap,
>> +		     unsigned int opts,
>> +		     struct cap_aux_data *cad);
>>   int security_quotactl(int cmds, int type, int id, struct super_block *sb);
>>   int security_quota_on(struct dentry *dentry);
>>   int security_syslog(int type);
>> @@ -478,9 +488,10 @@ static inline int security_capset(struct cred *new,
>>   static inline int security_capable(const struct cred *cred,
>>   				   struct user_namespace *ns,
>>   				   int cap,
>> -				   unsigned int opts)
>> +				   unsigned int opts,
>> +				   struct cap_aux_data *cad)
>>   {
>> -	return cap_capable(cred, ns, cap, opts);
>> +	return cap_capable(cred, ns, cap, opts, NULL);
>>   }
>>   
>>   static inline int security_quotactl(int cmds, int type, int id,
>> diff --git a/kernel/capability.c b/kernel/capability.c
>> index 1444f3954d75..c3723443904a 100644
>> --- a/kernel/capability.c
>> +++ b/kernel/capability.c
>> @@ -297,7 +297,7 @@ bool has_ns_capability(struct task_struct *t,
>>   	int ret;
>>   
>>   	rcu_read_lock();
>> -	ret = security_capable(__task_cred(t), ns, cap, CAP_OPT_NONE);
>> +	ret = security_capable(__task_cred(t), ns, cap, CAP_OPT_NONE, NULL);
>>   	rcu_read_unlock();
>>   
>>   	return (ret == 0);
>> @@ -338,7 +338,7 @@ bool has_ns_capability_noaudit(struct task_struct *t,
>>   	int ret;
>>   
>>   	rcu_read_lock();
>> -	ret = security_capable(__task_cred(t), ns, cap, CAP_OPT_NOAUDIT);
>> +	ret = security_capable(__task_cred(t), ns, cap, CAP_OPT_NOAUDIT, NULL);
>>   	rcu_read_unlock();
>>   
>>   	return (ret == 0);
>> @@ -363,7 +363,8 @@ bool has_capability_noaudit(struct task_struct *t, int cap)
>>   
>>   static bool ns_capable_common(struct user_namespace *ns,
>>   			      int cap,
>> -			      unsigned int opts)
>> +			      unsigned int opts,
>> +			      struct cap_aux_data *cad)
>>   {
>>   	int capable;
>>   
>> @@ -372,7 +373,7 @@ static bool ns_capable_common(struct user_namespace *ns,
>>   		BUG();
>>   	}
>>   
>> -	capable = security_capable(current_cred(), ns, cap, opts);
>> +	capable = security_capable(current_cred(), ns, cap, opts, cad);
>>   	if (capable == 0) {
>>   		current->flags |= PF_SUPERPRIV;
>>   		return true;
>> @@ -393,7 +394,7 @@ static bool ns_capable_common(struct user_namespace *ns,
>>    */
>>   bool ns_capable(struct user_namespace *ns, int cap)
>>   {
>> -	return ns_capable_common(ns, cap, CAP_OPT_NONE);
>> +	return ns_capable_common(ns, cap, CAP_OPT_NONE, NULL);
>>   }
>>   EXPORT_SYMBOL(ns_capable);
>>   
>> @@ -411,7 +412,7 @@ EXPORT_SYMBOL(ns_capable);
>>    */
>>   bool ns_capable_noaudit(struct user_namespace *ns, int cap)
>>   {
>> -	return ns_capable_common(ns, cap, CAP_OPT_NOAUDIT);
>> +	return ns_capable_common(ns, cap, CAP_OPT_NOAUDIT, NULL);
>>   }
>>   EXPORT_SYMBOL(ns_capable_noaudit);
>>   
>> @@ -430,7 +431,7 @@ EXPORT_SYMBOL(ns_capable_noaudit);
>>    */
>>   bool ns_capable_setid(struct user_namespace *ns, int cap)
>>   {
>> -	return ns_capable_common(ns, cap, CAP_OPT_INSETID);
>> +	return ns_capable_common(ns, cap, CAP_OPT_INSETID, NULL);
>>   }
>>   EXPORT_SYMBOL(ns_capable_setid);
>>   
>> @@ -470,7 +471,7 @@ bool file_ns_capable(const struct file *file, struct user_namespace *ns,
>>   	if (WARN_ON_ONCE(!cap_valid(cap)))
>>   		return false;
>>   
>> -	if (security_capable(file->f_cred, ns, cap, CAP_OPT_NONE) == 0)
>> +	if (security_capable(file->f_cred, ns, cap, CAP_OPT_NONE, NULL) == 0)
>>   		return true;
>>   
>>   	return false;
>> @@ -503,7 +504,8 @@ bool capable_wrt_inode_uidgid(const struct inode *inode, int cap)
>>   {
>>   	struct user_namespace *ns = current_user_ns();
>>   
>> -	return ns_capable(ns, cap) && privileged_wrt_inode_uidgid(ns, inode);
>> +	return ns_capable_inode(ns, cap, inode) &&
>> +		privileged_wrt_inode_uidgid(ns, inode);
>>   }
>>   EXPORT_SYMBOL(capable_wrt_inode_uidgid);
>>   
>> @@ -524,7 +526,18 @@ bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns)
>>   	cred = rcu_dereference(tsk->ptracer_cred);
>>   	if (cred)
>>   		ret = security_capable(cred, ns, CAP_SYS_PTRACE,
>> -				       CAP_OPT_NOAUDIT);
>> +				       CAP_OPT_NOAUDIT, NULL);
>>   	rcu_read_unlock();
>>   	return (ret == 0);
>>   }
>> +
>> +bool ns_capable_inode(struct user_namespace *ns, int cap,
>> +			const struct inode *inode)
>> +{
>> +	struct cap_aux_data cad;
>> +
>> +	cad.type = CAP_AUX_DATA_INODE;
>> +	cad.u.inode = inode;
>> +	return ns_capable_common(ns, cap, CAP_OPT_NONE, &cad);
>> +}
>> +EXPORT_SYMBOL(ns_capable_inode);
>> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>> index 811b4a86cdf6..d59dd7079ece 100644
>> --- a/kernel/seccomp.c
>> +++ b/kernel/seccomp.c
>> @@ -446,7 +446,7 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
>>   	 */
>>   	if (!task_no_new_privs(current) &&
>>   	    security_capable(current_cred(), current_user_ns(),
>> -				     CAP_SYS_ADMIN, CAP_OPT_NOAUDIT) != 0)
>> +			     CAP_SYS_ADMIN, CAP_OPT_NOAUDIT, NULL) != 0)
>>   		return ERR_PTR(-EACCES);
>>   
>>   	/* Allocate a new seccomp_filter */
>> diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
>> index 752f73980e30..c45192a16733 100644
>> --- a/security/apparmor/capability.c
>> +++ b/security/apparmor/capability.c
>> @@ -50,7 +50,7 @@ static void audit_cb(struct audit_buffer *ab, void *va)
>>   	struct common_audit_data *sa = va;
>>   
>>   	audit_log_format(ab, " capname=");
>> -	audit_log_untrustedstring(ab, capability_names[sa->u.cap]);
>> +	audit_log_untrustedstring(ab, capability_names[sa->u.cap_struct.cap]);
>>   }
>>   
>>   /**
>> @@ -148,13 +148,15 @@ static int profile_capable(struct aa_profile *profile, int cap,
>>    *
>>    * Returns: 0 on success, or else an error code.
>>    */
>> -int aa_capable(struct aa_label *label, int cap, unsigned int opts)
>> +int aa_capable(struct aa_label *label, int cap, unsigned int opts,
>> +	       struct cap_aux_data *cad)
>>   {
>>   	struct aa_profile *profile;
>>   	int error = 0;
>>   	DEFINE_AUDIT_DATA(sa, LSM_AUDIT_DATA_CAP, OP_CAPABLE);
>>   
>> -	sa.u.cap = cap;
>> +	sa.u.cap_struct.cap = cap;
>> +	sa.u.cap_struct.cad = cad;
>>   	error = fn_for_each_confined(label, profile,
>>   			profile_capable(profile, cap, opts, &sa));
>>   
>> diff --git a/security/apparmor/include/capability.h b/security/apparmor/include/capability.h
>> index 1b3663b6ab12..d888f09d76d1 100644
>> --- a/security/apparmor/include/capability.h
>> +++ b/security/apparmor/include/capability.h
>> @@ -20,6 +20,7 @@
>>   #include "apparmorfs.h"
>>   
>>   struct aa_label;
>> +struct cap_aux_data;
>>   
>>   /* aa_caps - confinement data for capabilities
>>    * @allowed: capabilities mask
>> @@ -40,7 +41,8 @@ struct aa_caps {
>>   
>>   extern struct aa_sfs_entry aa_sfs_entry_caps[];
>>   
>> -int aa_capable(struct aa_label *label, int cap, unsigned int opts);
>> +int aa_capable(struct aa_label *label, int cap, unsigned int opts,
>> +	       struct cap_aux_data *cad);
>>   
>>   static inline void aa_free_cap_rules(struct aa_caps *caps)
>>   {
>> diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
>> index aacd1e95cb59..deb5267ca695 100644
>> --- a/security/apparmor/ipc.c
>> +++ b/security/apparmor/ipc.c
>> @@ -108,7 +108,7 @@ static int profile_tracer_perm(struct aa_profile *tracer,
>>   	aad(sa)->peer = tracee;
>>   	aad(sa)->request = 0;
>>   	aad(sa)->error = aa_capable(&tracer->label, CAP_SYS_PTRACE,
>> -				    CAP_OPT_NONE);
>> +				    CAP_OPT_NONE, NULL);
>>   
>>   	return aa_audit(AUDIT_APPARMOR_AUTO, tracer, sa, audit_ptrace_cb);
>>   }
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index 87500bde5a92..82790accb679 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -172,14 +172,15 @@ static int apparmor_capget(struct task_struct *target, kernel_cap_t *effective,
>>   }
>>   
>>   static int apparmor_capable(const struct cred *cred, struct user_namespace *ns,
>> -			    int cap, unsigned int opts)
>> +			    int cap, unsigned int opts,
>> +			    struct cap_aux_data *cad)
>>   {
>>   	struct aa_label *label;
>>   	int error = 0;
>>   
>>   	label = aa_get_newest_cred_label(cred);
>>   	if (!unconfined(label))
>> -		error = aa_capable(label, cap, opts);
>> +		error = aa_capable(label, cap, opts, cad);
>>   	aa_put_label(label);
>>   
>>   	return error;
>> diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
>> index 552ed09cb47e..9b3d4b4437f2 100644
>> --- a/security/apparmor/resource.c
>> +++ b/security/apparmor/resource.c
>> @@ -124,7 +124,7 @@ int aa_task_setrlimit(struct aa_label *label, struct task_struct *task,
>>   	 */
>>   
>>   	if (label != peer &&
>> -	    aa_capable(label, CAP_SYS_RESOURCE, CAP_OPT_NOAUDIT) != 0)
>> +	    aa_capable(label, CAP_SYS_RESOURCE, CAP_OPT_NOAUDIT, NULL) != 0)
>>   		error = fn_for_each(label, profile,
>>   				audit_resource(profile, resource,
>>   					       new_rlim->rlim_max, peer,
>> diff --git a/security/commoncap.c b/security/commoncap.c
>> index c477fb673701..1860ea50f473 100644
>> --- a/security/commoncap.c
>> +++ b/security/commoncap.c
>> @@ -68,7 +68,7 @@ static void warn_setuid_and_fcaps_mixed(const char *fname)
>>    * kernel's capable() and has_capability() returns 1 for this case.
>>    */
>>   int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
>> -		int cap, unsigned int opts)
>> +		int cap, unsigned int opts, struct cap_aux_data *cad)
>>   {
>>   	struct user_namespace *ns = targ_ns;
>>   
>> @@ -226,7 +226,7 @@ static inline int cap_inh_is_capped(void)
>>   	 * capability
>>   	 */
>>   	if (cap_capable(current_cred(), current_cred()->user_ns,
>> -			CAP_SETPCAP, CAP_OPT_NONE) == 0)
>> +			CAP_SETPCAP, CAP_OPT_NONE, NULL) == 0)
>>   		return 0;
>>   	return 1;
>>   }
>> @@ -1211,7 +1211,8 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>>   		    || (cap_capable(current_cred(),
>>   				    current_cred()->user_ns,
>>   				    CAP_SETPCAP,
>> -				    CAP_OPT_NONE) != 0)			/*[4]*/
>> +				    CAP_OPT_NONE,
>> +				    NULL) != 0)				/*[4]*/
>>   			/*
>>   			 * [1] no changing of bits that are locked
>>   			 * [2] no unlocking of locks
>> @@ -1307,7 +1308,7 @@ int cap_vm_enough_memory(struct mm_struct *mm, long pages)
>>   	int cap_sys_admin = 0;
>>   
>>   	if (cap_capable(current_cred(), &init_user_ns,
>> -				CAP_SYS_ADMIN, CAP_OPT_NOAUDIT) == 0)
>> +				CAP_SYS_ADMIN, CAP_OPT_NOAUDIT, NULL) == 0)
>>   		cap_sys_admin = 1;
>>   
>>   	return cap_sys_admin;
>> @@ -1328,7 +1329,7 @@ int cap_mmap_addr(unsigned long addr)
>>   
>>   	if (addr < dac_mmap_min_addr) {
>>   		ret = cap_capable(current_cred(), &init_user_ns, CAP_SYS_RAWIO,
>> -				  CAP_OPT_NONE);
>> +				  CAP_OPT_NONE, NULL);
>>   		/* set PF_SUPERPRIV if it turns out we allow the low mmap */
>>   		if (ret == 0)
>>   			current->flags |= PF_SUPERPRIV;
>> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
>> index 33028c098ef3..4871b2508a4a 100644
>> --- a/security/lsm_audit.c
>> +++ b/security/lsm_audit.c
>> @@ -229,9 +229,26 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>>   	case LSM_AUDIT_DATA_IPC:
>>   		audit_log_format(ab, " key=%d ", a->u.ipc_id);
>>   		break;
>> -	case LSM_AUDIT_DATA_CAP:
>> -		audit_log_format(ab, " capability=%d ", a->u.cap);
>> +	case LSM_AUDIT_DATA_CAP: {
>> +		const struct inode *inode;
>> +
>> +		if (a->u.cap_struct.cad) {
>> +			switch (a->u.cap_struct.cad->type) {
>> +			case CAP_AUX_DATA_INODE: {
>> +				inode = a->u.cap_struct.cad->u.inode;
>> +
>> +				audit_log_format(ab, " dev=");
>> +				audit_log_untrustedstring(ab,
>> +					inode->i_sb->s_id);
>> +				audit_log_format(ab, " ino=%lu",
>> +					inode->i_ino);
>> +				break;
>> +			}
>> +			}
>> +		}
>> +		audit_log_format(ab, " capability=%d ", a->u.cap_struct.cap);
>>   		break;
>> +	}
>>   	case LSM_AUDIT_DATA_PATH: {
>>   		struct inode *inode;
>>   
>> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
>> index cecd38e2ac80..c74ed83e9501 100644
>> --- a/security/safesetid/lsm.c
>> +++ b/security/safesetid/lsm.c
>> @@ -80,7 +80,8 @@ static bool check_setuid_policy_hashtable_key_value(kuid_t parent,
>>   static int safesetid_security_capable(const struct cred *cred,
>>   				      struct user_namespace *ns,
>>   				      int cap,
>> -				      unsigned int opts)
>> +				      unsigned int opts,
>> +				      struct cap_aux_data *cad)
>>   {
>>   	if (cap == CAP_SETUID &&
>>   	    check_setuid_policy_hashtable_key(cred->uid)) {
>> diff --git a/security/security.c b/security/security.c
>> index 613a5c00e602..06274a7b9c4e 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -691,9 +691,10 @@ int security_capset(struct cred *new, const struct cred *old,
>>   int security_capable(const struct cred *cred,
>>   		     struct user_namespace *ns,
>>   		     int cap,
>> -		     unsigned int opts)
>> +		     unsigned int opts,
>> +		     struct cap_aux_data *cad)
>>   {
>> -	return call_int_hook(capable, 0, cred, ns, cap, opts);
>> +	return call_int_hook(capable, 0, cred, ns, cap, opts, cad);
>>   }
>>   
>>   int security_quotactl(int cmds, int type, int id, struct super_block *sb)
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index f77b314d0575..d6c699ed06be 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -1618,7 +1618,10 @@ static inline u32 signal_to_av(int sig)
>>   
>>   /* Check whether a task is allowed to use a capability. */
>>   static int cred_has_capability(const struct cred *cred,
>> -			       int cap, unsigned int opts, bool initns)
>> +				int cap,
>> +				unsigned int opts,
>> +				bool initns,
>> +				struct cap_aux_data *cad)
>>   {
>>   	struct common_audit_data ad;
>>   	struct av_decision avd;
>> @@ -1628,7 +1631,8 @@ static int cred_has_capability(const struct cred *cred,
>>   	int rc;
>>   
>>   	ad.type = LSM_AUDIT_DATA_CAP;
>> -	ad.u.cap = cap;
>> +	ad.u.cap_struct.cad = cad;
>> +	ad.u.cap_struct.cap = cap;
>>   
>>   	switch (CAP_TO_INDEX(cap)) {
>>   	case 0:
>> @@ -2165,9 +2169,9 @@ static int selinux_capset(struct cred *new, const struct cred *old,
>>    */
>>   
>>   static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
>> -			   int cap, unsigned int opts)
>> +			   int cap, unsigned int opts, struct cap_aux_data *cad)
>>   {
>> -	return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
>> +	return cred_has_capability(cred, cap, opts, ns == &init_user_ns, cad);
>>   }
>>   
>>   static int selinux_quotactl(int cmds, int type, int id, struct super_block *sb)
>> @@ -2241,7 +2245,7 @@ static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
>>   	int rc, cap_sys_admin = 0;
>>   
>>   	rc = cred_has_capability(current_cred(), CAP_SYS_ADMIN,
>> -				 CAP_OPT_NOAUDIT, true);
>> +				 CAP_OPT_NOAUDIT, true, NULL);
>>   	if (rc == 0)
>>   		cap_sys_admin = 1;
>>   
>> @@ -3101,9 +3105,9 @@ static bool has_cap_mac_admin(bool audit)
>>   	const struct cred *cred = current_cred();
>>   	unsigned int opts = audit ? CAP_OPT_NONE : CAP_OPT_NOAUDIT;
>>   
>> -	if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, opts))
>> +	if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, opts, NULL))
>>   		return false;
>> -	if (cred_has_capability(cred, CAP_MAC_ADMIN, opts, true))
>> +	if (cred_has_capability(cred, CAP_MAC_ADMIN, opts, true, NULL))
>>   		return false;
>>   	return true;
>>   }
>> @@ -3563,7 +3567,7 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
>>   	case KDSKBENT:
>>   	case KDSKBSENT:
>>   		error = cred_has_capability(cred, CAP_SYS_TTY_CONFIG,
>> -					    CAP_OPT_NONE, true);
>> +					    CAP_OPT_NONE, true, NULL);
>>   		break;
>>   
>>   	/* default case assumes that the command will go
>> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
>> index fe2ce3a65822..e961bfe8f00a 100644
>> --- a/security/smack/smack_access.c
>> +++ b/security/smack/smack_access.c
>> @@ -640,7 +640,7 @@ bool smack_privileged_cred(int cap, const struct cred *cred)
>>   	struct smack_known_list_elem *sklep;
>>   	int rc;
>>   
>> -	rc = cap_capable(cred, &init_user_ns, cap, CAP_OPT_NONE);
>> +	rc = cap_capable(cred, &init_user_ns, cap, CAP_OPT_NONE, NULL);
>>   	if (rc)
>>   		return false;
>>   
> 

