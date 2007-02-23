Subject: Re: init_t and sshd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1172252188.10636.9.camel@localhost>
References: <1172252188.10636.9.camel@localhost>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 12:43:58 -0500
Message-Id: <1172252638.19041.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-02-23 at 18:36 +0100, Vincenzo Ciaglia wrote:
> Hello, once i solved every problems related to SELinux installation from
> scratch i started working on policies for Netwosix.
> 
> Here the problem:
> 
> vciaglia@vciaglia-desktop:~$ ssh -l vciaglia 192.168.0.4
> vciaglia@192.168.0.4's password:
> Read from remote host 192.168.0.4: Connection reset by peer
> Connection to 192.168.0.4 closed.
> 
> In few words i can ssh into my machine only as "root" when i'm in
> enforcing mode. So i took a look to the avc denials and audit2allow says
> me to add this line to my "init.te":
> 
> allow init_t shadow_t:file { getattr read };

sshd should be running in sshd_t, not init_t, so this indicates a
problem with getting sshd into the right domain.  Run 'sestatus -v'.
BTW, when you built your policy, what build.conf settings did you use?

> So i tried to add the line and rebuild the policy but i get this result:
> 
> grep ^portcon tmp/policy.conf.tmp >> policy.conf || true
> grep ^netifcon tmp/policy.conf.tmp >> policy.conf || true
> grep ^nodecon tmp/policy.conf.tmp >> policy.conf || true
> Compiling netwosix policy.21
> /usr/bin/checkpolicy policy.conf -o policy.21
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> libsepol.check_assertion_helper: assertion on line 147384 violated by
> allow init_t shadow_t:file { read };
> libsepol.check_assertions: 1 assertion violations occured
> Error while expanding policy
> make: *** [policy.21] Error 1
> 
> I have read that this means that my init.te file includes a rule that
> allows sshd, in this case, to read my /etc/shadow file, and this
> violates an assertion in the base policy.
> 
> How can i solve the problem?

In this case, by getting sshd into the right domain.  More generally, if
it was in the right domain and you needed to allow this, you would need
to add a typeattribute to that domain so that the existing neverallow
rule would not be violated, typically via a refpolicy interface.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
