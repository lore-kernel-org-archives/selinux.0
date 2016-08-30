Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7UJQepg004793
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 15:26:40 -0400
Date: Tue, 30 Aug 2016 21:26:17 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Paul Bolton <paul.a.bolton@m0noc.net>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux MLS Policies
Message-ID: <20160830192617.3jwikiwshwish3c3@rhel-at-redhat.localdomain>
References: <01e601d202e0$7aaf62d0$700e2870$@a.bolton@m0noc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01e601d202e0$7aaf62d0$700e2870$@a.bolton@m0noc.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 30, 2016 at 06:03:49PM +0100, Paul Bolton wrote:
> First, apologies if this is the wrong SELinux list to post such questions;
> as you can guess I'm new to SELinux development.
> 
>  
> 
> I'm looking at getting a base MLS policy running on a fully patched CentOS
> 7.2 build which I will then customise; currently as a learning exercise.
> 
>  
> 
> Unfortunately I'm having a few problems (usually it works out-of-the-box on
> distros I've used, but not in this case), so I hope someone on the list can
> give me a push in the right direction.
> 

On RHEL and CentOS should sufficient to:

1. install selinux-policy-mls package
2. set SELinux to permissive and mls type
3. run fixfiles -F onboot
4. reboot
5. if everything went fine and the filesystem is correctly relabeled,
switch back to enforcing

and if you want to login as root using ssh, you need to turn
ssh_sysadm_login boolean on

See
https://docs.fedoraproject.org/en-US/Fedora/24/html/SELinux_Users_and_Administrators_Guide/enabling-mls-in-selinux.html
or
https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/SELinux_Users_and_Administrators_Guide/mls.html#enabling-mls-in-selinux

Petr

> 
> Bottom line is that if I try to use the vendor supplied version the system
> is unusable if set to enforcing (I've used MLS before, so I do mean unusable
> in this case).
> 
>  
> 
> I've now downloaded the latest reference policy, compiled it for mls and
> systemd including updating the broken labelling due to /bin and /sbin being
> symlinks. Things look better but there are still many errors.
> 
>  
> 
> One group in particular puzzles me (hopefully due to some misunderstanding
> on my part).
> 
>  
> 
> I get AVC's for a number of critical files relating to systemd sockets and
> /dev/log, for example. e.g.
> 
>  
> 
> -- snip --
> 
> type=AVC msg=audit(1472476843.913:1124): avc:  denied  { sendto } for
> pid=11015 comm="sshd" path="/dev/log"
> scontext=system_u:system_r:sshd_t:s0-s15:c0.c1023
> tcontext=system_u:system_r:kernel_t:s15:c0.c1023 tclass=unix_dgram_socket
> 
>  
> 
>         Was caused by:
> 
>  
> 
> #Constraint rule:
> 
>  
> 
>         mlsconstrain unix_dgram_socket { sendto } ((l1 eq l2 -Fail-)  or
> (t1=sshd_t  eq TYPE_ENTRY -Fail-) { POLICY_SOURCE: mlsnetwriteranged }  and
> (l1 dom l2 -Fail-)  and (l1 domby h2 -Pass-)  or (t1=sshd_t  eq TYPE_ENTRY
> -Fail-) { POLICY_SOURCE: mlsnetwritetoclr }  and (h1 dom L2 -Pass-)  and (l1
> domby l2 -Pass-)  or (t1=sshd_t  eq TYPE_ENTRY -Fail-) { POLICY_SOURCE:
> mlsnetwrite }  or (t2=kernel_t  eq TYPE_ENTRY -Fail-) { POLICY_SOURCE:
> mlstrustedobject } ); Constraint DENIED
> 
>  
> 
> #       Possible cause is the source level (s0-s15:c0.c1023) and target
> level (s15:c0.c1023) are different.
> 
> -- snip --
> 
>  
> 
> Now, given that /dev/log is labelled as a devlog_t:
> 
>  
> 
> # ls -lZ /dev/log
> 
> srw-rw-rw-. root root system_u:object_r:devlog_t:s15:c0.c1023 /dev/log
> 
>  
> 
> And according to logging.te, this is a trusted object:
> 
>  
> 
> mls_trusted_object(devlog_t)
> 
>  
> 
> Why is the target context for evaluation kernel_t and not devlog_t? Surely
> it should be devlog_t and therefore pass the constraint rule as a trusted
> object?
> 
>  
> 
>  
> 
> Paul
> 
> ----
> 
> http://blog.m0noc.com/ | https://keybase.io/m0noc
> 
> 4329 E4C5 71F3 58B2 2246  D04D 25DA 39C2 3876 FE3D
> 
>  
> 

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


-- 
Petr
