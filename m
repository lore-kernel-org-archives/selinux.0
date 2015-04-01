Message-ID: <551C45DE.8050706@tycho.nsa.gov>
Date: Wed, 01 Apr 2015 15:24:14 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Ravi Kumar <nxp.ravi@gmail.com>, Selinux@tycho.nsa.gov
Subject: Re: Fwd: Booting time is increased after applying kernel 3.10
References: <CACikiw1GMK=8TNiwna22J_TC-S9PBVPvTzpNLCxte5nwEjDzoQ@mail.gmail.com>
 <551C44E1.8090105@tycho.nsa.gov>
In-Reply-To: <551C44E1.8090105@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/01/2015 03:20 PM, Stephen Smalley wrote:
> On 04/01/2015 02:58 PM, Ravi Kumar wrote:
>> Hi Team , 
>> In reference to old discussion via the mail thread , 
>> http://marc.info/?l=selinux&m=140387478632108&q=raw
>>
>> This is on the context on removing the synchronize_net() from bootup and
>> was concluded with optimization  on reducing the the number of call to
>> synchronize_net()  In context to to this what we are seeing is skipping
>> the call is saving much time  on android bootup  and based on the
>> discussion  at least for android  systems it look like we can still
>>  skip this call as suggest in the initial patch  which is much saving on
>> the bootup time .  But still i dont see any mainline / signed off sort
>> of patch for andriod  or any one using this . Did we see any issue or
>> planned different .
>>
>> At least on KK the bootup time was under control for L code base we are
>> trying to see  all the ways of optimization  any input are greatly
>>  appreciated.       
> 
> commit 615e51fdda6f274e94b1e905fcaf6111e0d9aa20
> Author: Paul Moore <pmoore@redhat.com>
> Date:   Thu Jun 26 14:33:56 2014 -0400
> 
>     selinux: reduce the number of calls to synchronize_net() when
> flushing cache
> 
>     When flushing the AVC, such as during a policy load, the various
>     network caches are also flushed, with each making a call to
>     synchronize_net() which has shown to be expensive in some cases.
>     This patch consolidates the network cache flushes into a single AVC
>     callback which only calls synchronize_net() once for each AVC cache
>     flush.
> 
>     Reported-by: Jaejyn Shin <flagon22bass@gmail.com>
>     Signed-off-by: Paul Moore <pmoore@redhat.com>

And this was uploaded to the Android kernel/common tree along with
various other SELinux kernel fixes/improvements, see
https://android-review.googlesource.com/#/q/owner:sds+project:kernel/common
