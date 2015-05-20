Message-ID: <555CC3A6.1030404@tycho.nsa.gov>
Date: Wed, 20 May 2015 13:25:58 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, Dominick Grift <dac.override@gmail.com>
Subject: Re: [PATCH] selinux: enable per-file labeling for debugfs files.
References: <1432064766-30354-1-git-send-email-sds@tycho.nsa.gov>
 <20150520155135.GA30612@x131e> <555CAF66.7070004@tycho.nsa.gov>
 <20150520160422.GB30612@x131e> <555CB29E.30904@tycho.nsa.gov>
 <20150520162023.GC30612@x131e> <555CB552.5040305@tycho.nsa.gov>
 <20150520162817.GD30612@x131e>
In-Reply-To: <20150520162817.GD30612@x131e>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/20/2015 12:28 PM, Dominick Grift wrote:
> On Wed, May 20, 2015 at 12:24:50PM -0400, Stephen Smalley wrote:
>> On 05/20/2015 12:20 PM, Dominick Grift wrote:
>>> On Wed, May 20, 2015 at 12:13:18PM -0400, Stephen Smalley wrote:
>>>> On 05/20/2015 12:04 PM, Dominick Grift wrote:
>>>>> On Wed, May 20, 2015 at 11:59:34AM -0400, Stephen Smalley wrote:
>>>>>> On 05/20/2015 11:51 AM, Dominick Grift wrote:
>>>>>>> On Tue, May 19, 2015 at 03:46:06PM -0400, Stephen Smalley wrote:
>>>
>>>>>> The original motivating use case for per-file labeling for sysfs was
>>>>>> libvirt labeling of specific sysfs nodes to make them accessible to
>>>>>> specific virtual machines (qemu instances).  In that scenario, we needed
>>>>>> userspace to be able to drive the labeling based on more than just the
>>>>>> pathname and so genfs_contexts wasn't suitable.
>>>
>>> I do not think that is applicable anymore (although i may be wrong)
>>
>> Not sure what you mean, but to clarify, I mean that libvirt has to set
>> the context (at least the categories for MCS and possibly the type as
>> well) on any sysfs node that needs to be accessible by the qemu
>> instance.  At least that used to be the case.
>>
> 
> That is what i mean. I am not aware of any such scenario's today. Again, I might be overlooking it.

Would only show up if you are doing PCI passthrough, I believe.

Also possible that they never leveraged the support in libvirt even
after we got the kernel support merged.  But not to say that it wouldn't
improve their security nonetheless today...
