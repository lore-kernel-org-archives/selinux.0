Subject: Re: allow tomcat_t self:capability 0x80000000; ??
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200610190933.19483.Daniel.Gil-Mayol@brunel.de>
References: <200610190933.19483.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 08:21:18 -0400
Message-Id: <1161260478.14632.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-19 at 09:33 +0200, Daniel Gil Mayol wrote:
> Hello, I'm trying to write a policy for Tomcat using RedHat Enterprise 4.
> I receive the next message:
> 
> Oct 19 09:04:36 cnsu kernel: audit(1161248676.103:4605): avc:  denied  
> { 0x80000000 } for  pid=1223 comm="java" capability=31 
> scontext=root:system_r:tomcat_t tcontext=root:system_r:tomcat_t 
> tclass=capability

Capability 31 isn't defined, so this indicates a kernel bug.
If SELinux cannot map the capability to a defined permission, it just
displays the value rather than a string name to at least provide some
information.

Start auditd and then reproduce the denial while it is running.
Then run:
	/sbin/ausearch -i -c java
and post the result.

Also, please identify your precise kernel (uname -r).

> Using the audit2allow tool, I become the next allow to add: "allow tomcat_t 
> self:capability 0x80000000;" but this don't works, after the compiler shows 
> the following error:
> 
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> domains/xxx/tomcat.te:117:ERROR 'syntax error' at token '0' on line 39415:
> allow tomcat_t self:capability 0x80000000;
> 
> Somebody can help me to understand what I'm doing wrong?

The above won't work because that isn't a defined permission.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
