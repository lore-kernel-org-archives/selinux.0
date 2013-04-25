Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3PKLmYl029330
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2013 16:21:48 -0400
Message-ID: <5179905E.4090207@schaufler-ca.com>
Date: Thu, 25 Apr 2013 13:21:50 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
CC: John Johansen <john.johansen@canonical.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v13 0/9] LSM: Multiple concurrent LSMs
References: <5176ABB7.5080300@schaufler-ca.com> <47138397.PP25Tg7m1s@sifl> <51797153.7050308@schaufler-ca.com> <5010864.rEs2oKk1kF@sifl>
In-Reply-To: <5010864.rEs2oKk1kF@sifl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/25/2013 12:14 PM, Paul Moore wrote:
> On Thursday, April 25, 2013 11:09:23 AM Casey Schaufler wrote:
>> On 4/25/2013 8:01 AM, Paul Moore wrote:
>>> On Wednesday, April 24, 2013 05:43:08 PM Casey Schaufler wrote:
>>>> On 4/24/2013 4:00 PM, John Johansen wrote:
>>>>> On 04/24/2013 02:15 PM, Paul Moore wrote:
>>>>>> On Wednesday, April 24, 2013 01:22:20 PM Casey Schaufler wrote:
>>> ...
>>>
>>>>>>> An interesting aside that may be relevant is that the error
>>>>>>> condition behavior makes it advisable to have the LSM you care
>>>>>>> about most go last. If the networking components were strictly
>>>>>>> FCFS you might have to chose an ordering you might not want for
>>>>>>> other reasons.
>>>>>> Well, maybe not ... I think.  If we take a FCFS approach to the network
>>>>>> controls then only one LSM is really ever going to throw an error on
>>>>>> the
>>>>>> network hooks, yes?
>>>> You set up the order you want to get the networking handled
>>>> correctly and you could get filesystem hooks in the wrong order.
>>>> Not that that really ought to be a problem, but there are wonky
>>>> admin tools out there.
>>> I don't quite follow; can you be a bit more explicit about getting the
>>> filesystem hooks in the wrong order?
>> Let's assume that there's a case for the stat() system call that
>> would get EPERM from SELinux and EACCES from Smack. A carefully
>> crafted admin tool might take different actions based on the return
>> code. If Smack ahead of SELinux in the list the tool will respond
>> one way, whereas if SELinux is ahead it will behave the other way.
>>
>> If this tool came with Fedora it will likely expect the SELinux
>> error code. Thus, it will be somewhat important that Smack precede
>> SELinux in the LSM ordering. That will grant Smack the NetLabel
>> component. If you want SELinux to use NetLabel you'll have to
>> explicitly configure that.
>>
>> It's probably not going to be an issue that often. Making the
>> ordering implications clear to those who may be affected by them
>> is probably the best choice and biggest challenge. It would be
>> nice to keep them to a minimum. I fear some future LSM author
>> getting clever with error codes and demanding the ultimate
>> position in all cases.
> I guess this begs the question, why does the stacking take the return value 
> from the last LSM and not the first?  I'm sure there was a design decision 
> made here, I'm just curious about the reasons why.

The hook loop is trivially simpler if you return the last error than
if you return the first error:

	if (thisrc)
		rc = thisrc;

vs

	if (thisrc && !rc)
		rc = thisrc;

If I had decided to do shortcutting (return on first failure) it
would be a different story.

> To me, and maybe I'm the odd one out here,

I don't know that you're the only odd one here. :)

> but I would think that the first 
> LSM in the stacking order should get precedence;

My desire and intent is that to the extent possible there should
be no "principle" LSM. The choice of last error is purely driven
by the fact that it's the easiest thing to do.

> this is why I'm pushing for a 
> FCFS for the network controls.  If it turns out that the stacking patches give 
> preference for the last LSM in the stacking order (I think this will always 
> seem backwards to me) then we should probably give the networking controls to 
> the last LSM.

I actually think that FCFS for networking services and last error code
hits closest to the sweet spot. "security=yama,smack,selinux" would give
NetLabel to Smack and xfrm and secmark to SELinux. It would also give
SELinux error returns in cases where there are multiple reasons for
denial. Since SELinux has a more sophisticated runtime environment than
Smack this is likely to make Fedora (for example) happier.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
