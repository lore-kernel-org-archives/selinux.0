Subject: Re: On Fedora 24 I am seeing something strange with CIL
To: SELinux <selinux@tycho.nsa.gov>, James Carter <jwcart2@tycho.nsa.gov>
References: <56FA96D5.4010806@redhat.com>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <56FAC2BB.1070202@redhat.com>
Date: Tue, 29 Mar 2016 14:00:27 -0400
MIME-Version: 1.0
In-Reply-To: <56FA96D5.4010806@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I investigated this a little further.

If I write a policy file like

===============================================
policy_module(container, 1.0)
gen_require(`
     attribute svirt_sandbox_domain;
')

type foobar_t;
domain_type(foobar_t)
typeattribute foobar_t svirt_sandbox_domain;
===============================================

I get


sesearch -A -s foobar_t  | grep capa
    allow foobar_t foobar_t : capability mknod ;

If I remove the typeattribute line foobar_t no longer has mknod.

I think this is a compiler problem.

On 03/29/2016 10:53 AM, Daniel J Walsh wrote:
> When I compile and install this policy
>
> ---------------------------------------------------------------
> # cat /tmp/container.te
> policy_module(container, 1.0)
>
> virt_sandbox_domain_template(container)
>
> ----------------------------------------------------------------
> I end up with mknod capability.
>
> sesearch -A -s container_t -t container_t  -c capability
> Found 1 semantic av rules:
>    allow container_t container_t : capability mknod ;
>
> But I didn't add mknod to the policy.
>
> grep mknod tmp/container.tmp
>     class capability { chown dac_override dac_read_search fowner 
> fsetid kill setgid setuid setpcap linux_immutable net_bind_service 
> net_broadcast net_admin net_raw ipc_lock ipc_owner sys_module 
> sys_rawio sys_chroot sys_ptrace sys_pacct sys_admin sys_boot sys_nice 
> sys_resource sys_time sys_tty_config mknod lease audit_write 
> audit_control setfcap };
>
> Any ideas?
