Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBFHaoZn016039
 for <selinux@tycho.nsa.gov>; Tue, 15 Dec 2015 12:36:51 -0500
Subject: Re: Exposing secid to secctx mapping to user-space
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "Roberts, William C" <william.c.roberts@intel.com>,
 Paul Moore <paul@paul-moore.com>
References: <566B17FB.6010405@android.com>
 <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
 <566B4ACE.3040301@tycho.nsa.gov> <1834864.RYHtAVZZNX@sifl>
 <566F016B.90002@schaufler-ca.com>
 <476DC76E7D1DF2438D32BFADF679FC56011AD188@ORSMSX103.amr.corp.intel.com>
 <566F3E8D.3060604@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC56011AD1EC@ORSMSX103.amr.corp.intel.com>
 <56702B25.9010205@tycho.nsa.gov> <56703A9E.7000507@schaufler-ca.com>
 <567045EA.9090508@tycho.nsa.gov>
Cc: Daniel Cashman <dcashman@android.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>, "serge@hallyn.com" <serge@hallyn.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "jeffv@google.com"
 <jeffv@google.com>,
 "nnk@google.com" <nnk@google.com>, "arve@google.com" <arve@google.com>,
 Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <56704FAA.6080208@schaufler-ca.com>
Date: Tue, 15 Dec 2015 09:36:42 -0800
MIME-Version: 1.0
In-Reply-To: <567045EA.9090508@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/15/2015 8:55 AM, Stephen Smalley wrote:
> On 12/15/2015 11:06 AM, Casey Schaufler wrote:
>> On 12/15/2015 7:00 AM, Stephen Smalley wrote:
>>> On 12/14/2015 05:57 PM, Roberts, William C wrote:
>>>> <snip>
>>>>>>
>>>>>> If I understand correctly, the goal here is to avoid the lookup from
>>>>>> pid to context. If we somehow Had the context or a token to a context
>>>>>> during the ipc transaction to userspace, we could just use that In
>>>>>> computing the access decision. If that is correct, then since we have
>>>>>> PID, why not just extend the SE Linux compute av decision interface to support
>>>>> passing of PID and then it can do the lookup in the Kernel?
>>>>>
>>>>> That's no less racy than getpidcon().
>>>>>
>>>>
>>>> I got a bounce from when I sent this from gmail, resending.
>>>>
>>>> True, but in this case the binder transaction would be dead...
>>>>
>>>> Why not just pass ctx? It's less than ideal, but it might be good enough for now until contexts get unwieldy big.
>>>>
>>>> grep -rn '^type ' * | grep domain | cut -d' ' -f 2-2 | sed s/','//g | awk ' {  thislen=length($0); printf("%-5s %dn", NR, thislen); totlen+=thislen}
>>>> END { printf("average: %dn", totlen/NR); } '
>>>>
>>>> The avg type length for domain types in external/sepolicy is 7. Add the full ctx:
>>>>
>>>> u:r:xxxxxxx:s0(cat)
>>>>
>>>> 1. We're looking at like 18 or so bytes, how do we know this won't be "fast enough"?
>>>> 2. What's the current perf numbers, and what's agreed upon on what you need to hit to be fast enough?
>>>> 3. I'm assuming the use case is in service manager, but would a userspace cache of AVD's help? Then you can (possibly) avoid both kernel trips, and you can invalidate the cache on policy reload and on PID deaths? In the case of service manager would it always be a miss based on usage pattern? I'm assuming things would say hey resolve this once, and be done. However, you could only do the ctx lookup and do the avd based on the policy in user space, thus avoiding 1 of two trips.
>>>
>>> 1. I don't think it is the size of the context that is the concern but rather the fact that it is a variable-length string, whereas current binder commands use fixed-size arguments and encode the size in the command value (common for ioctls).  Supporting passing a variable-length string would be a change to the protocol and would complicate the code.  On the performance side, it means generating a context string from the secid and then copying it to userspace on each IPC (versus just getting the secid and putting that in the existing binder_transaction_data that is already copied to userspace).
>>
>> I have long wondered why SELinux generates the context string
>> of the secid more than once. Audit performance alone would
>> justify keeping it around. The variable length issue isn't
>> so difficult as you make it out. As William pointed out earlier,
>> most SELinux contexts are short. Two protocols, one with a
>> fixed length of 16 chars (typical is 7) and one with a fixed
>> length of 256 (for abnormal contexts) solve the problem without
>> complicating the code hardly at all.
>>
>> If it's such a problem, why do we have SO_PEERSEC return a
>> variable length string? That's been around forever and seems
>> to work just fine.
>
> Generating an audit record means you are already on the slow path, so adding the cost of generating a context at that point shouldn't be significant (but if one has performance data to the contrary, that would always be of interest). Keeping complete context strings in kernel memory at all times wasn't viewed as desirable, particularly when you consider the next point.

Making a slow path slower doesn't seem like a great idea to me.
The performance of audit is a major impediment to its use. There
are some cases where I can see regenerating the context on demand
as an optimization, but never in a case where the system regularly
exports them.

>
> There is no internal limit on SELinux context size and one can in fact generate a SELinux context string that exceeds 256 bytes (just create a category set with many different, non-contiguous categories, e.g. a category set with every other category), so you can't just pick a couple of sizes (16 and 256 in your example) and be done with it.  It may be unusual to exceed 256 but it isn't impossible, and users of MLS systems have in fact run up against even the page size limitations of the /proc/self/attr interfaces as a pain point.

My secalias suggestion could help here. :)

You're right. You'd still need an arbitrary size string protocol.
But I expect that binder using (i.e. Android) systems aren't going
wild with multiple category MLS (or MCS). Use of that protocol would
be sufficiently rare that finding non-artificial test cases would be
a challenge.

>
> getsockopt SO_PEERSEC, as I mentioned earlier, is for stream sockets, so you are dealing with a connection-oriented model (with its attendant baseline overhead), server applications opt into getting the security label after the connection is established via getsockopt (which means that the overhead is not imposed on all connections, and which provides a straightforward way of passing variable-length data already), and all of the payload data is typically being copied through the kernel (to and from socket buffers).  With binder, we are talking about a synchronous IPC mechanism where the kernel copies the sender information (currently PID and UID) to the receiver on every IPC, the protocol currently passes no variable-length data, and the data is copied directly from the sender's memory into kernel-managed buffers that are mapped read-only into the receiver.  So introducing variable-length string copy to binder is a more substantial change, and the baseline performance
> characteristics and thus the relative overhead could differ.

True, but I think that it's quite reasonable to optimize the common case
using a fixed16 + fixed256 + variable set of protocols. The common context
fits in 16 (make it 32 if you like), the odd case fits in 256, and the
extreme case, which probably never occurs on a binder based system, takes
the variable length hit.

>
> In any event, I think we can wait for some performance data to show whether this is a real concern or not.

I agree. I also think that it would be a grand idea to look into
keeping the secctx around rather than regenerating it as needed.
I can't help but think it would be a performance win, especially
with audit involved.
