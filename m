Message-ID: <54B52363.9070309@tycho.nsa.gov>
Date: Tue, 13 Jan 2015 08:53:39 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: John Brooks <john.brooks@jolla.com>
Subject: Re: [PATCH 2/3] Use a better hash function for libsepol's avtab
References: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
 <1420668221-52637-3-git-send-email-john.brooks@jolla.com>
 <54B404CC.90908@tycho.nsa.gov>
 <336D0B16-7046-4AA3-B002-B13877CBF3BC@jolla.com>
In-Reply-To: <336D0B16-7046-4AA3-B002-B13877CBF3BC@jolla.com>
Content-Type: text/plain; charset=windows-1252
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/12/2015 08:38 PM, John Brooks wrote:
> On Jan 12, 2015, at 10:30 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 01/07/2015 05:03 PM, John Brooks wrote:
>>> This function, based on murmurhash3, has much better distribution than
>>> the original. Using the current default of 4096 buckets, there are many
>>> fewer collisions:
>>
>> Thanks, this looks like a significant improvement for neverallow
>> checking.  I'm trying to make sure I understand what if any implications
>> it has for other uses of the avtab, since the neverallow checker is
>> unusual in that it fully expands all entries.
>>
>> On Fedora 20 policy, checkpolicy -Mb
>> /etc/selinux/targeted/policy/policy.29 before and after this patch (with
>> avtabh_hash_eval called) shows:
>>
>> before.txt:rules:  101401 entries and 8169/8192 buckets used, longest
>> chain length 84
>> betterhash.txt:rules:  101401 entries and 8192/8192 buckets used,
>> longest chain length 27
>>
>> So that's a definite improvement.
>>
>> Could you amend your code to define constants for the various magic
>> values used above?  Thanks.
> 
> The magic values are nothing but magic from the original murmurhash3. They don’t have any useful names. I did remove ‘c1’ and ‘c2’ in favor of using their values inline, since each is only used once. Is that enough?
> 
> (Also, sorry for my last mail to this list; it was butchered by my mail client. Hopefully this one works.)

Not sure what source you are using for murmurhash3, but the algorithm
from http://en.wikipedia.org/wiki/MurmurHash seems to define and use
symbolic names for most of the constants.  They aren't especially
meaningful but they help with readability, especially for the ones that
are used more than once in the algorithm.
