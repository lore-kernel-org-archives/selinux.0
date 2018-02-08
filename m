Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w18LfDd2018976
 for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2018 16:41:13 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 3zcs8727q1z2Slby
 for <selinux@tycho.nsa.gov>; Thu,  8 Feb 2018 21:41:11 +0000 (UTC)
Received: from UPDC3CPA12_EEMSG_MP28.eemsg.mil (unknown [192.168.18.23])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 3zcs8718WZz2Sj45
 for <selinux@tycho.nsa.gov>; Thu,  8 Feb 2018 21:41:11 +0000 (UTC)
Received: by mail-lf0-f41.google.com with SMTP id q194so8426680lfe.13
 for <selinux@tycho.nsa.gov>; Thu, 08 Feb 2018 13:41:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518102162.21656.46.camel@tycho.nsa.gov>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-2-sds@tycho.nsa.gov>
 <CAHC9VhTGF6_zP46tP3JdWna2_7BJ+oD0eKccmAhy3xXdfeRZ_w@mail.gmail.com>
 <1518025709.16883.48.camel@tycho.nsa.gov>
 <CAHC9VhTt1GZeDuhacdMbF9J9q3xndqVO=k4UqQT6v_n_Cq3vrA@mail.gmail.com>
 <1518102162.21656.46.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Feb 2018 16:41:07 -0500
Message-ID: <CAHC9VhQ2fezw2HRzSUUc-=uiuRM+SOObwb7MjnUHFgiAoL_UQA@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [RFC 01/10] selinux: introduce a selinux namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Feb 8, 2018 at 10:02 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2018-02-07 at 14:56 -0500, Paul Moore wrote:
>> On Wed, Feb 7, 2018 at 12:48 PM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:
>> > On Tue, 2018-02-06 at 17:18 -0500, Paul Moore wrote:
>>
>> ...
>>
>> > > While I don't think we need to tackle this as part of the
>> > > encapsulation work, this is another reminder that we should look
>> > > into
>> > > breaking the separation between the security server and the
>> > > Linux/hooks code.  I understand there were historical reasons for
>> > > this
>> > > split, but I think all of those reasons are now gone, and further
>> > > I
>> > > think enough Linux'isms have crept into the security server that
>> > > the
>> > > separation is no longer as meaningful as it may have been in the
>> > > past.
>> >
>> > I think we want to retain some degree of encapsulation of the
>> > policy
>> > logic and data structures, which is what the security server is
>> > supposed to provide.  That allows us to evolve that logic and
>> > structures without impacting the object label management and
>> > permission
>> > enforcement code.  Separation of policy from mechanism.  I don't
>> > mind
>> > nativizing the security server for Linux, and where appropriate,
>> > allowing some optimization of the interfaces between it and the
>> > rest of
>> > the SELinux code, but I wouldn't want to e.g. directly expose the
>> > policydb to the rest of the code.  There has been some leakage of
>> > policy awareness outside the security server in the past but I view
>> > that as a mistake that ought to be corrected over time.
>>
>> I agree that a level of abstraction between the policydb code and the
>> enforcement code is a good thing, but I think there are some
>> boundaries between the hook code and the security server that we
>> could
>> do without.  Once again, not really part of this work, just popped up
>> in my head again while looking at these patches.
>
> I wanted to clarify that point because it motivates keeping selinux_ss
> as a separate struct from selinux_state (previously selinux_ns), and
> not exposing the selinux_ss struct definition outside of the security
> server.  So the selinux_state struct would still be something like:
> struct selinux_state {
>         bool disabled;
> #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
>         bool enforcing;
> #endif
>         bool checkreqprot;
>         bool initialized;
>         bool policycap[__POLICYDB_CAPABILITY_MAX];
>         struct selinux_avc *avc;
>         struct selinux_ss *ss;
> }
>
> (dropping the reference count, work struct, and parent pointers that
> were part of selinux_ns as being specific to the namespace work).

I think keeping the selinux_avc and selinux_ss structs separate is
fine right now, as I mentioned earlier, I really don't want to
entangle the encapsulation work with any potential hooks/ss
consolidation work.

Directly embedding the selinux_avc and selinux_ss structures inside
selinux_state would be nice as we could just do one allocation, but
that isn't worth breaking the abstraction at this point.  Maybe we
will get there at some point, but I think it's important to stay
focused on the task at hand.

> hooks.c would declare struct selinux_state selinux_state;.
> ss/services.c would declare static struct selinux_ss selinux_ss; and
> provide a selinux_ss_init() function (instead of selinux_ss_create)
> that would set the ->ss field to &selinux_ss.  Likewise for avc.c and
> the selinux_avc.  hooks.c:selinux_init() would call
> selinux_ss_init(&selinux_state.ss) and
> selinux_avc_init(&selinux_state.avc) to set those pointers to the
> appropriate structures private to the ss and avc code.  The _create and
> _free functions would go away and none of the structures would be
> dynamically allocated/freed.
>
> This is in contrast to exposing the selinux_ss struct definition
> outside the security server and directly embedding it in the
> selinux_state, since that would require exposing the policydb and
> sidtab structures as well (unless we were to make those opaque pointers
> within the selinux_ss; currently the policydb and sidtab are directly
> embedded within it).  Likewise for the selinux_avc and its embedded
> avc_cache structure.
>
> Trying to make sure we're in agreement on the data structures before I
> rewrite since I don't want to have to rewrite it twice ;)

-- 
paul moore
www.paul-moore.com
