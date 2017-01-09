Subject: SELinux lead to soft lockup when pid 1 proceess reap child
References: <58732BCF.4090908@huawei.com> <58734284.1060504@huawei.com>
 <b7f75f65-592a-5102-0ac5-4d3aa43f0b55@huawei.com>
CC: Kefeng Wang <wangkefeng.wang@huawei.com>, "Guohanjun (Hanjun Guo)"
 <guohanjun@huawei.com>, "'Qiang Huang'" <h.huangqiang@huawei.com>, Lizefan
 <lizefan@huawei.com>, "miaoxie (A)" <miaoxie@huawei.com>, Zhangdianfang
 <zhangdianfang@huawei.com>, <paul@paul-moore.com>,
 <sds@tycho.nsa.gov>, <eparis@parisplace.org>,
 <james.l.morris@oracle.com>, <oleg@redhat.com>,
 <ebiederm@xmission.com>, <serge.hallyn@ubuntu.com>
From: yangshukui <yangshukui@huawei.com>
To: <selinux@tycho.nsa.gov>, <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Message-ID: <58736B2E.90201@huawei.com>
Date: Mon, 9 Jan 2017 18:51:26 +0800
MIME-Version: 1.0
In-Reply-To: <b7f75f65-592a-5102-0ac5-4d3aa43f0b55@huawei.com>
Content-Type: multipart/alternative;
 boundary="------------000706030006000204030303"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--------------000706030006000204030303
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Pid 1 process (with init_t)  have the right to reap child in host, but 
pid 1 process (such as spc_t, docker use spc_t as container's default type)
may not have the right to reap child in container, if this condition 
occur, it will lead to soft lock up. The following will produce it,

docker run -ti --rm -v /sys/fs/selinux:/sys/fs/selinux fedora:20 bash
[root@b755018fb526 /]# yum install selinux-policy-targeted 
selinux-policy-devel perl-Test-Harness gcc libselinux-devel net-tools 
netlabel_tools iptables git cpan
[root@b755018fb526 /]# git clone 
https://github.com/SELinuxProject/selinux-testsuite.git
[root@b755018fb526 /]# setenforce 0
[root@b755018fb526 /]# runcon -t unconfined_t bash
[root@b755018fb526 /]# genhomedircon
[root@b755018fb526 /]# restorecon -R /
[root@b755018fb526 /]# setenforce 1
[root@b755018fb526 /]# cd /root/selinux-testsuite/
[root@b755018fb526 selinux-testsuite]# make -C policy load
[root@b755018fb526 selinux-testsuite]# make -C tests test
[root@b755018fb526 selinux-testsuite]# exit  #this will lead to soft lockup

before exiting the container, we can also see some zombies：
[root@b755018fb526 selinux-testsuite]# ps -eafZ
LABEL                           UID        PID  PPID  C STIME 
TTY          TIME CMD
...
unconfined_u:unconfined_r:test_fdreceive_server_t:s0 root 215 1  0 05:35 
pts/0 00:00:00 [server] <defunct>
unconfined_u:unconfined_r:test_ptrace_traced_t:s0 root 291 1  0 05:35 
pts/0 00:00:00 [wait] <defunct>
unconfined_u:unconfined_r:test_setnice_set_t:s0 root 374 1  0 05:35 
pts/0 00:00:00 [child] <defunct>

in kernel code,
zap_pid_ns_processes {
       ...
       /* Firstly reap the EXIT_ZOMBIE children we may have. */
       do {
           clear_thread_flag(TIF_SIGPENDING);
           rc = sys_wait4(-1, NULL, __WALL, NULL);
           //sys_wait4 -> do_wait-> 
wait_consider_task->security_task_wait->selinux_task_wait->avc_has_perm_flags->avc_has_perm_noaudit->avc_denied
the return value is -EACCES, unable to return to the expected -ECHILD, 
and leading to the dead cycle.
     } while (rc != -ECHILD);
}

I have a hack like this,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 57a2020..c10c58c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3596,6 +3596,9 @@ static int selinux_task_kill(struct task_struct 
*p, struct siginfo *info,

  static int selinux_task_wait(struct task_struct *p)
  {
+       if (pid_vnr(task_tgid(current)) == 1){
+                return 0;
+       }
         return task_has_perm(p, current, PROCESS__SIGCHLD);
  }
It work but it permit pid 1 process to reap child without selinux check. 
Can we have a better way to handle this problem?

--------------000706030006000204030303
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Pid 1 process (with init_t)  have the right to reap child in host,
    but pid 1 process (such as spc_t, docker use spc_t as container's
    default type)
    <br>
    may not have the right to reap child in container, if this condition
    occur, it will lead to soft lock up. The following will produce it,<br>
    <br>
    docker run -ti --rm -v /sys/fs/selinux:/sys/fs/selinux fedora:20
    bash
    <br>
    [root@b755018fb526 /]# yum install selinux-policy-targeted
    selinux-policy-devel perl-Test-Harness gcc libselinux-devel
    net-tools netlabel_tools iptables git cpan
    <br>
    [root@b755018fb526 /]# git clone <a class="moz-txt-link-freetext"
      href="https://github.com/SELinuxProject/selinux-testsuite.git">https://github.com/SELinuxProject/selinux-testsuite.git</a>
    <br>
    [root@b755018fb526 /]# setenforce 0
    <br>
    [root@b755018fb526 /]# runcon -t unconfined_t bash
    <br>
    [root@b755018fb526 /]# genhomedircon
    <br>
    [root@b755018fb526 /]# restorecon -R /
    <br>
    [root@b755018fb526 /]# setenforce 1
    <br>
    [root@b755018fb526 /]# cd <i class="moz-txt-slash"><span
        class="moz-txt-tag">/</span>root/selinux-testsuite<span
        class="moz-txt-tag">/</span></i>
    <br>
    [root@b755018fb526 selinux-testsuite]# make -C policy load
    <br>
    [root@b755018fb526 selinux-testsuite]# make -C tests test
    <br>
    [root@b755018fb526 selinux-testsuite]# exit  #this will lead to soft
    lockup
    <br>
    <br>
    before exiting the container, we can also see some zombies：
    <br>
    [root@b755018fb526 selinux-testsuite]# ps -eafZ
    <br>
    LABEL                           UID        PID  PPID  C STIME
    TTY          TIME CMD
    <br>
    ...
    <br>
    unconfined_u:unconfined_r:test_fdreceive_server_t:s0 root 215 1  0
    05:35 pts/0 00:00:00 [server] &lt;defunct&gt;
    <br>
    unconfined_u:unconfined_r:test_ptrace_traced_t:s0 root 291 1  0
    05:35 pts/0 00:00:00 [wait] &lt;defunct&gt;
    <br>
    unconfined_u:unconfined_r:test_setnice_set_t:s0 root 374 1  0 05:35
    pts/0 00:00:00 [child] &lt;defunct&gt;
    <br>
    <br>
    in kernel code,
    <br>
    zap_pid_ns_processes {
    <br>
          ...
    <br>
          /* Firstly reap the EXIT_ZOMBIE children we may have. */
    <br>
          do {
    <br>
              clear_thread_flag(TIF_SIGPENDING);
    <br>
              rc = sys_wait4(-1, NULL, __WALL, NULL);
    <br>
              //sys_wait4 -&gt; do_wait-&gt;
wait_consider_task-&gt;security_task_wait-&gt;selinux_task_wait-&gt;avc_has_perm_flags-&gt;avc_has_perm_noaudit-&gt;avc_denied<br>
    the return value is -EACCES, unable to return to the expected
    -ECHILD, and leading to the dead cycle.<br>
        } while (rc != -ECHILD);
    <br>
    }
    <br>
    <br>
    I have a hack like this,
    <br>
    diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
    <br>
    index 57a2020..c10c58c 100644
    <br>
    --- a/security/selinux/hooks.c
    <br>
    +++ b/security/selinux/hooks.c
    <br>
    @@ -3596,6 +3596,9 @@ static int selinux_task_kill(struct
    task_struct *p, struct siginfo *info,
    <br>
    <br>
     static int selinux_task_wait(struct task_struct *p)
    <br>
     {
    <br>
    +       if (pid_vnr(task_tgid(current)) == 1){
    <br>
    +                return 0;
    <br>
    +       }
    <br>
            return task_has_perm(p, current, PROCESS__SIGCHLD);
    <br>
     }
    <br>
    It work but it permit pid 1 process to reap child without selinux
    check. Can we have a better way to handle this problem?
  </body>
</html>

--------------000706030006000204030303--
