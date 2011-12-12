Subject: Re: Proper use of get_default_context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20111211165153.GA18954@siphos.be>
References: <20111211165153.GA18954@siphos.be>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Dec 2011 09:35:01 -0500
Message-ID: <1323700501.2177.4.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2011-12-11 at 17:51 +0100, Sven Vermeulen wrote:
> Hi all,
> 
> I'm trying to debug a (less important) case of SSHd segfaulting when the
> user is running in permissive mode but has a wrongly labeled system,
> resulting in the sshd binary running in the kernel_t context. It looks like
> this causes a double-free (or something similar) [1] in the code and I'm
> trying to figure out how to best deal with this.
> 
> [1] https://bugs.gentoo.org/show_bug.cgi?id=377203
> 
> >From the looks of it, I think it boils down to get_default_context which
> returns -1 (as expected) but either leaves the security_context_t as-is or
> makes it NULL.
> 
>  98 int get_default_context(const char *user,
>  99                         security_context_t fromcon, security_context_t * newcon)
> 100 {
> 101         security_context_t *conary;
> 102         int rc;
> 103 
> 104         rc = get_ordered_context_list(user, fromcon, &conary);
> 105         if (rc <= 0)
> 106                 return -1;
> 107 
> 108         *newcon = strdup(conary[0]);
> 109         freeconary(conary);
> 110         if (!(*newcon))
> 111                 return -1;
> 112         return 0;
> 113 }
> 
> Am I correct to state that, if the newcon variable was not set to a valid
> security_context_t before, then I can just set newcon to NULL?
> 
> Like in OpenSSH's ssh_selinux_getctxbyname:
> 
>   static security_context_t ssh_selinux_getctxbyname(char *pwname) {
>     security_context_t sc;
>     ...
>     r = get_default_context(pwname, NULL, &sc);
> 
>     return(sc);
>   }
> 
> I think the above might be updated with:
> 
>   if (r != -1)
>     return(sc);
>   else
>     return(NULL);
> 
> Otherwise a later call tries to freecon(sc) which then fails (in case of
> OpenSSH, that's in ssh_selinux_setup_exec_context()).
> 
> Am I making sense here?

That would work, or you could initialize sc to NULL before calling
get_default_context(), and then unconditionally return sc.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
