Subject: Re: [refpolicy] policy not compiling
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Johan Fischer <jfischer@cmcrc.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <4371594D.4010508@cmcrc.com>
References: <4371594D.4010508@cmcrc.com>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 09:39:32 -0500
Message-Id: <1131547172.24234.69.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-09 at 13:05 +1100, Johan Fischer wrote:
> Sorry for the trouble again....
> I'm trying to install the refpolicy (tried the cvs HEAD and
> refpolicy-20051019) but even with the patch applied earlier, the policy
> doesn't compile....

CVS HEAD may not compile in all configurations as we are working to get
the policy ready to be used as the targeted policy in rawhide.  We
haven't been testing other configurations.  Once the policy is in
rawhide, we'll fix the policy for other configurations.  However:

> Here's the output of make:
> ----------------------------
[cut]
> cat policy/modules/services/apache.te policy/modules/services/apm.te
> policy/modules/services/bluetooth.te policy/modules/services/lpd.te >
> tmp/all_te_files.conf

Based on this, it appears that your modules.conf has problems, since
only apache, apm, bluetooth, and lpd are being used to build the policy,
which won't work.

[cut]
> Compiling refpolicy policy.20
> /usr/bin/checkpolicy -M policy.conf -o policy.20
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> tmp/only_te_rules.conf:28:ERROR 'syntax error' at token
> 'init_daemon_domain' on line 3204:
> init_daemon_domain(httpd_t,httpd_exec_t)

This means the init interfaces didn't expand.  The Makefile does need to
be fixed to use all interfaces, not just enabled modules; however, even
if it had, the policy would still fail to compile, since types would be
missing.

> /usr/bin/checkpolicy:  error(s) encountered while parsing configuration
> make: *** [policy.20] Error 1
> clamp:/etc/selinux/refpolicy/src/policy#

> FYI, I'm using a debian unstable with policycoreutils 1.26.
> even if I changed the distro to debian, it doesn't help...

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
