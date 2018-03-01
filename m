Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w21Nqgv3027305
 for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2018 18:52:42 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC09.oob.disa.mil (Postfix) with SMTP id 3zsq4651LCz2NjRV
 for <selinux@tycho.nsa.gov>; Thu,  1 Mar 2018 23:52:38 +0000 (UTC)
Received: from UPDC3CPA10_EEMSG_MP26.eemsg.mil (unknown [192.168.18.21])
 by UPDCF3IC09.oob.disa.mil (Postfix) with ESMTP id 3zsq463z5tz2NjRT
 for <selinux@tycho.nsa.gov>; Thu,  1 Mar 2018 23:52:38 +0000 (UTC)
Received: by mail-lf0-f65.google.com with SMTP id 37so10907717lfs.7
 for <selinux@tycho.nsa.gov>; Thu, 01 Mar 2018 15:52:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQKrp-SLPWT9VSHtQr9V05suL6GddAJ9XAa7WRBfxvLDw@mail.gmail.com>
References: <20180216171950.4344-1-sds@tycho.nsa.gov>
 <CAHC9VhQKrp-SLPWT9VSHtQr9V05suL6GddAJ9XAa7WRBfxvLDw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Mar 2018 18:51:36 -0500
Message-ID: <CAHC9VhSQfkLVm9Qj7rxsfwC3+qoKGj38k=oVchfPZfS8M4V9qg@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, peter.enderborg@sony.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: wrap global selinux state
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Mar 1, 2018 at 6:00 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Feb 16, 2018 at 12:19 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> Define a selinux state structure (struct selinux_state) for
>> global SELinux state and pass it explicitly to all security server
>> functions.  The public portion of the structure contains state
>> that is used throughout the SELinux code, such as the enforcing mode.
>> The structure also contains a pointer to a selinux_ss structure whose
>> definition is private to the security server and contains security
>> server specific state such as the policy database and SID table.
>>
>> This change should have no effect on SELinux behavior or APIs
>> (userspace or LSM).  It merely wraps SELinux state and passes it
>> explicitly as needed.
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>> This is effectively v2 of "selinux: introduce a selinux namespace",
>> but rewritten per the review to only perform the encapsulation of state
>> and rebased onto latest selinux/next, currently v4.16-rc1-based.
>> Changes from v1:
>> - Rename selinux_ns to selinux_state,
>> - Statically allocate selinux_state and selinux_ss,
>> - Drop any namespace-specific fields, code, and references,
>> - Use static inlines rather than macros.
>>
>> I also intend to rework the "selinux: support multiple selinuxfs instances"
>> and "selinux: move the AVC into the selinux namespace" patches similarly
>> and re-base on this one, but want to wait until this one is finalized since
>> every change to this own will require further reworking of the later ones.
>
> Thanks for the respin Stephen, I know that was probably a bit painful
> given the size of the patch; it definitely wasn't fun to review.  For
> the most part I think everything here looks fine (minor nitpick, see
> below), and because of these points:
>
> 1) Everything here is internal to SELinux so we change it without
> breaking userspace or even other parts of the kernel.
>
> 2) Other work is dependent on this patch.
>
> 3) A patch of this size and scopr, I want it in linux-next sooner
> rather than later.
>
> ... I'm going to merge this now, or rather as soon as my test kernel
> finishes building and I can give this a quick sanity check.

Quick sanity tests looked good, it's in selinux/next as of right now.

> As expected, there were some minor merge problems with the SCTP
> patches, but those were trivially fixed.
>
>> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
>> index 02f0412d42f2..c3a1ef10e710 100644
>> --- a/security/selinux/include/security.h
>> +++ b/security/selinux/include/security.h
>
> ...
>
>> +static inline bool is_enforcing(struct selinux_state *state)
>> +static inline void set_enforcing(struct selinux_state *state, bool value)
>
> More nitpickery: I'm not a fan of these names.
>
> I'm going to take partial blame for this as I didn't pay close enough
> attention to the names earlier, I was focused on the #define vs inline
> function nature of the functions.  I realize it's late, and I want to
> get this merged (see above), so I'll put together a separate patch on
> top of this to change the names.

-- 
paul moore
www.paul-moore.com
