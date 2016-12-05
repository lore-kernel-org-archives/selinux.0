Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB5NCwrJ022411
 for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2016 18:12:58 -0500
Received: by mail-vk0-f67.google.com with SMTP id x186so17072408vkd.2
 for <selinux@tycho.nsa.gov>; Mon, 05 Dec 2016 15:12:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+RmS--S8RmtWixUhkw4sgtqKZaBH7pxFwJ7z4WOrDU-BQv=sA@mail.gmail.com>
References: <1478551587-33892-1-git-send-email-david.graziano@rockwellcollins.com>
 <CAHC9VhQXrybHPt41-f-hcXZJ=i=N5qexdoM2VFLTxFfmuq8Yzg@mail.gmail.com>
 <CA+RmS--i8PiHmt1foeVEYP+uGDxhGLaROzxLvU=GNXW76fDy5A@mail.gmail.com>
 <CAHC9VhS1GmjyaY1GqvKJ9q_FoyH=t1EGS_0Eh+GOoGNuEJ2_8w@mail.gmail.com>
 <CA+RmS-_oMDkmtwYeq48HDMU0HE8hwe2w2cR5U77s5yeirCvw-Q@mail.gmail.com>
 <CAHC9VhT544S9rNE5EwsY8yDUW6dGojVkPJxijGfXWmYQNgAs_w@mail.gmail.com>
 <CA+RmS--S8RmtWixUhkw4sgtqKZaBH7pxFwJ7z4WOrDU-BQv=sA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 Dec 2016 18:12:55 -0500
Message-ID: <CAHC9VhT2_RBur1cVnYSvY0Y-W7WZwxwJYjBrVuBxRoALia_A3Q@mail.gmail.com>
Subject: Re: [PATCH 1/1 V2] mqueue: Implment generic xattr support
To: David Graziano <david.graziano@rockwellcollins.com>
Cc: golbi@mat.uni.torun.pl, Michal Wronski <michal.wronski@gmail.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Seth Forshee <seth.forshee@canonical.com>, ebiederm@xmission.com,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Dec 5, 2016 at 11:15 AM, David Graziano
<david.graziano@rockwellcollins.com> wrote:
> On Mon, Dec 5, 2016 at 9:37 AM, Paul Moore <paul@paul-moore.com> wrote:
>> On Mon, Nov 28, 2016 at 3:04 PM, David Graziano
>> <david.graziano@rockwellcollins.com> wrote:
>>> On Wed, Nov 9, 2016 at 4:25 PM, Paul Moore <paul@paul-moore.com> wrote:
>>>> On Wed, Nov 9, 2016 at 11:25 AM, David Graziano
>>>> <david.graziano@rockwellcollins.com> wrote:
>>>>> On Mon, Nov 7, 2016 at 4:23 PM, Paul Moore <paul@paul-moore.com> wrote:
>>>>>> On Mon, Nov 7, 2016 at 3:46 PM, David Graziano
>>>>>> <david.graziano@rockwellcollins.com> wrote:
>>>>>>> This patch adds support for generic extended attributes within the
>>>>>>> POSIX message queues filesystem and setting them by consulting the LSM.
>>>>>>> This is needed so that the security.selinux extended attribute can be
>>>>>>> set via a SELinux named type transition on file inodes created within
>>>>>>> the filesystem. The implementation and LSM call back function are based
>>>>>>> off tmpfs/shmem.
>>>>>>>
>>>>>>> Signed-off-by: David Graziano <david.graziano@rockwellcollins.com>
>>>>>>> ---
>>>>>>>  ipc/mqueue.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>  1 file changed, 46 insertions(+)
>>>>>>
>>>>>> Hi David,
>>>>>>
>>>>>> At first glance this looks reasonable to me, I just have a two
>>>>>> questions/comments:
>>>>>>
>>>>>> * Can you explain your current need for this functionality?  For
>>>>>> example, what are you trying to do that is made easier by allowing
>>>>>> greater message queue labeling flexibility?  This helps put things in
>>>>>> context and helps people review and comment on your patch.
>>>>>>
>>>>>> * How have you tested this?  While this patch is not SELinux specific,
>>>>>> I think adding a test to the selinux-testsuite[1] would be worthwhile.
>>>>>> The other LSM maintainers may suggest something similar if they have
>>>>>> an established public testsuite.
>>>>>>
>>>>>> [1] https://github.com/SELinuxProject/selinux-testsuite
>>>>>
>>>>> Hi Paul,
>>>>>
>>>>> I needed to write a selinux policy for a set of custom applications that use
>>>>> POSIX message queues for their IPC. The queues are created by one
>>>>> application and we needed a way for selinux to enforce which of the other
>>>>> apps are able to read/write to each individual queue. Uniquely labeling them
>>>>> based on the app that created them and the file name seemed to be our best
>>>>> solution since it’s an embedded system and we don’t have restorecond to
>>>>> handle any relabeling.
>>>>
>>>> In the future putting things like the above in the patch description
>>>> can be helpful.  In other words, instead of simply saying this allows
>>>> you to better control the labels assigned to message queues, you could
>>>> expand upon it by saying that this patch allows you to better control
>>>> which applications have access to a given queue.  Yes, I realize that
>>>> is implied by better control over the labels, but being explicit is
>>>> rarely a bad thing when it comes to patch descriptions.
>>>>
>>>> I've never rejected a patch for a description that was too lengthy,
>>>> but I have rejected patches that need better descriptions ;)
>>>>
>>>>> To test this patch I used both a selinux enabled, buildroot based qemu target
>>>>> with a customized selinux policy and test C app to create the mqueues. I also
>>>>> tested with our real apps and selinux policy on our target hardware. I can
>>>>> certainly look at adding a test to the selinux-testsuite if that would
>>>>> be helpful.
>>>>
>>>> Please do.  I've been requiring tests for all new SELinux
>>>> functionality lately; this isn't strictly a SELinux patch but I think
>>>> it is a good practice regardless.
>>>
>>> Sorry for the delay. I have created a pull request within the
>>> selinux-testsuite github
>>> project with a set of mqueue tests.
>>
>> For anyone who is curious:
>>
>> * https://github.com/SELinuxProject/selinux-testsuite/pull/10
>>
>> Aside from a naming nit, the tests look good to me and I have no
>> problem with the kernel patch; it doesn't appear any of the other LSM
>> maintainers do either.  I'm happy to pull this into the SELinux tree
>> (for v4.11, it's a little late for v4.10 I think), but I think
>> Christoph made a good point about consolidation, have you had a chance
>> to look at that?
>
> I've made the update for the naming nit in the pull request.

I saw that, thanks.

> I agree with Christoph's point but doing so is a bit outside my expertise at
> this point. I would be open to suggestions as to where the function should be
> consolidated and work on a second patchset with the update. Maybe in
> fs/xattr.c as a simple_xattr_initxattrs function?

That seems to make the most sense, doesn't it?  Looking at
{shmem,mqueue}_initxattrs() the only fs specific bit is the
{shmem,mqueue}_inode_info struct pointer; considering that the fs_info
parameter is currently unused in this case, you could pass a reference
to the simple_xattr struct via the fs_info parameter.

I'd CC Andreas Gruenbacher <agruenba@redhat.com> on the patch(set),
he's recently done a bunch of work around xattrs and the LSM, he may
have some additional thoughts.

-- 
paul moore
www.paul-moore.com
