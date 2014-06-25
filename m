Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5PJnql6006652
 for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2014 15:49:52 -0400
Received: by mail-qa0-f49.google.com with SMTP id w8so1937708qac.36
 for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2014 12:49:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <58493927.vocElXfMed@sifl>
References: <CAEFn6A4mzF208e1s_OHEzJ-1Kq-DUGgzVNbQXrW6NbB0e8DSpQ@mail.gmail.com>
 <CAB9W1A3HhfPimsRB4Qtf91hCM8u2Ds+yzK9XBYr6eEcdDP+wWQ@mail.gmail.com>
 <58493927.vocElXfMed@sifl>
Date: Wed, 25 Jun 2014 15:49:55 -0400
Message-ID: <CAB9W1A2VnkCh3ru7ZKST0e55DnpMxPEbzDdczwDY7o0tsZdjnw@mail.gmail.com>
Subject: Re: Fwd: Booting time is increased after applying kernel 3.10
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Cc: Jaejyn Shin <flagon22bass@gmail.com>, selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I suspect it won't matter in practice, but the reason for it is that
permissions or other state may have been cached during bootup prior to
initial policy load that may no longer be valid.

On Wed, Jun 25, 2014 at 3:29 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wednesday, June 25, 2014 03:14:56 PM Stephen Smalley wrote:
>> ---------- Forwarded message ----------
>> From: Jaejyn Shin <flagon22bass@gmail.com>
>> Date: Wed, Jun 25, 2014 at 4:36 AM
>> Subject: Booting time is increased after applying kernel 3.10
>> To: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
>>
>>
>>
>> Dear SEAndroid and SELinux developer
>> First of all, I always appreciate that I get lots of information in
>> this e-mailing list.
>>
>> After applying kernel 3.10, the booting time of my device has been increased
>> Especially, the selinux initializing time is increased (about 0.5s).
>>
>> I analized the reason, and I found that the synchronize_net function
>> has 0.1s delay.
>
> I would need to give it some more thought, but since the netport/netnode/netif
> caches all have their own locks it may be possible to skip the
> synchronize_net() call.  Although, looking at this a bit closer, I wonder if
> it would be possible to just skip the avc_ss_reset() call for the initial
> policy load, or at least skip the callback processing.  Am I missing
> something?
>
>> before)
>> selinux_initialize
>>     -> selinux_android_load_policy
>>    -> selinux_android_reload_policy
>>    -> security_load_policy
>>    -> avc_ss_reset
>>    -> sel_netport_avc_callback -> synchronize_net
>> -> sel_netnode_avc_callback -> synchronize_net
>> -> sel_netif_avc_callback -> synchronize_net
>>     -> security_setenforce
>>    -> sel_write_enforce
>>    -> avc_ss_reset
>> -> sel_netport_avc_callback -> synchronize_net
>>    -> sel_netnode_avc_callback -> synchronize_net
>> -> sel_netif_avc_callback -> synchronize_net
>> To make fast the booting time, can I don't call the avc_ss_reset
>> function only during initializing selinux ?
>>
>> after)
>> selinux_initialize
>>     -> selinux_android_load_policy
>>    -> selinux_android_reload_policy
>>    -> security_load_policy
>>    X-> avc_ss_reset
>>     -> security_setenforce
>>    -> sel_write_enforce
>>    X-> avc_ss_reset
>>
>> Is it possible?
>>
>> Thank you
>> Best regards
>>
>> _______________________________________________
>> Seandroid-list mailing list
>> Seandroid-list@tycho.nsa.gov
>> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Seandroid-list-request@tycho.nsa.gov.
>
> --
> paul moore
> www.paul-moore.com
>
