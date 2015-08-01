Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t71H1QoJ003798
 for <selinux@tycho.nsa.gov>; Sat, 1 Aug 2015 13:01:26 -0400
Received: by ykek23 with SMTP id k23so8900981yke.0
 for <selinux@tycho.nsa.gov>; Sat, 01 Aug 2015 10:01:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55BBD30B.3000504@schaufler-ca.com>
References: <CAA2m6vdCmHf1=F=QrjCYEtxdEVMDtp7wKza=vd6Tpv-L9XTqHg@mail.gmail.com>
 <55BBD30B.3000504@schaufler-ca.com>
Date: Sat, 1 Aug 2015 20:01:24 +0300
Message-ID: <CAA2m6vd+Ag+6Dj0bbNENitYw5mhxkDkggq-5muDS-fGQ0VsaJQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
From: Amir Goldstein <amir@cellrox.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Cc: Serge Hallyn <serge.hallyn@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 31, 2015 at 10:56 PM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> On 7/31/2015 1:11 AM, Amir Goldstein wrote:
>> On Thu, Jul 30, 2015 at 6:33 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 7/30/2015 7:47 AM, Amir Goldstein wrote:
>>>> On Thu, Jul 30, 2015 at 4:55 PM, Seth Forshee
>>>> <seth.forshee@canonical.com> wrote:
>>>>> On Thu, Jul 30, 2015 at 07:24:11AM +0300, Amir Goldstein wrote:
>>>>>> On Tue, Jul 28, 2015 at 11:40 PM, Seth Forshee
>>>>>> <seth.forshee@canonical.com> wrote:
>>>>>>> On Wed, Jul 22, 2015 at 05:05:17PM -0700, Casey Schaufler wrote:
>>>>>>>>> This is what I currently think you want for user ns mounts:
>>>>>>>>>
>>>>>>>>>  1. smk_root and smk_default are assigned the label of the backing
>>>>>>>>>     device.
>>>>>> Seth,
>>>>>>
>>>>>> There were 2 main concerns discussed in this thread:
>>>>>> 1. trusting LSM labels outside the namespace
>>>>>> 2. trusting the content of the image file/loopdev
>>>>>>
>>>>>> While your approach addresses the first concern, I suspect it may be placing
>>>>>> an obstacle in a way for resolving the second concern.
>>>>>>
>>>>>> A viable security policy to mitigate the second concern could be:
>>>>>> - Allow only trusted programs (e.g. mkfs, fsck) to write to 'Loopback' images
>>>>>> - Allow mount only of 'Loopback' images
>>>>>>
>>>>>> This should allow the system as a whole to trust unprivileged mounts based on
>>>>>> the trust of the entities that had raw access the the fs layout.
>>>>> You don't really say what you mean by "trusted" programs. In a container
>>>>> context I'd have to assume that you mean suid-root or similar programs
>>>>> shared into the container by the host. In that case is any new kernel
>>>>> functionality even required?
>>>> Sorry I was not clear. I will try to explain better.
>>>> I meant that the programs are "trusted" by the LSM security policy.
>>>> I envisioned a system where unprivileged user is allowed to spawn
>>>> a container which contains "trusted" programs (e.g. mkfs) that are labeled
>>>> as 'FileSystemTools' by the admin of the host.
>>>> FileSystemTools are allowed to write into Loopback labeled files.
>>> You could do this on a Smack based system. It would require
>>> CAP_MAC_ADMIN and CAP_MAC_OVERRIDE to set up. You would need
>>> to set some SMACK64EXEC labels on your FileSystemTools, and
>>> they would have to be written as carefully as the would if they
>>> had "more" privilege. You'd need to designate a repository for
>>> your loopback files. On the whole, it would be unattractive.
>>> I will pass on providing the details for fear someone will like
>>> it well enough to implement.
>>>
>>>>> That also doesn't work for some of our use cases, where we'd like to be
>>>>> able to do something like "mount -o loop foo.img /mnt/foo" in an
>>>>> unprivileged container where foo.img is not created on the local machine
>>>>> and not fully under control of the host environment.
>>>> That use case will not be addressed by the policy I suggested,
>>>> but the more common case of:
>>>> - create a loopback file
>>>> - mkfs
>>>> - mount
>>>> will be addressed.
>>>>
>>>> So if the (host) admin of the system trusts that unprivileged user cannot create
>>>> a malicious fs layout using mkfs and fsck alone, then the system is
>>>> relatively safe
>>>> mounting (non fuse) file systems from loopback files.
>>>> IMHO, this statement is going to be easier for Ted to sign.
>>> But that sort of defeats the purpose of unprivileged mounts.
>>> Or rather, you're trying to place restrictions on what an
>>> unprivileged user can do without calling the ability to
>>> violate those restrictions "privilege".
>> I don't understand your concern.
>
> My concern is that you're playing a shell game. Allow unprivileged
> mounts, but only of things that where created using privilege. How
> is that better than requiring privilege to do the mount?

To me, the ability of an admin to delegate permissions to unprivileged
user to mkfs/fsck/mount "trusted" loopdevs, sounds very useful.
But I am not going to argue that use case any further.

I do agree that it would have been much better if user namespace
could allow unprivileged mounts of certain non FUSE file systems
without relying on specially crafted security policies, but I do not
see how that can happen.


>
>> I am saying that LSM can come to the rescue, in a use case that
>> many have been considering as unsolvable (i.e. the loopback tampering).
>>
>> Yes, I am trying to place restrictions on what an unprivileged user can do.
>> As it stands right now, user is about to gain the ability to mount FUSE.
>> With some extra care on crafting the policy and without any extra code,
>> user can gain the ability to mount "trusted loopback files".
>> It does not solve all use cases, but it does solve a handful.
>
> As I said, you can do this, but it will be ugly, and people won't
> understand how to use it correctly. The distance between the "trusted"
> creation of the filesystem and the "untrusted" mount is too great.
> Plus, there are too many ways to circumvent the integrity of your
> "trusted" filesystem.
>
>> Anyway, the concern I was raising was about the fact that if files inside
>> the loopback mount inherit the label of the loopback file, this policy is
>> going to be impossible to write.
>> But Stephan has already proposed an alternative to this implicit inherit rule
>> on [PATCH 6/7] thread, so I withdraw my concern.
>
> What Stephan has proposed is dandy for SELinux.
>
>>
>>
>>>>> Agreed though that the "attack from below" problem for untrusted
>>>>> filesystems is still an open question. At minimum we have fuse, which
>>>>> has been designed to protect against this threat. Others have mentioned
>>>>> on this thread that Ted had said something at kernel summit last year
>>>>> about being willing to support ext4 mounts from unprivileged user
>>>>> namespaces as well. I've added Ted to the Cc in case he wants to confirm
>>>>> or deny this rumor.
>>>>>
>>>>>> Alas, if you choose to propagate the backing dev label to contained files,
>>>>>> they would all share the designated 'Loopback' label and render the policy above
>>>>>> useless.
>>>>>>
>>>>>> Any thoughts on how to reconcile this conflict?
>>>>> I'm not seeing what the conflict is here - nothing you proposed says
>>>>> anything about security labels in the filesystem, and nothing would
>>>>> prevent a "trusted" program with CAP_MAC_ADMIN from setting whatever
>>>>> label was desired on the backing device. Care to elaborate?
>>>>>
>>>>> Seth
>
