Message-ID: <55A414BC.8020602@tycho.nsa.gov>
Date: Mon, 13 Jul 2015 15:42:52 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH v2] libselinux: use /proc/thread-self when available
References: <1436793816-19308-1-git-send-email-sds@tycho.nsa.gov>	
 <1436794440.18955.15.camel@redhat.com> <55A3C3AA.2030103@tycho.nsa.gov>
 <1436815248.18955.22.camel@redhat.com>
In-Reply-To: <1436815248.18955.22.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/13/2015 03:20 PM, Eric Paris wrote:
> On Mon, 2015-07-13 at 09:56 -0400, Stephen Smalley wrote:
>> On 07/13/2015 09:34 AM, Eric Paris wrote:
>>> Looks good to me.
>>>
>>> That issue also brings up problems with glibc pid caching, right? 
>>> Do we
>>> need to rip out my *con cache entirely? I remember there was a
>>> measurable perf win with the cache, but it has proved a PITA 
>>> multiple
>>> times. Keeping the cache and fixing/working around the glibc pid
>>> caching would mean a tradeoff using getpid(2) instead of getpid(3),
>>> even with this patch. Right? Or maybe storing a ctid instead of 
>>> cpid
>>> and using gettid(2)...
>>>
>>> But this patch is LGTM.
>>
>> From the discussion in that issue, it sounded like switching to using
>> /proc/thread-self would avoid the problem without needing to switch 
>> to
>> getpid(2), but I have not tested systemd-nspawn --selinux-context 
>> after
>> the change to confirm this fact.  Certainly it ensures that we always
>> open the right path on Linux 3.17 and later.
>>
>> I would love to rip out the cache, but I didn't think we were free to 
>> do
>> so without first reworking coreutils in some manner to avoid the
>> repeated getfscreatecon()...setfscreatecon() calls made when copying
>> directory trees.
> 
> You might be right, but I'm not so sure. After a direct call to clone
> the cache has both a cpid and tid saved. So the (incorrect) cached tid
> you just fixed. Certainly possible this was the only problem systemd
> was having.
> 
> But the {get,set}procattrcon_raw() functions also have that cached
> cpid. Which is wrong after clone. Which means they will use the cached
> values instead of even getting to openattr()...  So maybe systemd
> hasn't caused anything to get cached and it will work by change, but
> the library is still busted against some users of clone...
> 
> I was going to suggest telling systemd to call free_procattr() after
> they call their own clone. But even that is busted since it uses
> getpid() and libc is going to cache that result.
> 
> Seems like we need to s/getpid(3)/getpid(2)/ in that whole file to make
> it right...

None of the /proc/self/attr attributes change on fork, only on exec.
So why do we need to flush the cache then?
