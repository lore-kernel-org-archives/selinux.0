Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBFKwebx031773
 for <selinux@tycho.nsa.gov>; Tue, 15 Dec 2015 15:58:45 -0500
Received: by mail-pa0-f43.google.com with SMTP id wq6so11018498pac.1
 for <selinux@tycho.nsa.gov>; Tue, 15 Dec 2015 12:58:36 -0800 (PST)
Subject: Re: Exposing secid to secctx mapping to user-space
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "Roberts, William C" <william.c.roberts@intel.com>,
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>
References: <566B17FB.6010405@android.com>
 <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
 <566B4ACE.3040301@tycho.nsa.gov> <1834864.RYHtAVZZNX@sifl>
 <566F016B.90002@schaufler-ca.com>
 <476DC76E7D1DF2438D32BFADF679FC56011AD188@ORSMSX103.amr.corp.intel.com>
 <566F3E8D.3060604@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC56011AD1EC@ORSMSX103.amr.corp.intel.com>
 <56702B25.9010205@tycho.nsa.gov>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>, "serge@hallyn.com" <serge@hallyn.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "jeffv@google.com"
 <jeffv@google.com>,
 "nnk@google.com" <nnk@google.com>, "arve@google.com" <arve@google.com>
From: Daniel Cashman <dcashman@android.com>
Message-ID: <56707EF9.4070709@android.com>
Date: Tue, 15 Dec 2015 12:58:33 -0800
MIME-Version: 1.0
In-Reply-To: <56702B25.9010205@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/15/2015 07:00 AM, Stephen Smalley wrote:
> On 12/14/2015 05:57 PM, Roberts, William C wrote:
>> <snip>
>>>>
>>>> If I understand correctly, the goal here is to avoid the lookup from
>>>> pid to context. If we somehow Had the context or a token to a context
>>>> during the ipc transaction to userspace, we could just use that In
>>>> computing the access decision. If that is correct, then since we have
>>>> PID, why not just extend the SE Linux compute av decision interface
>>>> to support
>>> passing of PID and then it can do the lookup in the Kernel?
>>>
>>> That's no less racy than getpidcon().
>>>
>>
>> I got a bounce from when I sent this from gmail, resending.
>>
>> True, but in this case the binder transaction would be dead...
>>
>> Why not just pass ctx? It's less than ideal, but it might be good
>> enough for now until contexts get unwieldy big.
>>
>> grep -rn '^type ' * | grep domain | cut -d' ' -f 2-2 | sed s/','//g |
>> awk ' {  thislen=length($0); printf("%-5s %dn", NR, thislen);
>> totlen+=thislen}
>> END { printf("average: %dn", totlen/NR); } '
>>
>> The avg type length for domain types in external/sepolicy is 7. Add
>> the full ctx:
>>
>> u:r:xxxxxxx:s0(cat)
>>
>> 1. We're looking at like 18 or so bytes, how do we know this won't be
>> "fast enough"?
>> 2. What's the current perf numbers, and what's agreed upon on what you
>> need to hit to be fast enough?
>> 3. I'm assuming the use case is in service manager, but would a
>> userspace cache of AVD's help? Then you can (possibly) avoid both
>> kernel trips, and you can invalidate the cache on policy reload and on
>> PID deaths? In the case of service manager would it always be a miss
>> based on usage pattern? I'm assuming things would say hey resolve this
>> once, and be done. However, you could only do the ctx lookup and do
>> the avd based on the policy in user space, thus avoiding 1 of two trips.
> 
> 1. I don't think it is the size of the context that is the concern but
> rather the fact that it is a variable-length string, whereas current
> binder commands use fixed-size arguments and encode the size in the
> command value (common for ioctls).  Supporting passing a variable-length
> string would be a change to the protocol and would complicate the code.
>  On the performance side, it means generating a context string from the
> secid and then copying it to userspace on each IPC (versus just getting
> the secid and putting that in the existing binder_transaction_data that
> is already copied to userspace).

This is precisely the motivation for the original enquiry. Issue has
been brought up about changing the protocol, and concern has also been
strongly expressed about the overhead introduced by the string
operations, although this has not been measured.  User-space would still
need to do something intelligent with the secid, which would involve its
own lookup and caching, but the idea is that this wouldn't be done with
the binder lock held.

> 2. Don't know; deferring to Daniel to run whatever binder IPC benchmarks
> might exist with and without the current patch that copies the context
> string.

Yes, this needs to be done.  This issue was brought up as part of
discussion regarding a proposed change to the binder driver to add the
context string to each transaction.  An outcome of that discussion was,
"before we go too far into this, let's see the reaction upstream to
exposing the secid."  Based on the reaction here (upstream), I think
it's my responsibility to push forward the string-based change and get
the appropriate perf numbers so that a meaningful comparison can be made.

> 3. It is for any binder-based service that wants to apply SELinux access
> checks, which presently includes servicemanager and keystore.
> We already have a userspace AVC (in libselinux) that gets used
> automatically when you use selinux_check_access(), but you still need to
> get the sender security context in some manner.
> 

The issue this hopes to address is passing the secctx along with a
binder transaction so that userspace can use it for any access
appropriate access controls.  Specifically, at the moment, I'm hoping to
use the receiving process's concept of which service is being invoked
and what the transaction code represents (neither of which the binder
driver itself has any concept) to create an SELinux object manager that
filters service method calls.  This could be seen as a more general
implementation of the keystore service object manager.

The getpidcon() and  SO_PEERSEC type solutions are, as Stephen pointed
out, racy such that a process could have changed its context in the
interim, but also such that they do not address one-way binder
transactions, in which a process could fire of a request and die before
it gets processed.  This isn't an issue for the servicemanager's current
object manager, but could be an issue for other services.

Thank You,
Dan
