Subject: Re: Has anyone ever looked into adding labeling support for the
 cgroup file system
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
References: <11517275-0f09-97cd-0353-312c890a4a09@redhat.com>
 <1484668315.20454.14.camel@tycho.nsa.gov>
 <CAHC9VhTdO5YexXjWu+1rYC_eUSxu=Oj0MmoJaL-mHPK-T5291w@mail.gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <72ee3b24-634f-4156-c394-23434d229533@redhat.com>
Date: Wed, 18 Jan 2017 14:59:33 -0500
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTdO5YexXjWu+1rYC_eUSxu=Oj0MmoJaL-mHPK-T5291w@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I believe in the Tom Sawyer method of writing code.  Suggest a neat idea
and wait for some else to "Whitewash the fence"  ie write the patches.


On 01/18/2017 02:26 PM, Paul Moore wrote:
> On Tue, Jan 17, 2017 at 10:51 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On Tue, 2017-01-17 at 10:34 -0500, Daniel J Walsh wrote:
>>> In order to allow processes to modify the cgroup hierarchy in a
>>> container from an SELinux point of view, we need to allow read/write
>>> access to cgroup_t, which means that a container process could break
>>> out
>>> and modify all cgroups, we want to allow them to only modify the
>>> portion
>>> of the hierarchy handed to them.
>>>
>>> Would be a nice security improvement for docker.
>> Probably as easy as adding cgroup to the list of filesystem types that
>> use genfscon but also support setxattr (like sysfs) in
>> selinux_is_sblabel_mnt() in security/selinux/hooks.c.  sysfs and cgroup
>> are both implemented on top of kernfs in modern kernels, so they should
>> both support proper setting of security labels.
> .. and a test should be added to the selinux-testsuite.
>
> Come on Dan, you know you want to write some more kernel code ;)
>
