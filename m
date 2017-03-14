Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2E3OZSa021037
 for <selinux@tycho.nsa.gov>; Mon, 13 Mar 2017 23:24:35 -0400
Received: by mail-io0-f177.google.com with SMTP id l7so96650381ioe.3
 for <selinux@tycho.nsa.gov>; Mon, 13 Mar 2017 20:24:33 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?6Z2i5ZKM5q+F?= <ka-omo@sios.com>
Date: Tue, 14 Mar 2017 12:24:32 +0900
Message-ID: <CAEKGoSGVccL=jEOOfGcKAdgHE+cUk5XC2Z01nt_jtke6MdjVXw@mail.gmail.com>
Subject: tomcat_t domain behavior
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi list,

I just found strange behavior on tomcat_t.
(I checked Fedora25, CentOS7).

During PoC for CVE-2017-5638(I know RedHat products are
not affected, just wanted to confirm SELinux behavior),
I found that tomcat_t can read shadow_t file, access to
admin_home_t directory, and so on.

I guess there is a suitable reason to allow those permission
to tomcat_t, but I just want to confirm the reason.

----- Quick test for tomcat_t -----;
I did just temporary test for checking tomcat_t behavior
on Fedora25.

1. I copied /bin/bash to /root/tomcat_shell.sh, and assigned
   context as "tomcat_exec_t".

[root@fedora25 ~]# ls -lZ /root/tomcat_shell.sh
-rwxr-xr-x. 1 root root system_u:object_r:tomcat_exec_t:s0
1072008 Mar 14 11:53 /root/tomcat_shell.sh

2. I added some cil policy just for this test.
[root@fedora25 ~]# cat tomcat_sh.cil
(typeattributeset entry_type tomcat_exec_t)
(roletype unconfined_r tomcat_t)
(typetransition unconfined_t tomcat_exec_t process tomcat_t)

3. load above module, and run tomcat_shell.sh
[root@fedora25 ~]# semodule -i tomcat_sh.cil
[root@fedora25 ~]# ./tomcat_shell.sh
[root@fedora25 ~]# id -Z
unconfined_u:unconfined_r:tomcat_t:s0-s0:c0.c1023

4. access to shadow file, /root/ file, etc.
[root@fedora25 ~]# cat /etc/shadow
root:$6$h0wd.::0:99999:7:::
bin:*:17004:0:99999:7:::
daemon:*:17004:0:99999:7:::
--snip--
[root@fedora25 ~]# cat /root/tomcat_sh.cil
(typeattributeset entry_type tomcat_exec_t)
(roletype unconfined_r tomcat_t)
(typetransition unconfined_t tomcat_exec_t process tomcat_t)
[root@fedora25 ~]# ls -lZ /root/tomcat_sh.cil
-rw-r--r--. 1 root root unconfined_u:object_r:admin_home_t:s0
138 Mar 14 12:01 /root/tomcat_sh.cil
----- End -----

So, can I ask the reason why we add these permission to tomcat_t?

Kind Regards,

OMO


-- 
Kazuki Omo: ka-omo@sios.com
OSS &Security Evangelist
OSS Business Planning Dept.
CISSP #366942
http://www.secureoss.jp/
Tel: +819026581386
