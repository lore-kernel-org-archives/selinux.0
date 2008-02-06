Subject: Re: Why am I not transitioning correctly?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1202328961.2801.354.camel@bluejay.goodinassociates.com>
References: <1202328961.2801.354.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Wed, 06 Feb 2008 15:21:48 -0500
Message-Id: <1202329308.27371.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-06 at 14:16 -0600, Jeremiah Jahn wrote:
> I get this error in the audit log:
> type=SELINUX_ERR msg=audit(1202327606.098:732): security_compute_sid:  invalid context system_u:system_r:monetra_t:s0 for scontext=system_u:system_r:initrc_t:s0 tcontext=system_u:object_r:monetra_server_exec_t:s0 tclass=process
> type=SYSCALL msg=audit(1202327606.098:732): arch=40000003 syscall=11 success=no exit=-13 a0=9d9f650 a1=9d9f5d8 a2=9d8c728 a3=9d9ff20 items=0 ppid=2575 pid=2593 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) comm="S99monetra" ex
> e="/bin/bash" subj=system_u:system_r:initrc_t:s0 key=(null)

Missing role system_r types monetra_t; statement.

> I was under the assumption that the following would work:
> allow initrc_t monetra_server_exec_t:file { read execute getattr};
> allow monetra_t monetra_server_exec_t:file { entrypoint };
> type_transition initrc_t monetra_server_exec_t:process monetra_t;

Also need:
allow initrc_t monetra_t:process transition;

But why not just use policy interfaces to do that?

> I can't do init_daemon_domain(monetra_t,monetra_server_exec_t) because I
> can't let sysadm_t read anything involving monetra_t. And I'd thought
> I'd read in "selinux by example" that
> domain_auto_trans(initrc_t,monetra_server_exec_t,monetra_t) is generally
> a bad idea.

Why?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
