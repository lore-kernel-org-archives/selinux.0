Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1GJdsct001840
 for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2018 14:39:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 3zjk4F2Pwwz3FHl3
 for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2018 19:39:41 +0000 (UTC)
Received: from UPDC3CPA11_EEMSG_MP27.eemsg.mil (unknown [192.168.18.22])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 3zjk4F1VWyz3FHl7
 for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2018 19:39:41 +0000 (UTC)
Received: by mail-lf0-f47.google.com with SMTP id a204so5513920lfa.2
 for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2018 11:39:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1a47f052-5def-7b50-5fbf-c57cd5293bc3@schaufler-ca.com>
References: <20180216171950.4344-1-sds@tycho.nsa.gov>
 <35c7d386-f856-0b4c-0e17-e959e79f0b05@schaufler-ca.com>
 <CAHC9VhTqeALBB16XUwsGnTBgj1LGjtuNyGxVwABsixg4Qjj+BQ@mail.gmail.com>
 <1a47f052-5def-7b50-5fbf-c57cd5293bc3@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 16 Feb 2018 14:39:39 -0500
Message-ID: <CAHC9VhQE6Su+J9rzkA4rXqRcF5LK1EJpOThvcmQjusi3DiMGgg@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 peter.enderborg@sony.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: wrap global selinux state
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Feb 16, 2018 at 1:52 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/16/2018 10:40 AM, Paul Moore wrote:
>> On Fri, Feb 16, 2018 at 12:44 PM, Casey Schaufler
>> <casey@schaufler-ca.com> wrote:
>>> On 2/16/2018 9:19 AM, Stephen Smalley wrote:
>>>> Define a selinux state structure (struct selinux_state) for
>>>> global SELinux state and pass it explicitly to all security server
>>>> functions.
>>> If you're already changing the security server APIs
>>> wholesale it would be delightful if you could change the
>>> prefix used from "security_" to something that doesn't
>>> clash with the LSM infrastructure. It might seem cosmetic
>>> if you're working inside SELinux, but over the past few
>>> years while I've been working on the LSM stacking the
>>> clash has driven me batty on multiple occasions. I have
>>> discussed this with Paul in the past, and he wasn't eager
>>> to take patches that were just name changes. I certainly
>>> see that position. But, since you're changing the APIs
>>> anyway, there won't be a better time to do this. I'm
>>> batty enough as it is.
>>
>> Yes, there is a better time to change this, and it's the same time as
>> when we last talked about it.  We can look at changing the functions
>> when we tackle the bigger issue of (re)examining the boundary between
>> the SELinux LSM hooks and the SELinux security server.
>
> I'm not convinced.

Okay, that's your right.  Just know that I've heard your opinion and I
disagree with your evaluation.  As you surely know by now, this job
requires some subjective judgement calls from time to time, which is
what I'm doing here.  Counter opinions are always welcome, but please
recognize when I've made up my mind.

I try not to shout too loudly about all the things I believe you are
doing wrong with Smack, I would appreciate the same consideration.

> Recent discussions on this list indicate that
> isn't going to happen, that the existing boundary is here to stay.
> It also may not result in changing *all* the interfaces, like this
> one does. It seems convenient to do it now. Thought I'd ask.

You did ask, which is fine.  I said "no", and you told me I was wrong,
which is also okay, but it's time to move on.

>From my perspective the rename would only serve to muddy a fairly
large change, and I wont accept it right now.  Despite what you may
have taken from my conversation with Stephen, I remain convinced that
(re)evaluating the SELinux hooks/ss boundary is a worthwhile exercise;
it will not likely result in a total merge, but I believe there is
still the potential for a significant change, and that will be the
Right Time.

-- 
paul moore
www.paul-moore.com
