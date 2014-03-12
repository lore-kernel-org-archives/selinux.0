Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2C39KXW000412
 for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2014 23:09:20 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so9469718obc.2
 for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2014 20:09:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <531F08ED.9030700@redhat.com>
References: <CACBeRbb2fZCWgH93aJ61nfkCCZoJSG3aeaW=9ODSccVXzRQ9xg@mail.gmail.com>
 <52FB8288.1080004@tycho.nsa.gov>
 <CACBeRbY32sYaN8LWKxQ5f=6kyV6_dNgdhVkesTV07i-DRwkKrA@mail.gmail.com>
 <2911268.ly5TttHi39@sifl> <531F08ED.9030700@redhat.com>
Date: Wed, 12 Mar 2014 10:09:18 +0700
Message-ID: <CACBeRbZBn1v2F2cr0bU12RUibiEs+qDEEWN_2J3H2KG_po0hpQ@mail.gmail.com>
Subject: Re: Detail description of some projects in TO DO list page
From: nguyen thai <thai.bkset@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>,
 selinux maillist <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Until now, any processes with root privilege can change cgroup
settings. Others cannot. Definitely we can grant more permissions for
processes in a cgroup to edit its subgroup. But I think there will be
a problem.

Cause there are many processes in a cgroup, so maybe more than one
want to edit the same subgroup. Or Change a subgroup settings will
definitely affect the other subgroups which an other process want to
control. That will cause a conflict. Or a malware or bad-behavior
program can limit other subgroup so it can get more resource.

To solve this problem, we need an arbitrator. And is Selinux too low
level to take this role?

On Tue, Mar 11, 2014 at 8:00 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 03/10/2014 05:45 PM, Paul Moore wrote:
>> On Monday, March 10, 2014 02:31:29 PM nguyen thai wrote:
>>> On Wed, Feb 12, 2014 at 9:17 PM, Stephen Smalley <sds@tycho.nsa.gov>
>>> wrote:
>>>> On 02/11/2014 09:24 PM, nguyen thai wrote:
>>>>> Hi everyone,
>>>>>
>>>>> I have started my study in SELinux recently. I found some projects in
>>>>> TO DO list page were really interesting. Can anyone give me more
>>>>> details (what's problem now? it's effects or drawbacks) of one of
>>>>> following projects or any other projects that i can start to work
>>>>> on?
>>>>>
>>>>> - Investigate security policy for cgroups - CIFS support for
>>>>> single-context clients - Real device labeling and access control
>>>>>
>>>>> Thank you very much.
>>>>
>>>> That TODO list is old and not actively maintained, so it may be better
>>>> to look at recent mailing list archives to see areas where you can
>>>> contribute most effectively.  Also look for recent discussions of
>>>> selinux in the linux-security-module and linux-kernel mailing list
>>>> archives.
>>>>
>>>> On the cgroup item, it should be possible to support finer-grained
>>>> labeling of cgroup files now that cgroup supports xattrs, but it will
>>>> require a small kernel change (similar to the changes previously made
>>>> for sysfs and rootfs; need to generalize that), and thereby enabling
>>>> policy control over specific cgroup files.  There may also be work
>>>> required inside the cgroup code to add security hooks and permission
>>>> checks for MAC; that would require analysis of the cgroup
>>>> implementation, existing DAC checks, ways in which they can permit
>>>> different security labels to interact/interfere with each other, etc.
>>>
>>> Hi, I have spent several weeks on digging into cgroup code and its
>>> problems. As i understand, there are several reasons why you want to
>>> enable MAC checks over specific cgroup file:
>>>
>>> + The cgroup interface is filesystem, means that users can change
>>> permissions on subdirectories and give access to a non-privileged
>>> security domain, ie non-root users. Leading to an individual application
>>> can interact directly with the cgroup filesystem. It ends up exposing
>>> control knobs which are tightly coupled to kernel implementation details
>>> right into lay binaries and scripts directly used by end users.
>>>
>>> + The cgroups trees are a shared resource. Many applications can use it
>>> simultaneously. So they can conflicts with others. Ex, move tasks, delete
>>> or move the cgroups that belong to  other applications.
>>>
>>> MAC check can improve some of the cgroup problems. But I've heard that
>>> cgroup and systemd developers have been making really big changes to fix
>>> these cgroup problems. As they described here
>>> http://lists.freedesktop.org/archives/systemd-devel/2013-June/011521.html
>>>
>>>
> or http://www.freedesktop.org/wiki/Software/systemd/ControlGroupInterface/
>>> They are creating a centralized userland authority which takes full
>>> ownership of the cgroup filesystem interface, and makes policy decisions
>>> based on configuration and requests. This may solve above problems.
>>>
>>> So does implementing MAC checks on cgroup can is needed anymore? Can it
>>> help improving some other problems? I'm getting stuck finding something
>>> to do here.
>>
>> I think it might make sense to first look at what you are hoping to
>> accomplish, not in terms of code/hooks/etc., but rather high-level access
>> controls.  Try not to focus on the implementation to start, for example:
>>
>> * What can one do with cgroups, how are they managed?  Of all the different
>>  configuration/management operations, which are significant from a security
>>  perspective?
>>
>> * For each of these operations, what is the SELinux subject and object?
>> What would the security policy look like?  Does it make sense?
>>
>> .. and go from there.
>>
>
> I would see a possible security goal, would be with containers.  Could I run a
> container within a group of cgroups and allow the processes within the cgroup
> to further limit the cgroups.
>
> IE If I run a container with a max of 2Gig or memory, could a process within
> the container, further limit a child process to 1Gig of memory, and not allow
> a process within the container to setup a cgroup with > 2Gig of memory.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iEYEARECAAYFAlMfCO0ACgkQrlYvE4MpobMEDQCfSB5J7Vgsq5rdJqLWIjej3n3+
> x9UAoJoGLKWW2YSypX23dc9eQ6kIJbK1
> =+aPS
> -----END PGP SIGNATURE-----
