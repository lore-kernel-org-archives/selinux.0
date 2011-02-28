Subject: Re: Separate socket SID than its creator
From: Stephen Smalley <sds@tycho.nsa.gov>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: jmorris@namei.org, eparis@parisplace.org,
        selinux-mailing-list
 <selinux@tycho.nsa.gov>
In-Reply-To: <SNT139-W222AD5AB4BFF6776A5A244ABDF0@phx.gbl>
References: <SNT139-W222AD5AB4BFF6776A5A244ABDF0@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Feb 2011 08:52:38 -0500
Message-ID: <1298901158.17143.14.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2011-02-27 at 10:14 +0000, HarryCiao wrote:
> Hello Stephen, James and Eric,
> 
> The attached is the v1 patches to compute socket SID on creation. 
> 
> The propagation of the return code of security_transition_sid is a
> good practice and actually helps identifying the problem that the
> socket creator's role also needs to be able to type the socket role. 
> 
> The class number(orig_tclass) used by SELinux kernel driver is checked
> against SECCLASS_XXX macros and if it's any one of those 22 socket
> classes both security_compute_sid and mls_comput_sid will preserve the
> scontext's role and MLS attribute as what they have been done for
> policydb.policy_class. (we are not checking access vectors so we don't
> have to concern about the unmapped, real class number allocated by
> checkpolicy)
> 
> I've also come up with a debug patch to make use of the
> security_sid_to_context which helps to reveal that the
> unix_dgram_socket object created by syslogd differs only in type from
> its creator and shares the same user, role and MLS at! tribute. The
> relevant changes to logging.pp used for debugging is also attached.
> 
> Please kindly help commenting and suggesting how I could further test
> these two patches.

Kernel patches need to be posted one patch per message, inline, as per
SubmittingPatches.  http://userweb.kernel.org/~akpm/stuff/tpp.txt is
also a good resource on preparing kernel patches.

The order of your patches needs to be reversed so that there is no
change in behavior and everything still works after each patch is
applied - this is important for git bisect.

I'm a bit concerned about the maintainability of the socket class list
in security_is_socket_class().  We need to do something to ensure that
if someone later adds a new socket security class to the kernel, they
know to update this list.  At least a comment in classmap.h; ideally
some kind of compile-time check (similar to the #error case in hooks.c
to catch when someone adds more than 64 capabilities) to detect when
someone adds a socket class without updating the list there.  Or maybe
security_is_socket_class() needs to be auto-generated from classmap.h by
genheaders?

Since you are checking against the kernel values rather than the policy
values, you need to make sure you only apply this check when called from
the kernel (if kern == true).  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
