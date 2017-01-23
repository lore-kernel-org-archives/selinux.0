Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0N4bqw4021538
 for <selinux@tycho.nsa.gov>; Sun, 22 Jan 2017 23:37:52 -0500
Received: by mail-io0-f175.google.com with SMTP id l66so102212222ioi.1
 for <selinux@tycho.nsa.gov>; Sun, 22 Jan 2017 20:37:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAEKGoSFfXv3JpNFz-T70G_Ps83LKqKjhOV-noSeWKF6Tfeme+A@mail.gmail.com>
References: <81c53826-f45f-8e01-e64b-8b16285d575d@redhat.com>
 <20170114082311.GN12376@tracyreed.org> <87pojqj86o.fsf@elektro.pacujo.net>
 <bc24daad-4944-925f-157c-3dfdc88e253e@redhat.com>
 <CAEKGoSHqxmHMyFVNTvLZcHC4unpONu2O2cq+Y3EZ5=z6=7Ld0A@mail.gmail.com>
 <ad7128b6-44a5-e2d9-4da6-743786665174@redhat.com>
 <CAEKGoSEsvrAZPfQ+sJ7bgubZUnHQJYfiURf=qxAAEMZegVk39w@mail.gmail.com>
 <a5ed5e5d-cfd7-b2a4-89b0-4d7223e08cf9@redhat.com>
 <CAEKGoSFfXv3JpNFz-T70G_Ps83LKqKjhOV-noSeWKF6Tfeme+A@mail.gmail.com>
From: =?UTF-8?B?6Z2i5ZKM5q+F?= <ka-omo@sios.com>
Date: Mon, 23 Jan 2017 13:37:45 +0900
Message-ID: <CAEKGoSGQzk5Td=+r+TOjKe1z+40w7-3hRgMYNY16rUOK6C5xhg@mail.gmail.com>
Subject: Re: New Blog on how SELinux blocked Docker container escape.
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>,
 Fedora SELinux Users <selinux@lists.fedoraproject.org>,
 Marko Rauhamaa <marko@pacujo.net>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dear, Sir,

I just post detailed information and result on our community blog.

https://jsosug.github.io/post/omok-selinux-20170123/

Kind Regards,

OMO

