Subject: RE: [v0 PATCH 2/3] SELinux: Compute role in newcontext for all
 classes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: qingtao.cao@windriver.com, jmorris@namei.org, eparis@parisplace.org,
        selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <SNT139-w5684DB5D9F65F017A51374ABB60@phx.gbl>
References: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
	 ,<1300847325-20308-3-git-send-email-qingtao.cao@windriver.com>
	 ,<1300887112.26747.17.camel@moss-pluto>
	 <SNT139-w5684DB5D9F65F017A51374ABB60@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Mar 2011 09:25:26 -0400
Message-ID: <1300973126.8157.31.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-03-24 at 09:56 +0000, HarryCiao wrote:
> Hi Stephen,
> 
> > Subject: Re: [v0 PATCH 2/3] SELinux: Compute role in newcontext for
> all classes
> > From: sds@tycho.nsa.gov
> > To: qingtao.cao@windriver.com
> > CC: jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov
> > Date: Wed, 23 Mar 2011 09:31:52 -0400
> > 
> > On Wed, 2011-03-23 at 10:28 +0800, Harry Ciao wrote:
> > > From: Harry Ciao <harrytaurus200@hotmail.com>
> > > 
> > > For the process class, the role_trans.type is compared with
> > > tcontext->type, that is, the program executable type.
> > > 
> > > For all the rest classes, the role_trans.type is compared with
> > > newcontext.type, that is, the type for the newly created object
> > > of that class.
> > 
> > I don't understand why you aren't applying the logic consistently
> for
> > all classes. Compare with range_trans handling. Also, if we think
> > there will be any significant numbe! r of these role_trans rules,
> you
> > might want to go ahead and start using a hashtab as was later done
> for
> > range_trans for efficient lookup.
> 
> Suppose we have below role_transition rule:
> 
> role_transition sysadm_r user_home_t : dir sysadm_r;
> 
> If roletr->type compared with newcontext.type, then it means that if
> sysadm_r is creating an directory object with type equals to
> user_home_t, then the directory object will have a role of sysadm_r.
> 
> However, if roletr->type is compared with tcontext->type, then the
> semantics would be changed to that any objects of any class created by
> sysadm_r in a directory object of the user_home_t type would have
> their role set to sysadm_r, since in selinux_inode_init_security(),
> dir->i_security is passed as tsid always.
> 
> I guess the former approach could have much refined control on the
> objects role, if objects are of different types, then they could
> assume different roles, not necessarily all f! iles in one directory
> have to share the same role.
> 
> What you thi nk?

Compare with type_transition or range_transition semantics.
type_transition sysadm_t tmp_t : sock_file sysadm_tmp_t;
means when a sysadm_t (scontext->type) process creates a socket file
(tclass) object in a directory labeled tmp_t (tcontext->type), then
label the socket file with sysadm_tmp_t (newcontext->type).

type_transition sysadm_t sshd_exec_t:process sshd_t;
means when a sysadm_t (scontext->type) process executes a sshd_exec_t
(tcontext->type) file, then label the new process (tclass) with sshd_t
(newcontext->type).

See how they are consistently applied regardless of whether it is a
process or object class?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
