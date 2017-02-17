Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1HGxGfJ015311
 for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2017 11:59:16 -0500
Received: by mail-vk0-f68.google.com with SMTP id 23so4122160vkc.2
 for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2017 08:59:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1702171424020.4873@namei.org>
References: <1487256718-26141-1-git-send-email-sds@tycho.nsa.gov>
 <alpine.LRH.2.20.1702171424020.4873@namei.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 17 Feb 2017 11:59:12 -0500
Message-ID: <CAHC9VhSxXcXkvPrLM3tjhqMxdK8kwEt2AWB46Pqc3PqomA3qMw@mail.gmail.com>
Subject: Re: [PATCH] prlimit, security,
 selinux: add a security hook for prlimit
To: James Morris <jmorris@namei.org>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 jslaby@suse.cz, Stephen Smalley <sds@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Feb 16, 2017 at 10:24 PM, James Morris <jmorris@namei.org> wrote:
> On Thu, 16 Feb 2017, Stephen Smalley wrote:
>
>> When SELinux was first added to the kernel, a process could only get
>> and set its own resource limits via getrlimit(2) and setrlimit(2), so no
>> MAC checks were required for those operations, and thus no security hooks
>> were defined for them. Later, SELinux introduced a hook for setlimit(2)
>> with a check if the hard limit was being changed in order to be able to
>> rely on the hard limit value as a safe reset point upon context
>> transitions.
>
> [...]
>
>
> Queued for 4.11 at
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git#next-queue

Stephen pushed a v2 patch to fix a build problem, are you going to
fixup your tree?

-- 
paul moore
www.paul-moore.com
