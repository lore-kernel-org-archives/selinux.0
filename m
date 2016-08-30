Subject: Re: SELinux MLS Policies
To: Paul Bolton <paul.a.bolton@m0noc.net>, selinux@tycho.nsa.gov
References: <01e601d202e0$7aaf62d0$700e2870$@a.bolton@m0noc.net>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <dcfa502a-a210-2815-33a7-825d905e4be6@tycho.nsa.gov>
Date: Tue, 30 Aug 2016 15:19:48 -0400
MIME-Version: 1.0
In-Reply-To: <01e601d202e0$7aaf62d0$700e2870$@a.bolton@m0noc.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/30/2016 01:03 PM, Paul Bolton wrote:
> First, apologies if this is the wrong SELinux list to post such
> questions; as you can guess I’m new to SELinux development.
> 
>  
> 
> I’m looking at getting a base MLS policy running on a fully patched
> CentOS 7.2 build which I will then customise; currently as a learning
> exercise.
> 
>  
> 
> Unfortunately I’m having a few problems (usually it works out-of-the-box
> on distros I’ve used, but not in this case), so I hope someone on the
> list can give me a push in the right direction.
> 
>  
> 
> Bottom line is that if I try to use the vendor supplied version the
> system is unusable if set to enforcing (I’ve used MLS before, so I do
> mean unusable in this case).
> 
>  
> 
> I’ve now downloaded the latest reference policy, compiled it for mls and
> systemd including updating the broken labelling due to /bin and /sbin
> being symlinks. Things look better but there are still many errors.
> 
>  
> 
> One group in particular puzzles me (hopefully due to some
> misunderstanding on my part).
> 
>  
> 
> I get AVC’s for a number of critical files relating to systemd sockets
> and /dev/log, for example. e.g.
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
> (t1=sshd_t  eq TYPE_ENTRY -Fail-) { POLICY_SOURCE: mlsnetwriteranged } 
> and (l1 dom l2 -Fail-)  and (l1 domby h2 -Pass-)  or (t1=sshd_t  eq
> TYPE_ENTRY -Fail-) { POLICY_SOURCE: mlsnetwritetoclr }  and (h1 dom L2
> -Pass-)  and (l1 domby l2 -Pass-)  or (t1=sshd_t  eq TYPE_ENTRY -Fail-)
> { POLICY_SOURCE: mlsnetwrite }  or (t2=kernel_t  eq TYPE_ENTRY -Fail-) {
> POLICY_SOURCE: mlstrustedobject } ); Constraint DENIED
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
> Why is the target context for evaluation kernel_t and not devlog_t?
> Surely it should be devlog_t and therefore pass the constraint rule as a
> trusted object?

sendto is a permission check between the two socket labels, not to be
confused with the file label.  When you send on a local/Unix socket, you
need write permission to the socket file (if using the file namespace;
if using the abstract namespace, there is no equivalent check) and you
need sendto to the peer socket (which typically will be labeled the same
as the receiving process).  So the receiving process is running in
kernel_t, or was at the time it created the socket.

There are two separate kernel objects when dealing with Unix sockets -
the file and the socket itself.
