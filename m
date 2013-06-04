Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r542r0Ka025397
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2013 22:53:00 -0400
Message-ID: <51AD5689.6080706@schaufler-ca.com>
Date: Mon, 03 Jun 2013 19:52:57 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH 2/2] SELinux: cache inode checks inside struct inode
References: <1370285941-18367-1-git-send-email-eparis@redhat.com>  <1370285941-18367-2-git-send-email-eparis@redhat.com>  <alpine.LFD.2.03.1306040628420.25797@pixel.linux-foundation.org> <1370301501.19018.9.camel@localhost>
In-Reply-To: <1370301501.19018.9.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 6/3/2013 4:18 PM, Eric Paris wrote:
> On Tue, 2013-06-04 at 06:31 +0900, Linus Torvalds wrote:
>>
>> On Mon, 3 Jun 2013, Eric Paris wrote:
>>>  
>>>  #ifdef CONFIG_SECURITY
>>> +     seqcount_t              i_security_seqcount;
>>> +     u32                     i_last_task_sid;
>>> +     u32                     i_last_granting;
>>> +     u32                     i_last_perms;
>>> +     u32                     i_audit_allow;
>>>       void                    *i_security;
>>>  #endif
>> This is much too big. I was really hoping for "another word that the 
>> security layer can use" or similar.
> Not sure how that can work   :-(
>
>> Something this big would be acceptable if it would be a *generic* security 
>> cache, and others could use it too, and would avoid ever actually calling 
>> into any security layer at all (ie we could do the checks entirely at the 
>> VFS layer). Then it would be fine. But for just the fact that SELinux is 
>> too slow? No.
> There is nothing about it that can't be VFS-erized.  The fields are:
>
> readlockless way to get the data
> which task was allowed
> which perms were allowed
> what generation of security policy allowed it
> what perms should be forced to call security hook anyway

You've defined all of these things as u32 (that is, secids).
Secids are an SELinux artifact and do not belong in general
purpose interfaces.

> defining "perms" from a VFS PoV is hard.

Yes, it is. But I think that for this to work we can't
be looking at the perms, we have to be looking at a previous
determination that can be used to accurately predict what the
outcome would be if we did look at the perms. If, for example,
we saved the pid (in a reuse safe way) of the last process to
successfully access the inode you wouldn't need to look at any
perms (unless the configuration changed) for that pid again.

Yeah, yeah, I know that is an oversimplification that would
likely gain precious little advantage.I seriously doubt it would
be worth doing.

> doing any of this with 'stacking' is hard.  Then again, I'm only so so
> on the value of stacking.  I've waffled a few times...

That's another reason why cashing certain attributes isn't a good idea,
but that caching a result might have value.

> I can do it entirely inside selinux, but we are still going to have the
> cache hit you were originally seeing as we dereference isec to get the
> info....
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
