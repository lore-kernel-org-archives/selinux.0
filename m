Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1AN61Qw024382
 for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2017 18:06:01 -0500
Subject: Re: [PATCH] security: selinux: allow per-file labeling for cgroupfs
To: Paul Moore <paul@paul-moore.com>, Antonio Murdaca <amurdaca@redhat.com>
References: <20170209160242.23405-1-amurdaca@redhat.com>
 <CAHC9VhRFxDuRJHYEuRs7kc4ivgaT=-SxdU-o5Lq7H-O+5JJRxQ@mail.gmail.com>
 <CALKLTGTc7U7ohxd44MHOuzVomW-oUsumqUqr0MKaUohw1NpSsg@mail.gmail.com>
 <CAHC9VhSj4ztDZwxfcuugaD5-OJrBVaJ=TQS=t4=jfL0+ZdbdYQ@mail.gmail.com>
 <CALKLTGTjpBYd5-M9RiO-Q4H_SokEiPJYptbxktg_aPccws59Jw@mail.gmail.com>
 <CAHC9VhTMxN5sqk+BL6f4-V7o3ez=7fMHBWFRAvj+j5iD+VkiMA@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Antonio Murdaca <runcom@redhat.com>, selinux@tycho.nsa.gov,
 Vivek Goyal <vgoyal@redhat.com>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <4835d22f-2ec2-0dd8-39a3-562335682568@redhat.com>
Date: Fri, 10 Feb 2017 18:05:55 -0500
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTMxN5sqk+BL6f4-V7o3ez=7fMHBWFRAvj+j5iD+VkiMA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 02/09/2017 06:04 PM, Paul Moore wrote:
> On Thu, Feb 9, 2017 at 5:32 PM, Antonio Murdaca <amurdaca@redhat.com> wrote:
>>
>> On Feb 9, 2017 20:23, "Paul Moore" <paul@paul-moore.com> wrote:
>>
>> On Thu, Feb 9, 2017 at 12:39 PM, Antonio Murdaca <amurdaca@redhat.com>
>> wrote:
>>> On Feb 9, 2017 17:14, "Paul Moore" <paul@paul-moore.com> wrote:
>>> On Thu, Feb 9, 2017 at 11:02 AM, Antonio Murdaca <amurdaca@redhat.com>
>>> wrote:
>>>> From: Antonio Murdaca <runcom@redhat.com>
>>>>
>>>> This patch allows genfscon per-file labeling for cgroupfs. For instance,
>>>> this allows to label the "release_agent" file within each
>>>> cgroup mount and limit writes to it.
>>>>
>>>> Signed-off-by: Antonio Murdaca <amurdaca@redhat.com>
>>>> ---
>>>>  security/selinux/hooks.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>> This was already merged ... ?
>>>
>>>
>>> This is adding cgroup and cgroup2 to the other whitelist (afaict).
>> Yes, my apologies, I read this patch too quickly and confused it with
>> the previous cgroups patch.
>>
>> Just to set expectations, this patch is too late for the upcoming
>> merge window, we can consider it in a few weeks once the merge window
>> has closed.  This should give you some time to do some further testing
>> (hint, hint).
>>
>>
>> Sure, I'm going to test this and add tests in selinux-testsuite as well
> Great, thank you.
>
No problem on waiting for this patch.  Stephen asked for this, but this is
not something we are currently planning on using with containers.
