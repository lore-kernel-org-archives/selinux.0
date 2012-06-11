Message-ID: <1339433473.8102.18.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Boolean change of names.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Date: Mon, 11 Jun 2012 12:51:13 -0400
In-Reply-To: <4FD61901.1010806@redhat.com>
References: <4FD61901.1010806@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-06-11 at 12:12 -0400, Daniel J Walsh wrote:
> We have started pushing a boolean change into Fedora 18.
> 
> https://fedoraproject.org/wiki/Features/SELinuxBooleansRename
> 
> The problem we are seeing is that boolean names used within an interface are
> causing the install to fail on rebuild of policy.
> 
> IE If I installed a custom policy with a boolean used in it, and the boolean
> changed then the module will blow up the policy compile.
> 
> 
> interface(`kerberos_manage_host_rcache',`
> 	gen_require(`
> 		type krb5_host_rcache_t;
> 	')
> 
> ...
> 
> 	tunable_policy(`allow_kerberos',`
> 		allow $1 self:process setfscreate;
> ...
> 	')
> 
> ...
> ')
> 
> And change the allow_kerberos to kerberos_enabled.
> 
> One idea would be to pull the translations into the semanage, or would I need
> to do this at a lower level.  Or are we stuck with these bad names forever...

Adding boolean aliases to the policy language, including kernel support,
seems like the best route if you truly want to do this.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
