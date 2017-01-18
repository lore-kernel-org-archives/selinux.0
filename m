Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0IJQEGS032009
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 14:26:14 -0500
Received: by mail-ua0-f170.google.com with SMTP id 96so16994420uaq.3
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 11:26:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484668315.20454.14.camel@tycho.nsa.gov>
References: <11517275-0f09-97cd-0353-312c890a4a09@redhat.com>
 <1484668315.20454.14.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Jan 2017 14:26:12 -0500
Message-ID: <CAHC9VhTdO5YexXjWu+1rYC_eUSxu=Oj0MmoJaL-mHPK-T5291w@mail.gmail.com>
Subject: Re: Has anyone ever looked into adding labeling support for the
 cgroup file system
To: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jan 17, 2017 at 10:51 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2017-01-17 at 10:34 -0500, Daniel J Walsh wrote:
>> In order to allow processes to modify the cgroup hierarchy in a
>> container from an SELinux point of view, we need to allow read/write
>> access to cgroup_t, which means that a container process could break
>> out
>> and modify all cgroups, we want to allow them to only modify the
>> portion
>> of the hierarchy handed to them.
>>
>> Would be a nice security improvement for docker.
>
> Probably as easy as adding cgroup to the list of filesystem types that
> use genfscon but also support setxattr (like sysfs) in
> selinux_is_sblabel_mnt() in security/selinux/hooks.c.  sysfs and cgroup
> are both implemented on top of kernfs in modern kernels, so they should
> both support proper setting of security labels.

... and a test should be added to the selinux-testsuite.

Come on Dan, you know you want to write some more kernel code ;)

-- 
paul moore
www.paul-moore.com
