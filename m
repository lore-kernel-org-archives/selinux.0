Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v29Gdsdk003605
 for <selinux@tycho.nsa.gov>; Thu, 9 Mar 2017 11:39:54 -0500
Subject: Re: isolate selinux_enforcing
To: yangshukui <yangshukui@huawei.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
References: <58732BCF.4090908@huawei.com> <58734284.1060504@huawei.com>
 <b7f75f65-592a-5102-0ac5-4d3aa43f0b55@huawei.com> <58736B2E.90201@huawei.com>
 <58C11A6C.7000408@huawei.com>
Cc: Lizefan <lizefan@huawei.com>, paul@paul-moore.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, james.l.morris@oracle.com, oleg@redhat.com,
 ebiederm@xmission.com, serge.hallyn@ubuntu.com,
 Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <347f63b5-c274-c7bc-55f7-f6304d31418a@schaufler-ca.com>
Date: Thu, 9 Mar 2017 08:39:10 -0800
MIME-Version: 1.0
In-Reply-To: <58C11A6C.7000408@huawei.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 3/9/2017 1:03 AM, yangshukui wrote:
> I want to use SELinux in system container and only concern the function in the container.
> this system container run in vm and every vm has only one system container.
>
> How do I use now?
> docker run ... system-contaier /sbin/init
> after init is running ,the following service is also running:
>
> #this is the part of service file which will run in container after starting the container.
> ..
> semodule -R     #use the policy in container.
> restorecon /     #if needed
> ..
>
> this method seem to work if host os and the docker images use the same content for rootfs, but if host use
> redhat7 and docker images use centos7, it will deny many normal operations , and this let some host service not work.
>
> If SELinux is permissive in host and enforcing in container ,it will resolve my problem. Unfortunately,
> there is no namespace for SELinux.

The LSM infrastructure is essentially a set of lists.
These lists are rooted globally, but there's no reason*
they couldn't be rooted in a namespace. That would give
each namespace the option of using whatever security
scheme was deemed appropriate. There are a number of
issues, such as namespacing policy, that would have to
be addressed, but the mechanism could work fine. I would
look at patches.

---
* Other than the sheer insanity of making security
  claims about such a system. I would not expect that
  minor issue to slow demand or deployment any more
  than it has in the past.

>
> Isolate SELinux is difficult and it has a lot of work to do, but is easier to isolate selinux_enforcing.
>
> What do you think ?
>
> Think you very much.
>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
