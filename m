To: Tom Cherry <tomcherry@google.com>
CC: <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
References: <20180813194214.20929-1-hollis_blanchard@mentor.com>
 <CAPc65ax7Dz_niNOxypfds2hLCdiP=x8C2_KFWShVpBnWP62fFg@mail.gmail.com>
From: Hollis Blanchard <hollis_blanchard@mentor.com>
Message-ID: <6a93e71c-a31a-d7e2-546c-e0e63d85c62d@mentor.com>
Date: Mon, 13 Aug 2018 13:49:10 -0700
MIME-Version: 1.0
In-Reply-To: <CAPc65ax7Dz_niNOxypfds2hLCdiP=x8C2_KFWShVpBnWP62fFg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Subject: Re: [PATCH] Fix build break around __atomic_*() with GCC<4.7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/13/2018 01:45 PM, Tom Cherry wrote:
> On Mon, Aug 13, 2018 at 12:43 PM Hollis Blanchard
> <hollis_blanchard@mentor.com> wrote:
>> The __atomic_* GCC primitives were introduced in GCC 4.7, but Red Hat
>> Enterprise Linux 6.x (for example) provides GCC 4.4. Tweak the current code to
>> use the (most conservative) __sync_synchronize() primitive provided by those
>> older GCC versions.
>>
>> Fixes https://github.com/SELinuxProject/selinux/issues/97
>>
>> (Really, no __atomic or __sync operations are needed here at all, since POSIX
>> 4.12 "Memory Synchronization" says pthread_mutex_lock() and
>> pthread_mutex_unlock() "synchronize memory with respect to other threads"...)
> That section means that pthread_mutex_lock() and
> pthread_mutex_unlock() will perform an acquire / release operation
> respectively, so if you're guarding shared data with them, you don't
> need additional memory synchronization.
>
> In this case however, the fast path does not call pthread_mutex_lock()
> and thus there is no acquire operation.  pthread_mutex_unlock() will
> perform a release operation in the thread that actually compiled the
> regex (so technically, we don't actually need the __atomic_store_n),
> but we still need an acquire operation on the fast path, which is why
> we need the atomic.
You really don't. The fast path access will race whether it's "atomic" 
or not. Luckily, it doesn't matter if you get false positives or false 
negatives, because it will be checked for real under the mutex.

Hollis Blanchard
Mentor Graphics Emulation Division
