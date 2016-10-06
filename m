Subject: Re: Fuzzing /usr/libexec/selinux/hll/pp with AFL
To: Milos Malik <mmalik@redhat.com>, selinux@tycho.nsa.gov
References: <1722968607.809359.1475757444568.JavaMail.zimbra@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8089f554-5277-0771-5678-b7eaba6933b6@tycho.nsa.gov>
Date: Thu, 6 Oct 2016 09:50:05 -0400
MIME-Version: 1.0
In-Reply-To: <1722968607.809359.1475757444568.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/06/2016 08:37 AM, Milos Malik wrote:
> Hi all,
> 
> inspired by Nicolas Iooss idea of fuzzing with AFL, I found few input files which cause a crash or a hang of hll/pp on RHEL-7.3. Hopefully, I discovered something else than what's already fixed in upstream.
> 
> afl-2.35b
> libselinux-2.5-6.el7.x86_64
> libselinux-devel-2.5-6.el7.x86_64
> libselinux-python-2.5-6.el7.x86_64
> libselinux-utils-2.5-6.el7.x86_64
> libsemanage-2.5-4.el7.x86_64
> libsemanage-devel-2.5-4.el7.x86_64
> libsemanage-python-2.5-4.el7.x86_64
> libsemanage-static-2.5-4.el7.x86_64
> libsepol-2.5-6.el7.x86_64
> libsepol-devel-2.5-6.el7.x86_64
> libsepol-static-2.5-6.el7.x86_64
> policycoreutils-2.5-9.el7.x86_64
> policycoreutils-debuginfo-2.5-9.el7.x86_64
> policycoreutils-devel-2.5-9.el7.x86_64
> policycoreutils-gui-2.5-9.el7.x86_64
> policycoreutils-newrole-2.5-9.el7.x86_64
> policycoreutils-python-2.5-9.el7.x86_64
> policycoreutils-restorecond-2.5-9.el7.x86_64
> policycoreutils-sandbox-2.5-9.el7.x86_64
> selinux-policy-3.13.1-102.el7.noarch
> selinux-policy-devel-3.13.1-102.el7.noarch
> selinux-policy-minimum-3.13.1-102.el7.noarch
> selinux-policy-mls-3.13.1-102.el7.noarch
> selinux-policy-targeted-3.13.1-102.el7.noarch
> 
> # /usr/libexec/selinux/hll/pp crash0 
> Segmentation fault
> # /usr/libexec/selinux/hll/pp crash1
> Segmentation fault
> # dmesg
> [10487.300325] pp[24302]: segfault at 0 ip 00007f5dff4f8a4f sp 00007fffe41e5ba0 error 4 in libsepol.so.1[7f5dff4d0000+95000]
> [10489.509501] pp[24320]: segfault at 0 ip 00007f6067bec544 sp 00007fff17b0e5c0 error 4 in libsepol.so.1[7f6067bdb000+95000]
> #
> 
> I also tested checkmodule and checkpolicy with AFL, but nothing sofar.

I can't reproduce with current upstream / 2.6-rc1 which includes a
number of fixes from William Roberts for bugs found via AFL. See below
for the output I get.  hang0 does take a while to complete, but
eventually does so (but in general we don't presently try to cap various
values from the binary policy modules or kernel policies, so
long-running times aren't surprising or necessarily a bug per se).

$ /usr/libexec/selinux/hll/pp crash0
libsepol.sepol_module_package_read: invalid module in module package (at
section 0)
Failed to read policy package

$ /usr/libexec/selinux/hll/pp crash1
libsepol.sepol_module_package_read: invalid module in module package (at
section 0)
Failed to read policy package

$ time /usr/libexec/selinux/hll/pp hang0
(type jetty_cache_t)
(roletype object_r jetty_cache_t)
(type jetty_log_t)
(roletype object_r jetty_log_t)
(type jetty_var_lib_t)
(roletype object_r jetty_var_lib_t)
(type jetty_var_run_t)
(roletype object_r jetty_var_run_t)
(roleattributeset cil_gen_require system_r)
(typeattributeset cil_gen_require file_type)
(typeattributeset file_type (jetty_cache_t jetty_log_t jetty_var_lib_t
jetty_var_run_t ))
(typeattributeset cil_gen_require non_security_file_type)
(typeattributeset non_security_file_type (jetty_cache_t jetty_log_t
jetty_var_lib_t jetty_var_run_t ))
(typeattributeset cil_gen_require non_auth_file_type)
(typeattributeset non_auth_file_type (jetty_cache_t jetty_log_t
jetty_var_lib_t jetty_var_run_t ))
(typeattributeset cil_gen_require logfile)
(typeattributeset logfile (jetty_log_t ))
(typeattributeset cil_gen_require tmp_t)
(typeattributeset cil_gen_require tmpfs_t)
(typeattributeset cil_gen_require pidfile)
(typeattributeset pidfile (jetty_var_run_t ))
(allow jetty_log_t tmp_t (filesystem (associate)))
(allow jetty_log_t tmpfs_t (filesystem (associate)))
Invalid file context line: /var/c

real	0m11.526s
user	0m11.523s
sys	0m0.001s
