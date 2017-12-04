To: james.l.morris@oracle.com
Cc: bot+015afdb01dbf2abb6a6bfdd5430b72e5503fca6d@syzkaller.appspotmail.com,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 syzkaller-bugs@googlegroups.com, danielj@mellanox.com,
 dledford@redhat.com, eparis@parisplace.org, junil0814.lee@lge.com,
 kyeongdon.kim@lge.com, linux-kernel@vger.kernel.org, mka@chromium.org,
 paul@paul-moore.com, sds@tycho.nsa.gov, serge@hallyn.com
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <001a113f711a721c58055f052200@google.com>
 <089e08259d282c063e055f4bddbd@google.com>
 <97d6bab0-d278-9945-5d82-a0a76b8b78c5@I-love.SAKURA.ne.jp>
 <201712032227.JCH90603.HQOOtVFMJOFLSF@I-love.SAKURA.ne.jp>
 <alpine.LFD.2.20.1712041150270.1348@localhost>
In-Reply-To: <alpine.LFD.2.20.1712041150270.1348@localhost>
Message-Id: <201712041944.HAI56745.HOFQFtJSOVMOFL@I-love.SAKURA.ne.jp>
Date: Mon, 4 Dec 2017 19:44:54 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: KASAN: slab-out-of-bounds Read in strcmp
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

James Morris wrote:
> On Sun, 3 Dec 2017, Tetsuo Handa wrote:
> 
> > Tetsuo Handa wrote:
> > > which will allow strcmp() to trigger out of bound read when "size" is
> > > larger than strlen(initial_sid_to_string[i]).
> > 
> > Oops. "smaller" than.
> > 
> > > 
> > > Thus, I guess the simplest fix is to use strncmp() instead of strcmp().
> > 
> > Can somebody test below patch? (My CentOS 7 environment does not support
> > enabling SELinux in linux.git . Userspace tool is too old to support?)
> 
> You mean enabling KASAN?  Yep, you need gcc 4.9.2 or better.  Recent 
> Fedora has it.

I was not able to find "SELinux:  Initializing." line for some reason, and
it turned out that I just forgot to run "make install". ;-)

I tested using debug printk() and init for built-in initramfs shown below.
It is strange that KASAN does not trigger upon strcmp()ing
initial_sid_to_string[1]. But anyway, my patch fixes this problem.

----------
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5973,6 +5973,7 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
                                     PROCESS__SETCURRENT, NULL);
        else
                error = -EINVAL;
