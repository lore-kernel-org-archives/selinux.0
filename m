Subject: Re: Policy tests failed
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200610201458.42923.Daniel.Gil-Mayol@brunel.de>
References: <200610191700.20138.Daniel.Gil-Mayol@brunel.de>
	 <1161282600.14632.199.camel@moss-spartans.epoch.ncsc.mil>
	 <200610201458.42923.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 13:40:31 -0400
Message-Id: <1161366031.29755.204.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(no html mail please)

On Fri, 2006-10-20 at 14:58 +0200, Daniel Gil Mayol wrote:
> The version number of the SELinux policy language that I am using to
> create the binary policy is 18 (policy.18).

I meant the policy package version, e.g. rpm -q selinux-policy-targeted
if using the RHEL 4 policy, or whatever you used as your baseline.

> I want that the script makes a transition into a different domain. For
> this reason now I have the script relabel with the type
> "initrc_exec_t" and seems that after execute "runcon -t crond_t" it
> makes a transition to the crond_t domain.

The above description suggests that you have two scripts, say "foo" and
"bar", and you have labeled "foo" with initrc_exec_t so that it
transitions to initrc_t automatically and the "foo" script contains a
line that does "runcon -t crond_t bar", where the "bar" script contains
the actual test code that you want to run in crond_t.  Is that correct?
BTW, in that case, "bar" should be labeled crond_exec_t.

> The script don't execute crond, only prove that being in the crond_t
> domain can not access to data of another domain (for example
> httpd_exec_t).

Ok, but the script itself needs to be run in crond_t then, which means
that it needs to be labeled with crond_exec_t.

> Now the script get into anacron_t (now I am testing with anacron)
> domain using the command "runcon -t anacron_t". The script shows now
> after execute the command "id" the next:
> 
> uid=0(root) gid=0(root)
> groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel)
> context=root:system_r:anacron_t

Ok, so the script is running in anacron_t in that case.  Whatever
anacron_t means in your particular policy.

> I don't have any test scripts but i think rolling back the packages to
> one with a known vulerability would work, but since one goal of a
> hacker is to get a root shell, you could use runcon with a shell
> script to simulate what would happen if a hacker was successfull.
> 
> runcon -t httpd_t /bin/sh
> 
> Of course I can only get this to work in permissive mode. Setting it
> to enforcing kills the shell since it can not access the tty.

There should be a boolean that controls tty access.
Try:
setsebool httpd_tty_comm=1

> Also get an error "execvp: Permission denied" in enforcing.

It needs to be labeled with the entrypoint type for the domain.
Try:
cp /bin/sh myhttpd
chcon -t httpd_exec_t myhttpd
runcon -t httpd_t ./myhttpd

> I thought I must run my policy test script in a enforce mode but I get
> the permission denied error (like the mail says). So, I have to run
> the script in permissive mode and look the 'audit denies' that appears
> in /var/log/messages?

No, you can test in enforcing mode but you have to set up the necessary
preconditions and you may need slightly customized policy to do it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
