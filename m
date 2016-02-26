Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1QHFGe4014010
 for <selinux@tycho.nsa.gov>; Fri, 26 Feb 2016 12:15:16 -0500
Received: by mail-ob0-f169.google.com with SMTP id jq7so83103168obb.0
 for <selinux@tycho.nsa.gov>; Fri, 26 Feb 2016 09:15:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1456504306.3481.42.camel@redhat.com>
References: <1456423369.3702.42.camel@redhat.com>
 <56CF4574.3030709@tycho.nsa.gov>
 <1456426779.3702.52.camel@redhat.com>
 <56CF523A.7000503@tycho.nsa.gov>
 <1456429021.31341.34.camel@redhat.com>
 <56CF5A54.7020600@tycho.nsa.gov>
 <1456432101.3702.67.camel@redhat.com>
 <56CF6A08.6010305@tycho.nsa.gov>
 <1456491264.3481.2.camel@redhat.com>
 <CAHC9VhQwrmbH7UONJET6XOwfqJvn46fe9WXgkFOP-JDd4ss1uw@mail.gmail.com>
 <1456504306.3481.42.camel@redhat.com>
Date: Fri, 26 Feb 2016 12:15:13 -0500
Message-ID: <CAHC9VhRGwJVTcDrPF0KjA9haO5=tK_0w_eYXTxEMPSjH4NjDWA@mail.gmail.com>
Subject: Re: Strange AVC with latest rawhide kernel.
From: Paul Moore <paul@paul-moore.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Feb 26, 2016 at 11:31 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> On Fri, 2016-02-26 at 10:46 -0500, Paul Moore wrote:
>> Would that resolve all your problems Dan with Docker, runc, etc.?
>> From our discussions the other day I thought you needed the ability
>> transition to svirt_lxc_net_t from domains other than unconfined_t
>> and docker_t ... or was I misunderstanding you?
>
> Well the two ways we transition to svirt_sandbox_file_t is from runc
> which will usually from either docker_t or from unconfined_t.  And from
> docker.
>
> We just need to label runc as docker_exec_t so that if you run it from
> a systemd unit file the correct transitions will happen.

Okay, easy enough.  Looks like we don't have to worry about this right now.

-- 
paul moore
www.paul-moore.com