+       printk("setprocattr %s=%d size=%lu\n", name, error, size);
        if (error)
                return error;

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 33cfe5d..fbf0ade 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1417,6 +1417,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
                int i;

                for (i = 1; i < SECINITSID_NUM; i++) {
+                       printk("Comparing with %s\n", initial_sid_to_string[i]);
                        if (!strcmp(initial_sid_to_string[i], scontext)) {
                                *sid = i;
                                return 0;
----------

----------
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mount.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
        int fd;
        mount("/proc", "/proc", "proc", 0, NULL);
        fd = open("/proc/self/attr/current", O_WRONLY);
        write(fd, "n", 1);
        close(fd);
        return 0;
}
----------

----------
[    7.894061] Write protecting the kernel read-only data: 71680k
[    7.899889] Freeing unused kernel memory: 1744K
[    7.923592] Freeing unused kernel memory: 1832K
[    7.926960] setprocattr current=0 size=1
[    7.928253] Comparing with kernel
[    7.929350] Comparing with security
[    7.930457] Comparing with unlabeled
[    7.931581] Comparing with fs
[    7.932538] Comparing with file
[    7.933537] Comparing with file_labels
[    7.934720] Comparing with init
[    7.935719] Comparing with any_socket
[    7.936866] Comparing with port
[    7.937874] Comparing with netif
[    7.938965] ==================================================================
[    7.941183] BUG: KASAN: slab-out-of-bounds in strcmp+0x96/0xb0
[    7.942957] Read of size 1 at addr ffff8801145a5441 by task init/1
[    7.944832] 
[    7.945349] CPU: 2 PID: 1 Comm: init Not tainted 4.15.0-rc2+ #323
[    7.947177] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/02/2015
[    7.950331] Call Trace:
[    7.951133]  dump_stack+0x12e/0x188
[    7.952222]  ? vprintk_default+0x28/0x30
[    7.953431]  ? strcmp+0x96/0xb0
[    7.954421]  print_address_description+0x73/0x260
[    7.955860]  ? strcmp+0x96/0xb0
[    7.956855]  kasan_report+0x22b/0x340
[    7.957987]  __asan_report_load1_noabort+0x14/0x20
[    7.959460]  strcmp+0x96/0xb0
[    7.960408]  security_context_to_sid_core+0x312/0x450
[    7.961945]  ? string_to_context_struct+0x940/0x940
[    7.963434]  ? vprintk_func+0x5e/0xc0
[    7.964564]  ? printk+0xaa/0xca
[    7.965554]  ? show_regs_print_info+0x65/0x65
[    7.966876]  ? proc_pid_attr_write+0x169/0x280
[    7.968178]  security_context_to_sid+0x32/0x40
[    7.969480]  selinux_setprocattr+0x2e1/0x8f0
[    7.970734]  ? ptrace_parent_sid+0x400/0x400
[    7.972034]  security_setprocattr+0x85/0xc0
[    7.973326]  proc_pid_attr_write+0x1d8/0x280
[    7.974638]  __vfs_write+0x10d/0x610
[    7.975746]  ? comm_write+0x230/0x230
[    7.976903]  ? kernel_read+0x120/0x120
[    7.978064]  ? __might_sleep+0x95/0x190
[    7.979266]  ? rcu_read_lock_sched_held+0xa3/0x120
[    7.980722]  ? rcu_sync_lockdep_assert+0x70/0xb0
[    7.982134]  ? __sb_start_write+0x211/0x2d0
[    7.983413]  vfs_write+0x18d/0x510
[    7.984477]  SyS_write+0xd4/0x1a0
[    7.985518]  ? SyS_read+0x1a0/0x1a0
[    7.986622]  ? trace_hardirqs_on_caller+0x442/0x5c0
[    7.988107]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[    7.989524]  entry_SYSCALL_64_fastpath+0x1f/0x96
[    7.990928] RIP: 0033:0x40f7a0
[    7.991875] RSP: 002b:00007ffe20eb59c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[    7.994144] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000040f7a0
[    7.996262] RDX: 0000000000000001 RSI: 0000000000492b75 RDI: 0000000000000003
[    7.998372] RBP: 00007ffe20eb59a0 R08: 0000000000000000 R09: 0000000000000004
[    8.000498] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe20eb5af8
[    8.002629] R13: 00007ffe20eb5b08 R14: 0000000000000002 R15: 0000000000000000
[    8.004774] 
[    8.005283] Allocated by task 1:
[    8.006283]  save_stack+0x46/0xd0
[    8.007312]  kasan_kmalloc+0xad/0xe0
[    8.008417]  __kmalloc_track_caller+0x192/0x760
[    8.009804]  memdup_user+0x2c/0x80
[    8.010873]  proc_pid_attr_write+0x115/0x280
[    8.012172]  __vfs_write+0x10d/0x610
[    8.013283]  vfs_write+0x18d/0x510
[    8.014336]  SyS_write+0xd4/0x1a0
[    8.015380]  entry_SYSCALL_64_fastpath+0x1f/0x96
[    8.016793] 
[    8.017302] Freed by task 1:
[    8.018211]  save_stack+0x46/0xd0
[    8.019241]  kasan_slab_free+0x71/0xc0
[    8.020389]  kfree+0xca/0x250
[    8.021317]  acpi_ds_create_operand+0x45f/0x664
[    8.022696]  acpi_ds_evaluate_name_path+0x116/0x3b6
[    8.024165]  acpi_ds_exec_end_op+0x291/0xd61
[    8.025469]  acpi_ps_parse_loop+0x1338/0x13ee
[    8.026815]  acpi_ps_parse_aml+0x23a/0x7f4
[    8.028064]  acpi_ps_execute_method+0x4f2/0x55f
[    8.029451]  acpi_ns_evaluate+0x6ba/0x8d3
[    8.030708]  acpi_ut_evaluate_object+0x122/0x3c5
[    8.032108]  acpi_ut_execute_STA+0x84/0x15a
[    8.033390]  acpi_get_object_info+0x431/0x9bd
[    8.034676]  acpi_init_device_object+0xb65/0x15f0
[    8.036040]  acpi_add_single_object+0x119/0x1630
[    8.037384]  acpi_bus_check_add+0x1c7/0x520
[    8.038656]  acpi_ns_walk_namespace+0x1e0/0x346
[    8.040029]  acpi_walk_namespace+0xb5/0xef
[    8.041277]  acpi_bus_scan+0xe0/0xf0
[    8.042376]  acpi_scan_init+0x258/0x5e5
[    8.043578]  acpi_init+0x650/0x6d8
[    8.044654]  do_one_initcall+0x9e/0x2c9
[    8.045843]  kernel_init_freeable+0x476/0x52a
[    8.047165]  kernel_init+0x13/0x172
[    8.048248]  ret_from_fork+0x24/0x30
[    8.049762] 
[    8.050268] The buggy address belongs to the object at ffff8801145a5440
[    8.050268]  which belongs to the cache kmalloc-32 of size 32
[    8.053780] The buggy address is located 1 bytes inside of
[    8.053780]  32-byte region [ffff8801145a5440, ffff8801145a5460)
[    8.057068] The buggy address belongs to the page:
[    8.058525] page:00000000243fc1bc count:1 mapcount:0 mapping:000000008e54372e index:0xffff8801145a5fc1
[    8.061337] flags: 0x2fffc0000000100(slab)
[    8.062619] raw: 02fffc0000000100 ffff8801145a5000 ffff8801145a5fc1 0000000100000020
[    8.064922] raw: ffffea0004516ca0 ffff880119c01240 ffff880119c001c0 0000000000000000
[    8.067232] page dumped because: kasan: bad access detected
[    8.068902] 
[    8.069409] Memory state around the buggy address:
[    8.070849]  ffff8801145a5300: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
[    8.073016]  ffff8801145a5380: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
[    8.075194] >ffff8801145a5400: fb fb fb fb fc fc fc fc 01 fc fc fc fc fc fc fc
[    8.077367]                                            ^
[    8.078977]  ffff8801145a5480: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
[    8.081133]  ffff8801145a5500: 06 fc fc fc fc fc fc fc fb fb fb fb fc fc fc fc
[    8.083293] ==================================================================
[    8.085394] Disabling lock debugging due to kernel taint
[    8.086963] Comparing with netmsg
[    8.088029] Comparing with node
[    8.088992] Comparing with igmp_packet
[    8.090156] Comparing with icmp_socket
[    8.091319] Comparing with tcp_socket
[    8.092447] Comparing with sysctl_modprobe
[    8.093731] Comparing with sysctl
[    8.094805] Comparing with sysctl_fs
[    8.095905] Comparing with sysctl_kernel
[    8.097113] Comparing with sysctl_net
[    8.098188] Comparing with sysctl_net_unix
[    8.099370] Comparing with sysctl_vm
[    8.100449] Comparing with sysctl_dev
[    8.101571] Comparing with kmod
[    8.102525] Comparing with policy
[    8.103550] Comparing with scmp_packet
[    8.105942] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
----------
