Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v59Bu5iE013478
 for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2017 07:56:09 -0400
Received: by mail-it0-f43.google.com with SMTP id m47so136161141iti.1
 for <selinux@tycho.nsa.gov>; Fri, 09 Jun 2017 04:56:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEKGoSGousUBYNoii5DCXDxDHT7Thx=gkgfh-SVt_fN5G72-3A@mail.gmail.com>
References: <CAEKGoSGVccL=jEOOfGcKAdgHE+cUk5XC2Z01nt_jtke6MdjVXw@mail.gmail.com>
 <20170314103951.GA2914@workstation1.local.opinurate.com>
 <cb833c76-f48a-6fa9-9cef-db541def300b@redhat.com>
 <CAEKGoSFUz1uean6F6KAYN_QPL+X-2aRja2KEbaw1Otmk82NqOA@mail.gmail.com>
 <CAEKGoSGousUBYNoii5DCXDxDHT7Thx=gkgfh-SVt_fN5G72-3A@mail.gmail.com>
From: =?UTF-8?B?6Z2i5ZKM5q+F?= <ka-omo@sios.com>
Date: Fri, 9 Jun 2017 20:56:04 +0900
Message-ID: <CAEKGoSHeJsPL0XQ5YRK5QSOr-Qvb+8d+Q6xCM=wy06c634Zmjw@mail.gmail.com>
Subject: Re: tomcat_t domain behavior
To: Lukas Vrabec <lvrabec@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

It seems the bug is fixed on selinux-policy-3.13.1-145.el7.noarch.rpm. :-)

So I uploaded new article on our blog.
"CVE-2017-5638(Struts2) PoC with SELinux"
Now we can say SELinux can mitigate the Struts2(CVE-2017-5638)
if the policy is latest(3.13.1-145).

http://www.secureoss.jp/post/omok-selinux-struts2-20170607/

Kind Regards,

OMO

