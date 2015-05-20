Message-ID: <555CB552.5040305@tycho.nsa.gov>
Date: Wed, 20 May 2015 12:24:50 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, Dominick Grift <dac.override@gmail.com>
Subject: Re: [PATCH] selinux: enable per-file labeling for debugfs files.
References: <1432064766-30354-1-git-send-email-sds@tycho.nsa.gov>
 <20150520155135.GA30612@x131e> <555CAF66.7070004@tycho.nsa.gov>
 <20150520160422.GB30612@x131e> <555CB29E.30904@tycho.nsa.gov>
 <20150520162023.GC30612@x131e>
In-Reply-To: <20150520162023.GC30612@x131e>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/20/2015 12:20 PM, Dominick Grift wrote:
> On Wed, May 20, 2015 at 12:13:18PM -0400, Stephen Smalley wrote:
>> On 05/20/2015 12:04 PM, Dominick Grift wrote:
>>> On Wed, May 20, 2015 at 11:59:34AM -0400, Stephen Smalley wrote:
>>>> On 05/20/2015 11:51 AM, Dominick Grift wrote:
>>>>> On Tue, May 19, 2015 at 03:46:06PM -0400, Stephen Smalley wrote:
> 
>>>> The original motivating use case for per-file labeling for sysfs was
>>>> libvirt labeling of specific sysfs nodes to make them accessible to
>>>> specific virtual machines (qemu instances).  In that scenario, we needed
>>>> userspace to be able to drive the labeling based on more than just the
>>>> pathname and so genfs_contexts wasn't suitable.
> 
> I do not think that is applicable anymore (although i may be wrong)

Not sure what you mean, but to clarify, I mean that libvirt has to set
the context (at least the categories for MCS and possibly the type as
well) on any sysfs node that needs to be accessible by the qemu
instance.  At least that used to be the case.

>>
>> The Android init program does a restorecon_recursive("/sys") on boot,
>> and specific optimizations have been introduced to prune the tree walk
>> when there are no relevant file_contexts entries.
>>
>> We could certainly add full genfs_context support for sysfs, even if we
>> do not switch to using it in Android.  Some of the current /sys
>> file_contexts entries for Android however can't be represented in
>> genfs_contexts, e.g.:
>> /sys/devices/virtual/smdpkt/smdcntl([0-9])+/open_timeout
>> u:object_r:sysfs_smdcntl_open_timeout:s0
>>
>> Also, genfs_contexts is always a prefix match, so e.g.
>> /sys/foo system_u:object_r:foo_t:s0
>> will match /sys/foo, /sys/foobar, and /sys/foo/bar.
>>
>> In contrast, file_contexts is an anchored match, so e.g.
>> /sys/foo system_u:object_r:foo_t:s0
>> will only match /sys/foo,
>> /sys/foo(/.*)? system_u:object_r:foo_t:s0
>> will match /sys/foo and anything under it if it is a directory, and
>> /sys/foo.* will match anything beginning with /sys/foo.
>>
>> So they aren't quite the same.
>>
> 
> That sounds troublesome. Then again, just because one implements genfscon support that does not mean that labeling based on file_contexts can't be used for stuff that cannot be tackled with genfscon. Right?

True.  genfscon would be applied when the dentry is first instantiated,
and then if userspace comes along and changes it via
restorecon/setxattr, then that value will be used (assuming the
relabeling is allowed).
