MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.00.0911040821370.29216@tundra.namei.org>
References: <20091103163532.28449.1998.stgit@paris.rdu.redhat.com>
	 <alpine.LRH.2.00.0911040821370.29216@tundra.namei.org>
Date: Mon, 9 Nov 2009 17:16:54 -0500
Message-ID: <7e0fb38c0911091416v15250425nc7e98fcc0004871e@mail.gmail.com>
Subject: Re: [PATCH] security: report the module name to security_module_request
From: Eric Paris <eparis@parisplace.org>
To: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Nov 3, 2009 at 4:22 PM, James Morris <jmorris@namei.org> wrote:
> On Tue, 3 Nov 2009, Eric Paris wrote:
>
>> For SELinux to do better filtering in userspace we send the name of the
>> module along with the AVC denial when a program is denied module_request.
>>
>> Example output:
>>
>> type=SYSCALL msg=audit(11/03/2009 10:59:43.510:9) : arch=x86_64 syscall=write success=yes exit=2 a0=3 a1=7fc28c0d56c0 a2=2 a3=7fffca0d7440 items=0 ppid=1727 pid=1729 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=rpc.nfsd exe=/usr/sbin/rpc.nfsd subj=system_u:system_r:nfsd_t:s0 key=(null)
>> type=AVC msg=audit(11/03/2009 10:59:43.510:9) : avc:  denied  { module_request } for  pid=1729 comm=rpc.nfsd kmod="net-pf-10" scontext=system_u:system_r:nfsd_t:s0 tcontext=system_u:system_r:kernel_t:s0 tclass=system
>>
>> Signed-off-by: Eric Paris <eparis@redhat.com>
>
> Needs to be reviewed on the LSM list.. (cc'd)

Probably no comment since SELinux is the only LSM to implement this
hook.  Are we good now?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
