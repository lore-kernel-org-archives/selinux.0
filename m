Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2S1GFHZ008674
 for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2016 21:16:16 -0400
Received: by mail-oi0-f68.google.com with SMTP id z7so5066806oig.0
 for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2016 18:16:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56F539B9.9080003@redhat.com>
References: <56F5152E.3050602@gmail.com> <56F52FA5.6050601@tycho.nsa.gov>
 <56F539B9.9080003@redhat.com>
Date: Sun, 27 Mar 2016 21:16:13 -0400
Message-ID: <CAHC9VhSobMxqjNeG9AVtKkakU4rYu4NhOiX0k5H4DzGKy6WodA@mail.gmail.com>
Subject: Re: what is /sys/fs/selinux/policy_capabilities/redhat1
From: Paul Moore <paul@paul-moore.com>
To: Daniel J Walsh <dwalsh@redhat.com>, mgrepl@redhat.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov,
 Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Mar 25, 2016 at 9:14 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> On 03/25/2016 08:31 AM, Stephen Smalley wrote:
>> On 03/25/2016 06:38 AM, Dominick Grift wrote:
>>>
>>> I noticed that object what is it for?
>>
>> Red Hat reserved a policy capability when they were testing
>> ptrace_child, which they ultimately discarded.  So it is presently
>> unused and maybe could be reclaimed?  I assume ptrace_child never made
>> it into any RHEL release?
>>
>> Oddly, I see that current Fedora policy still defines a ptrace_child
>> permission in class process, even though the kernel knows nothing about
>> it.
>
> We should probably drop it.

I just added a note to the BZ below to get the permission removed from
the Fedora policy.

 * https://bugzilla.redhat.com/show_bug.cgi?id=802072

As for the "redhat1" policycap and the kernel, we could remove it, but
I would just assume leave it there until we have a new policycap to
take its place.

-- 
paul moore
www.paul-moore.com
