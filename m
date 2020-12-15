Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057A7C4361B
	for <selinux@archiver.kernel.org>; Tue, 15 Dec 2020 21:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA08622A99
	for <selinux@archiver.kernel.org>; Tue, 15 Dec 2020 21:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgLOVrs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Dec 2020 16:47:48 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:47236 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgLOVrh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Dec 2020 16:47:37 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kpI9Q-00GVVa-Dr; Tue, 15 Dec 2020 14:46:32 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kpI9P-0000nn-KD; Tue, 15 Dec 2020 14:46:32 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
        <87tusplqwf.fsf@x220.int.ebiederm.org>
        <87sg88tiex.fsf@stepbren-lnx.us.oracle.com>
Date:   Tue, 15 Dec 2020 15:45:46 -0600
In-Reply-To: <87sg88tiex.fsf@stepbren-lnx.us.oracle.com> (Stephen Brennan's
        message of "Mon, 14 Dec 2020 09:19:02 -0800")
Message-ID: <87pn3ag2ut.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kpI9P-0000nn-KD;;;mid=<87pn3ag2ut.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19exJiefmNpiIKTjIA+TojL4dkxYhuoRNk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Stephen Brennan <stephen.s.brennan@oracle.com> writes:
>>
>>> The pid_revalidate() function requires dropping from RCU into REF lookup
>>> mode. When many threads are resolving paths within /proc in parallel,
>>> this can result in heavy spinlock contention as each thread tries to
>>> grab a reference to the /proc dentry lock (and drop it shortly
>>> thereafter).
>>
>> I am feeling dense at the moment.  Which lock specifically are you
>> referring to?  The only locks I can thinking of are sleeping locks,
>> not spinlocks.
>
> The lock in question is the d_lockref field (aliased as d_lock) of
> struct dentry. It is contended in this code path while processing the
> "/proc" dentry, switching from RCU to REF mode.
>
>     walk_component()
>       lookup_fast()
>         d_revalidate()
>           pid_revalidate() // returns -ECHILD
>         unlazy_child()
>           lockref_get_not_dead(&nd->path.dentry->d_lockref)
>
>>
>>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>>> index ebea9501afb8..833d55a59e20 100644
>>> --- a/fs/proc/base.c
>>> +++ b/fs/proc/base.c
>>> @@ -1830,19 +1846,22 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
>>>  {
>>>  	struct inode *inode;
>>>  	struct task_struct *task;
>>> +	int rv = 0;
>>>  
>>> -	if (flags & LOOKUP_RCU)
>>> -		return -ECHILD;
>>> -
>>> -	inode = d_inode(dentry);
>>> -	task = get_proc_task(inode);
>>> -
>>> -	if (task) {
>>> -		pid_update_inode(task, inode);
>>> -		put_task_struct(task);
>>> -		return 1;
>>> +	if (flags & LOOKUP_RCU) {
>>
>> Why do we need to test flags here at all?
>> Why can't the code simply take an rcu_read_lock unconditionally and just
>> pass flags into do_pid_update_inode?
>>
>
> I don't have any good reason. If it is safe to update the inode without
> holding a reference to the task struct (or holding any other lock) then
> I can consolidate the whole conditional.


I am not certain if there is anything that makes it safe to change uid
and gid on the inode during lookup.  The current code might be buggy in
that respect.

However it is absoltely safe to read from the task_struct with just the
rcu_read_lock.  Which means it is only do_pid_update_inode that needs
locking to update the inode.

>>> +		inode = d_inode_rcu(dentry);
>>> +		task = pid_task(proc_pid(inode), PIDTYPE_PID);
>>> +		if (task)
>>> +			rv = do_pid_update_inode(task, inode, flags);
>>> +	} else {
>>> +		inode = d_inode(dentry);
>>> +		task = get_proc_task(inode);
>>> +		if (task) {
>>> +			rv = do_pid_update_inode(task, inode, flags);
>>> +			put_task_struct(task);
>>> +		}
>>
>>>  	}
>>> -	return 0;
>>> +	return rv;
>>>  }
>>>  
>>>  static inline bool proc_inode_is_dead(struct inode *inode)
>>
>> Eric

Eric
