Subject: Re: newrole - adding capabilities for polyinstantiation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <451D771F.5080905@us.ibm.com>
References: <451AEC39.2090409@us.ibm.com>
	 <1159450384.11489.5.camel@moss-spartans.epoch.ncsc.mil>
	 <451C3A37.8080509@us.ibm.com>  <451D771F.5080905@us.ibm.com>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 16:51:00 -0400
Message-Id: <1159563060.8496.223.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-29 at 14:42 -0500, Michael C Thompson wrote:
> After some discussion with some people in my department, I would like to 
> suggest the following proposal for newrole, which I believe would 
> address the need for polyinstantiation in the LSPP environment.
> 
> I propose we fork newrole into a two separate processes in the LSPP 
> environment. One process would retain only the CAP_AUDIT_WRITE 
> capability, and be responsible for handling the bulk of newrole 
> operation. The other process, which would only be forked when compiled 
> for the LSPP environment, would retain all capabilities required for the 
> polyinstantiation operation.
> 
> This second, more privilaged, process's scope would be limited to 
> handling the pam_session requests. This would allow this separate 
> process to remain suid for its lifetime (hopefully alleviating Stephen 
> Smalley's concerns) and split it from the more vulnerable code.
> 
> Interactions between the less-secure and more-secure processes would be 
> handled through a restricted IPC mechanism.
> 
> What do people think of this idea?

pam_namespace has to run in the same process that exec's the user shell;
otherwise, it ends up manipulating the namespace of its own process and
has no effect on the user shell's namespace.  That is why you can't just
run it as a helper or separate process.  You'd have to move the exec'ing
of the user shell into it as well, at which point you also have to move
the setting up of the new context into it, and voila!  you've re-created
newrole in this second process.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
