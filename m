Subject: Re: Policy tests failed
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Gil Mayol <daniel.gil-mayol@brunel.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4549C1E0.6020401@brunel.de>
References: <4549C1E0.6020401@brunel.de>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 08:50:40 -0500
Message-Id: <1162475440.22051.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-02 at 11:01 +0100, Daniel Gil Mayol wrote:
> Hello, I still have some problems with the policy tests.
> 
> I am testing that a domain can execute files that are defined in the 
> policy. For example, lets take tripwire. In the policy is defined that:
> 
>     can_exec($1_t, shell_exec_t);
>     can_exec($1_t, bin_t);
> 
> That means that tripwire_t domain is allowed to execute files labeled 
> with shell_exec_t and bin_t.
> 
> The test first relabel as shell_exec_t a copy that I made previously of 
> /bin/ls (this copy is under my test directory):
> 
>     [root@cnsu PolicyTest]# chcon -u system_u -r object_r -t shell_exec_t ls
> 
> Then I try to execute ls (under the domain tripwire_t) over a file 
> called '/policytest' defined as:
> 
>     -rw-r--r--  root     root     system_u:object_r:policy_test_t 
>     policytest
> 
> where policy_test_t is:
> 
>     type policy_test_t, file_type;
>     allow * policy_test_t:file getattr;
> 
> But this execution fail:
> 
>     [root@cnsu PolicyTest]# runcon -t tripwire_t ./ls /policytest
>     execvp: Permission denied
> 
> The /var/log/messages shows this:
> 
> Nov  2 11:06:46 cnsu kernel: audit(1162465606.392:25664): avc:  denied  
> { entrypoint } for  pid=27705 comm="runcon" name="ls" dev=hda2 
> ino=240308 scontext=root:system_r:tripwire_t 
> tcontext=system_u:object_r:shell_exec_t tclass=file
> 
> The question is... should I define for all the services this file 
> entrypoint or I am doing something wrong in my test?
> I would like to avoid to write all these entrypoints.

SELinux distinguishes between an executable that can be used to enter a
given domain (entrypoint) and an executable that can be subsequently
executed by that domain.  can_exec() only gives permissions for the
latter.  domain_trans() and domain_auto_trans() gives permissions for a
domain transition, including the entrypoint permission between the new
domain and the executable.  Example:
	domain_trans(unconfined_t, shell_exec_t, $1_t)
	domain_trans(unconfined_t, bin_t, $1_t)

Reference policy splits the entrypoint permission into a separate
macro/interface, domain_entry_file(), but that wouldn't exist in your
base policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