2017-03-14 22:42 GMT+09:00 面和毅 <ka-omo@sios.com>:
> Dear Lukas,
>
> Thanks. I also submitted this issue on bugzilla for RHEL7.
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1432083
>
> Kind Regards,
>
> OMO
>
> 2017-03-14 21:35 GMT+09:00 面和毅 <ka-omo@sios.com>:
>> Dear Gary, Lukas,
>>
>> Many Thanks.
>>
>> I just submitted this issue on bugzilla for Fedora.
>> https://bugzilla.redhat.com/show_bug.cgi?id=1432055
>>
>> After I install RHEL7.3(because I tested it on CentOS7), I'll submit
>> it on RHEL also.
>>
>> Kind Regards,
>>
>> OMO
>>
>> 2017-03-14 20:20 GMT+09:00 Lukas Vrabec <lvrabec@redhat.com>:
>>> On 03/14/2017 11:39 AM, Gary Tierney wrote:
>>>>
>>>> On Tue, Mar 14, 2017 at 12:24:32PM +0900, 面和毅 wrote:
>>>>>
>>>>> Hi list,
>>>>>
>>>>> I just found strange behavior on tomcat_t.
>>>>> (I checked Fedora25, CentOS7).
>>>>>
>>>>> During PoC for CVE-2017-5638(I know RedHat products are
>>>>> not affected, just wanted to confirm SELinux behavior),
>>>>> I found that tomcat_t can read shadow_t file, access to
>>>>> admin_home_t directory, and so on.
>>>>>
>>>>> I guess there is a suitable reason to allow those permission
>>>>> to tomcat_t, but I just want to confirm the reason.
>>>>>
>>>>> ----- Quick test for tomcat_t -----;
>>>>> I did just temporary test for checking tomcat_t behavior
>>>>> on Fedora25.
>>>>>
>>>>> 1. I copied /bin/bash to /root/tomcat_shell.sh, and assigned
>>>>>    context as "tomcat_exec_t".
>>>>>
>>>>> [root@fedora25 ~]# ls -lZ /root/tomcat_shell.sh
>>>>> -rwxr-xr-x. 1 root root system_u:object_r:tomcat_exec_t:s0
>>>>> 1072008 Mar 14 11:53 /root/tomcat_shell.sh
>>>>>
>>>>> 2. I added some cil policy just for this test.
>>>>> [root@fedora25 ~]# cat tomcat_sh.cil
>>>>> (typeattributeset entry_type tomcat_exec_t)
>>>>> (roletype unconfined_r tomcat_t)
>>>>> (typetransition unconfined_t tomcat_exec_t process tomcat_t)
>>>>>
>>>>> 3. load above module, and run tomcat_shell.sh
>>>>> [root@fedora25 ~]# semodule -i tomcat_sh.cil
>>>>> [root@fedora25 ~]# ./tomcat_shell.sh
>>>>> [root@fedora25 ~]# id -Z
>>>>> unconfined_u:unconfined_r:tomcat_t:s0-s0:c0.c1023
>>>>>
>>>>> 4. access to shadow file, /root/ file, etc.
>>>>> [root@fedora25 ~]# cat /etc/shadow
>>>>> root:$6$h0wd.::0:99999:7:::
>>>>> bin:*:17004:0:99999:7:::
>>>>> daemon:*:17004:0:99999:7:::
>>>>> --snip--
>>>>> [root@fedora25 ~]# cat /root/tomcat_sh.cil
>>>>> (typeattributeset entry_type tomcat_exec_t)
>>>>> (roletype unconfined_r tomcat_t)
>>>>> (typetransition unconfined_t tomcat_exec_t process tomcat_t)
>>>>> [root@fedora25 ~]# ls -lZ /root/tomcat_sh.cil
>>>>> -rw-r--r--. 1 root root unconfined_u:object_r:admin_home_t:s0
>>>>> 138 Mar 14 12:01 /root/tomcat_sh.cil
>>>>> ----- End -----
>>>>>
>>>>> So, can I ask the reason why we add these permission to tomcat_t?
>>>>
>>>>
>>>
>>> There is no reason to have tomcat_t domain in uconfined_domain.
>>>
>>>
>>>> These permissions aren't directly added to tomcat, they come from tomcat
>>>> being an unconfined domain:
>>>>
>>>> https://github.com/fedora-selinux/selinux-policy-contrib/blob/f25/tomcat.te#L21
>>>>
>>>> $ sesearch -ACS -s tomcat_t -t shadow_t -c file -p read
>>>> Found 1 semantic av rules:
>>>>    allow files_unconfined_type file_type : file { ioctl read write create
>>>> getattr setattr lock relabelfrom relabelto append unlink link rename execute
>>>> swapon quotaon mounton execute_no_trans open audit_access } ;
>>>>
>>>> $ seinfo -ttomcat_t -x
>>>>    tomcat_t
>>>>       can_read_shadow_passwords
>>>>       can_write_shadow_passwords
>>>>       can_relabelto_shadow_passwords
>>>>       can_change_object_identity
>>>>       can_load_kernmodule
>>>>       can_load_policy
>>>>       can_setbool
>>>>       can_setenforce
>>>>       corenet_unconfined_type
>>>>       corenet_unlabeled_type
>>>>       devices_unconfined_type
>>>>       domain
>>>>       files_unconfined_type
>>>>       filesystem_unconfined_type
>>>>       kern_unconfined
>>>>       kernel_system_state_reader
>>>>       process_uncond_exempt
>>>>       selinux_unconfined_type
>>>>       storage_unconfined_type
>>>>       unconfined_domain_type
>>>>       dbusd_unconfined
>>>>       daemon
>>>>       syslog_client_type
>>>>       sepgsql_unconfined_type
>>>>       tomcat_domain
>>>>       userdom_filetrans_type
>>>>       x_domain
>>>>       xserver_unconfined_type
>>>>
>>>> I don't see why Tomcat would need to be an unconfined domain, though.
>>>>
>>>
>>> tomcat_t is in unconfined_domain_type attribute in Fedora 25 and Centos7.
>>> This looks like bug when tomcat policy was written.
>>>
>>> Could you please submit bug for Fedora and also RHEL? It should be fixed.
>>>
>>> Lukas.
>>>
>>>>>
>>>>> Kind Regards,
>>>>>
>>>>> OMO
>>>>>
>>>>>
>>>>> --
>>>>> Kazuki Omo: ka-omo@sios.com
>>>>> OSS &Security Evangelist
>>>>> OSS Business Planning Dept.
>>>>> CISSP #366942
>>>>> http://www.secureoss.jp/
>>>>> Tel: +819026581386
>>>>> _______________________________________________
>>>>> Selinux mailing list
>>>>> Selinux@tycho.nsa.gov
>>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>>> To get help, send an email containing "help" to
>>>>> Selinux-request@tycho.nsa.gov.
>>>>
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Selinux mailing list
>>>> Selinux@tycho.nsa.gov
>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>> To get help, send an email containing "help" to
>>>> Selinux-request@tycho.nsa.gov.
>>>>
>>>
>>>
>>> --
>>> Lukas Vrabec
>>> SELinux Solutions
>>> Red Hat, Inc.
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>>
>>
>>
>> --
>> Kazuki Omo: ka-omo@sios.com
>> OSS &Security Evangelist
>> OSS Business Planning Dept.
>> CISSP #366942
>> Tel: +81364015149
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
