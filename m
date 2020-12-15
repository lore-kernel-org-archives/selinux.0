Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032B3C2BB9A
	for <selinux@archiver.kernel.org>; Tue, 15 Dec 2020 22:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE132255F
	for <selinux@archiver.kernel.org>; Tue, 15 Dec 2020 22:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgLOWG7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Dec 2020 17:06:59 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:38584 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729963AbgLOWGt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Dec 2020 17:06:49 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kpIS5-00Ckp2-HD; Tue, 15 Dec 2020 15:05:49 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kpIS1-00D4V7-P9; Tue, 15 Dec 2020 15:05:48 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
        <20201212205522.GF2443@casper.infradead.org>
        <877dpln5uf.fsf@x220.int.ebiederm.org>
        <20201213162941.GG2443@casper.infradead.org>
        <CAHC9VhSytjTGPhaKFC7Cq1qotps7oyFjU7vN4oLYSxXrruTfAQ@mail.gmail.com>
        <3504e55a-e429-8f51-1b23-b346434086d8@schaufler-ca.com>
Date:   Tue, 15 Dec 2020 16:04:59 -0600
In-Reply-To: <3504e55a-e429-8f51-1b23-b346434086d8@schaufler-ca.com> (Casey
        Schaufler's message of "Tue, 15 Dec 2020 10:09:15 -0800")
Message-ID: <87im92d8tw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kpIS1-00D4V7-P9;;;mid=<87im92d8tw.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Aq2vMuC4l3HHdCmVoQyb1eUSiqdwndDY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 12/13/2020 3:00 PM, Paul Moore wrote:
>> On Sun, Dec 13, 2020 at 11:30 AM Matthew Wilcox <willy@infradead.org> wrote:
>>> On Sun, Dec 13, 2020 at 08:22:32AM -0600, Eric W. Biederman wrote:
>>>> Matthew Wilcox <willy@infradead.org> writes:
>>>>
>>>>> On Thu, Dec 03, 2020 at 04:02:12PM -0800, Stephen Brennan wrote:
>>>>>> -void pid_update_inode(struct task_struct *task, struct inode *inode)
>>>>>> +static int do_pid_update_inode(struct task_struct *task, struct inode *inode,
>>>>>> +                         unsigned int flags)
>>>>> I'm really nitpicking here, but this function only _updates_ the inode
>>>>> if flags says it should.  So I was thinking something like this
>>>>> (compile tested only).
>>>>>
>>>>> I'd really appreocate feedback from someone like Casey or Stephen on
>>>>> what they need for their security modules.
>>>> Just so we don't have security module questions confusing things
>>>> can we please make this a 2 patch series?  With the first
>>>> patch removing security_task_to_inode?
>>>>
>>>> The justification for the removal is that all security_task_to_inode
>>>> appears to care about is the file type bits in inode->i_mode.  Something
>>>> that never changes.  Having this in a separate patch would make that
>>>> logical change easier to verify.
>>> I don't think that's right, which is why I keep asking Stephen & Casey
>>> for their thoughts.
>> The SELinux security_task_to_inode() implementation only cares about
>> inode->i_mode S_IFMT bits from the inode so that we can set the object
>> class correctly.  The inode's SELinux label is taken from the
>> associated task.
>>
>> Casey would need to comment on Smack's needs.
>
> SELinux uses different "class"es on subjects and objects.
> Smack does not differentiate, so knows the label it wants
> the inode to have when smack_task_to_inode() is called,
> and sets it accordingly. Nothing is allocated in the process,
> and the new value is coming from the Smack master label list.
> It isn't going to go away. It appears that this is the point
> of the hook. Am I missing something?

security_task_to_inode (strangely named as this is proc specific) is
currently called both when the inode is initialized in proc and when
pid_revalidate is called and the uid and gid of the proc inode
are updated to match the traced task.

I am suggesting that the call of security_task_to_inode in
pid_revalidate be removed as neither of the two implementations of this
security hook smack nor selinux care of the uid or gid changes.

Removal of the security check will allow proc to be accessed in rcu look
mode.  AKA give proc go faster stripes.

The two implementations are:

static void selinux_task_to_inode(struct task_struct *p,
				  struct inode *inode)
{
	struct inode_security_struct *isec = selinux_inode(inode);
	u32 sid = task_sid(p);

	spin_lock(&isec->lock);
	isec->sclass = inode_mode_to_security_class(inode->i_mode);
	isec->sid = sid;
	isec->initialized = LABEL_INITIALIZED;
	spin_unlock(&isec->lock);
}


static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
{
	struct inode_smack *isp = smack_inode(inode);
	struct smack_known *skp = smk_of_task_struct(p);

	isp->smk_inode = skp;
	isp->smk_flags |= SMK_INODE_INSTANT;
}

I see two questions gating the safe removal of the call of
security_task_to_inode from pid_revalidate.

1) Does any of this code care about uids or gids.
   It appears the answer is no from a quick inspection of the code.

2) Does smack_task_to_inode need to be called after exec?
   - Exec especially suid exec changes the the cred on a task.
   - Execing of a non-leader thread changes the thread_pid of a task
     so that it is the pid of the entire thread group.

   If either of those are significant perhaps we can limit calling
   security_task_to_inode if task->self_exec_id is different.

   I haven't yet take the time to trace through and see if
   task_sid(p) or smk_of_task_struct(p) could change based on
   the security hooks called during exec.  Or how bad the races are if
   such a change can happen.

Does that clarify the question that is being asked?

Eric