2017-01-20 21:02 GMT+09:00 面和毅 <ka-omo@sios.com>:
> Dear Sir,
>
> Finally I found SELinux could mitigate that vulnerability. Good!! :-)
>
> I checked my PoC system status(actually re-installed fedora25 again),
> then I found that problem caused from selinux policy.
>
> policy version: selinux-policy-targeted-3.13.1-225.6.fc25.noarch
>
> I ran "runc" from shell, but it seems the policy is focusing to
> run "runc" from systemd, etc (I checked from CIL polocy).
>
> For my PoC, we need to run "runc" from shell.
> Then I needed to add localpolicy for typetransition from
> unconfined_t to container_t.
> Finally I found SELinux could prevent to cat /etc/shadow file. :-)
>
> Here is my result;
> -----------------------------------------------
> -rwxr-xr-x. 1 root root system_u:object_r: container_runtime_exec_t:s0
> 5016704 Jan 20 19:26 /usr/bin/runc
>
> ----------. 1 root root system_u:object_r:shadow_t:s0 1268 Oct 13
> 07:55 /etc/shadow
>
> unconfined_u:system_r:container_t:s0-s0:c0.c1023 10721 pts/1 Sl+
> 0:00 runc run ctr
>
> /etc/shadow permission is "000(Default)";
> SELinux Enforcing  -> Permission Denied
> SELinux Permissive -> Permission Denied
> SELinux Disabled -> Permission Denied
>
> /etc/shadow permission is "755(Modified)";
> SELinux Enforcing  -> Permission Denied
> SELinux Permissive -> Could cat /etc/shadow
> SELinux Disabled -> Could cat /etc/shadow
>
> On /var/log/audit/audit.log I found denied log;
> type=AVC msg=audit(1484911003.065:1299): avc:  denied  { read } for
> pid=10131 comm="cat" name="shadow" dev="dm-0" ino=785423 scontext=
> unconfined_u:system_r:container_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:shadow_t:s0 tclass=file permissive=0
> -----------------------------------------------
>
> Below is additional policy(because this is just
> for PoC, I only added denied permssion
> to container_t domain. Also I ran that container
> by "runc" in /tmp directory);
>
> -----------------------------------------------
> (typetransition unconfined_usertype container_runtime_exec_t process
> container_t)
> (roletransition unconfined_r container_runtime_exec_t process system_r)
>
> (allow container_t user_tmp_t (file (open read execute execute_no_trans)))
> (allow container_t var_run_t (dir (write add_name create setattr
> remove_name rmdir)))
> (allow container_t var_run_t (fifo_file (create setattr unlink read open)))
> (allow container_t ptmx_t (chr_file (read write open ioctl)))
> (allow container_t devpts_t (chr_file (setattr read write open ioctl getattr)))
> (allow container_t root_t (dir (mounton)))
> (allow container_t user_tmp_t (dir (mounton write add_name create
> remove_name rmdir)))
> (allow container_t user_tmp_t (lnk_file (read)))
> (allow container_t proc_t (filesystem (mount remount)))
> (allow container_t tmpfs_t (filesystem (mount remount)))
> (allow container_t tmpfs_t (dir (setattr write add_name create mounton)))
> (allow container_t devpts_t (filesystem (mount)))
> (allow container_t sysfs_t (filesystem (mount)))
> (allow container_t cgroup_t (filesystem (remount)))
> (allow container_t tmpfs_t (lnk_file (create)))
> (allow container_t tmpfs_t (chr_file (create setattr read write open
> getattr ioctl append)))
> (allow container_t tmpfs_t (file (open create mounton)))
> (allow container_t proc_t (dir (mounton)))
> (allow container_t proc_t (file (mounton)))
> (allow container_t sysctl_irq_t (dir (mounton)))
> (allow container_t sysctl_t (dir (mounton)))
> (allow container_t sysctl_t (file (mounton)))
> (allow container_t proc_kcore_t (file (mounton)))
> (allow container_t nsfs_t (file (getattr read open)))
> (allow container_t var_run_t (file (create read write open unlink)))
> (allow container_t sysfs_t (dir (mounton)))
> (allow container_t kernel_t (unix_stream_socket (read write)))
> (allow init_t kernel_t (unix_stream_socket (read write)))
> (allow container_t init_t (unix_stream_socket (read write)))
> -----------------------------------------------
>
> I'll also post this result on our community blog.
>
> Kind Regards,
>
> OMO
>
> 2017-01-19 23:06 GMT+09:00 Daniel J Walsh <dwalsh@redhat.com>:
>> You are not testing with SELinux if it can read /etc/shadow.  The
>> process should be running as container_t or svirt_lxc_net_t if it is an
>> older version.
>>
>>
>> We currently label runc as container_runtime_exec_t.
>>
>> dnf reinstall container-selinux
>>
>> ls -lZ /usr/sbin/runc
>>
>>
>>
>> On 01/19/2017 02:56 AM, 面和毅 wrote:
>>> Dear Sir,
>>>
>>> Thanks. I was checking can we cat /etc/shadow in my testing environment.
>>> It seems that is protected because that file's permission is set to "000".
>>>
>>> Here is my test result;
>>> --------------------------------------------------------------
>>> ----------. 1 root root system_u:object_r:shadow_t:s0
>>> 1268 Oct 13 07:55 /etc/shadow
>>>
>>> SELinux Enforcing  -> Permission Denied
>>> SELinux Permissive -> Permission Denied
>>> SELinux Disabled -> Permission Denied
>>>
>>> When I changed that permission to "755";
>>>
>>> SELinux Enforcing  -> Could cat /etc/shadow
>>> SELinux Permissive -> Could cat /etc/shadow
>>> SELinux Disabled -> Could cat /etc/shadow
>>>
>>> Then in this case that escaped user could
>>> have read access to shadow_t label.
>>> --------------------------------------------------------------
>>>
>>> That "runc" process seems to be working as unconfined_t domain;
>>>
>>> [root@fedora25 ~]# ps axZ|grep runc
>>> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 1578 pts/0 Sl+
>>> 0:00 runc run ctr
>>>
>>> So, I'm not sure but I guess we would better to assign
>>> other domain to "runc" program (no unconfined_t).
>>>
>>> Let me check if we will run "runc" in other domain.
>>>
>>> Kind Regards,
>>>
>>> OMO
>>>
>>> 2017-01-18 23:14 GMT+09:00 Daniel J Walsh <dwalsh@redhat.com>:
>>>>
>>>> On 01/18/2017 12:05 AM, 面和毅 wrote:
>>>>> Dear Sir,
>>>>>
>>>>> I'm member of Japan-SOSS SIG(Secure OSS Special
>>>>> Interest Group).
>>>>> We love SELinux(12years user) and we are promoting SELinux in Japan.
>>>>>
>>>>> >From technical interesting(we are promoting Docker
>>>>> with SELinux), we did PoC for CVE-2016-9962 on Fedora25.
>>>>>
>>>>> Then we found current SELinux(maybe policy) does not
>>>>> mitigate that vulnerability.
>>>>>
>>>>> We could reproduce that vulnerability with
>>>>> - add CAP_SYS_PTRACE to container
>>>>> - modified runc because there’s not so much race window on runc.
>>>>> then we think it's not so easy in usual situation.
>>>>> Also we couldn't reproduce it on CentOS7(latest).
>>>>>
>>>>> We posted that PoC result on our community blog.
>>>>> https://jsosug.github.io/post/omok-selinux-docker-20170118/
>>>>>
>>>>> Also we wish to argue how can we protect this kind of
>>>>> vulnerability by using SELinux.
>>>>>
>>>>> Kind Regards,
>>>>>
>>>>> OMO
>>>> Attempt to cat /etc/shadow in your test to see the blockage.
>>>>
>>>> Here is a blog I wrote on the topic.
>>>>
>>>> http://rhelblog.redhat.com/2017/01/13/selinux-mitigates-container-vulnerability/
>>>>
>>>
>>>
>>
>
>
>
> --
> Kazuki Omo: ka-omo@sios.com
> OSS &Security Evangelist
> OSS Business Planning Dept.
> CISSP #366942
> Tel: +81364015149



-- 
Kazuki Omo: ka-omo@sios.com
OSS &Security Evangelist
OSS Business Planning Dept.
CISSP #366942
Tel: +81364015149
