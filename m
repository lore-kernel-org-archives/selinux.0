Subject: Re: hierarchical roles
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, klaus@atsec.com,
        selinux@tycho.nsa.gov
In-Reply-To: <1154972723.26697.126.camel@moss-spartans.epoch.ncsc.mil>
References: <1154965823.8936.46.camel@localhost.localdomain>
	 <1154967609.8936.55.camel@localhost.localdomain>
	 <1154972723.26697.126.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 14:03:46 -0400
Message-Id: <1154973826.8936.63.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-08-07 at 13:45 -0400, Stephen Smalley wrote:
> On Mon, 2006-08-07 at 12:20 -0400, Janak Desai wrote:
> > On Mon, 2006-08-07 at 11:50 -0400, Janak Desai wrote:
> > > As part of testing rbac evaluation requirements, I have been 
> > > trying to create a loadable policy module that creates
> > > a new role that dominates a few of the existing roles. I am able 
> > > to create a role using the dominance statement and "semanage user"
> > > correctly assigns other roles (which the new role dominates) to a
> > > user when that user is assigned the new role. From what I can
> > > see, I still have to setup needed access rights for the new
> > > domain associated with this new role. That makes sense, since
> > > roles only allow you access to a domain and are not involved in
> > > the access decision. So hierarchical roles only give you the
> > > ability to change into roles that you dominate but do not give
> > > you aggregate access rights of roles that you dominate, is that
> > > correct or am I missing something? 
> 
> Role dominance affects two relations:
> 1) The role-type (domain) relation.  If role A dominates role B, then
> role A automatically inherits all types (domains) authorized for role B
> (i.e. role A can be associated with all of those domains).
> 2) The user-role relation.  If role A dominates role B and a user is
> authorized for role A, then the user is also authorized for role B.
> 
> There are some lingering ordering issues in the role dominance support,
> but I don't know if that will present a problem for you.  
> 
> (1) does imply an aggregation of access rights for the dominating role,
> but not for any single domain in that role.  And you still need
> appropriate allow rules to permit the desired role and/or domain
> transitions.
> 

Thanks. The above two lines cleared my confusion. I was missing
domain transition rules and that was throwing me off.

> > > Let me explain what I am asking with an example. strict-mls 
> > > policy has roles sysadm_r and secadm_r. I created a new role 
> > > cnorris_r that dominates these two roles and runs in the 
> > > default domain cnorris_t. A user xyz is assigned the cnorris_r.
> > > Now the user xyz can use newrole to switch into sysadm_r
> > > or secadm_r, to perform actions that those roles are allowed.
> > > However, as cnorris_r in cnorris_t domain, xyz cannot perform
> > > actions that they could as sysadm_r or secadm_r. Is that
> > > correct or am I missing some policy magic that will allow
> > > cnorris_r to perform sysadm_r/secadm_r duties directly (without
> > > newrole'ing to them)?
> 
> In that situation, cnorris_r would be authorized for the domains
> associated with secadm_r and sysadm_r, but that doesn't imply anything
> about cnorris_t.  So for example, cnorris_r could even directly assume
> secadm_t as its domain (e.g. via newrole -t secadm_t) without changing
> the role.  
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
