Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0JE6TvO025316
 for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2017 09:06:29 -0500
Subject: Re: New Blog on how SELinux blocked Docker container escape.
To: =?UTF-8?B?6Z2i5ZKM5q+F?= <ka-omo@sios.com>
References: <81c53826-f45f-8e01-e64b-8b16285d575d@redhat.com>
 <20170114082311.GN12376@tracyreed.org> <87pojqj86o.fsf@elektro.pacujo.net>
 <bc24daad-4944-925f-157c-3dfdc88e253e@redhat.com>
 <CAEKGoSHqxmHMyFVNTvLZcHC4unpONu2O2cq+Y3EZ5=z6=7Ld0A@mail.gmail.com>
 <ad7128b6-44a5-e2d9-4da6-743786665174@redhat.com>
 <CAEKGoSEsvrAZPfQ+sJ7bgubZUnHQJYfiURf=qxAAEMZegVk39w@mail.gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>,
 Fedora SELinux Users <selinux@lists.fedoraproject.org>,
 Marko Rauhamaa <marko@pacujo.net>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <a5ed5e5d-cfd7-b2a4-89b0-4d7223e08cf9@redhat.com>
Date: Thu, 19 Jan 2017 09:06:24 -0500
MIME-Version: 1.0
In-Reply-To: <CAEKGoSEsvrAZPfQ+sJ7bgubZUnHQJYfiURf=qxAAEMZegVk39w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

You are not testing with SELinux if it can read /etc/shadow.  The
process should be running as container_t or svirt_lxc_net_t if it is an
older version.


We currently label runc as container_runtime_exec_t.

dnf reinstall container-selinux

ls -lZ /usr/sbin/runc



On 01/19/2017 02:56 AM, 面和毅 wrote:
> Dear Sir,
>
> Thanks. I was checking can we cat /etc/shadow in my testing environment.
> It seems that is protected because that file's permission is set to "000".
>
> Here is my test result;
> --------------------------------------------------------------
> ----------. 1 root root system_u:object_r:shadow_t:s0
> 1268 Oct 13 07:55 /etc/shadow
>
> SELinux Enforcing  -> Permission Denied
> SELinux Permissive -> Permission Denied
> SELinux Disabled -> Permission Denied
>
> When I changed that permission to "755";
>
> SELinux Enforcing  -> Could cat /etc/shadow
> SELinux Permissive -> Could cat /etc/shadow
> SELinux Disabled -> Could cat /etc/shadow
>
> Then in this case that escaped user could
> have read access to shadow_t label.
> --------------------------------------------------------------
>
> That "runc" process seems to be working as unconfined_t domain;
>
> [root@fedora25 ~]# ps axZ|grep runc
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 1578 pts/0 Sl+
> 0:00 runc run ctr
>
> So, I'm not sure but I guess we would better to assign
> other domain to "runc" program (no unconfined_t).
>
> Let me check if we will run "runc" in other domain.
>
> Kind Regards,
>
> OMO
>
> 2017-01-18 23:14 GMT+09:00 Daniel J Walsh <dwalsh@redhat.com>:
>>
>> On 01/18/2017 12:05 AM, 面和毅 wrote:
>>> Dear Sir,
>>>
>>> I'm member of Japan-SOSS SIG(Secure OSS Special
>>> Interest Group).
>>> We love SELinux(12years user) and we are promoting SELinux in Japan.
>>>
>>> >From technical interesting(we are promoting Docker
>>> with SELinux), we did PoC for CVE-2016-9962 on Fedora25.
>>>
>>> Then we found current SELinux(maybe policy) does not
>>> mitigate that vulnerability.
>>>
>>> We could reproduce that vulnerability with
>>> - add CAP_SYS_PTRACE to container
>>> - modified runc because there’s not so much race window on runc.
>>> then we think it's not so easy in usual situation.
>>> Also we couldn't reproduce it on CentOS7(latest).
>>>
>>> We posted that PoC result on our community blog.
>>> https://jsosug.github.io/post/omok-selinux-docker-20170118/
>>>
>>> Also we wish to argue how can we protect this kind of
>>> vulnerability by using SELinux.
>>>
>>> Kind Regards,
>>>
>>> OMO
>> Attempt to cat /etc/shadow in your test to see the blockage.
>>
>> Here is a blog I wrote on the topic.
>>
>> http://rhelblog.redhat.com/2017/01/13/selinux-mitigates-container-vulnerability/
>>
>
>
