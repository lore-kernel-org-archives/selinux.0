Subject: Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd, and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1162319582.23631.1.camel@code.and.org>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
	 <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
	 <1161620097.667.10.camel@code.and.org>
	 <1161722236.667.20.camel@code.and.org>
	 <1161776892.3987.193.camel@moss-spartans.epoch.ncsc.mil>
	 <1161778937.3987.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1161784251.667.28.camel@code.and.org>
	 <1161784759.3987.295.camel@moss-spartans.epoch.ncsc.mil>
	 <1161803724.29689.57.camel@code.and.org>
	 <1161804290.3987.388.camel@moss-spartans.epoch.ncsc.mil>
	 <1161970810.29689.88.camel@code.and.org>
	 <1161974293.1306.167.camel@moss-spartans.epoch.ncsc.mil>
	 <1162238632.31104.11.camel@code.and.org>
	 <1162239394.31104.13.camel@code.and.org>
	 <1162304610.32614.24.camel@moss-spartans.epoch.ncsc.mil>
	 <1162304681.32614.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1162306839.31104.23.camel@code.and.org>
	 <1162307495.32614.47.camel@moss-spartans.epoch.ncsc.mil>
	 <1162310652.31104.46.camel@code.and.org>
	 <1162311675.32614.81.camel@moss-spartans.epoch.ncsc.mil>
	 <1162319582.23631.1.camel@code.and.org>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 07:36:43 -0500
Message-Id: <1162384603.32614.163.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-31 at 13:33 -0500, James Antill wrote:
> On Tue, 2006-10-31 at 11:21 -0500, Stephen Smalley wrote:
> 
> > No.  The ability to make the security call is controlled by the
> > compute_av permission on the security class, and isn't based on the
> > individual contexts passed as arguments.  That would be:
> > 	allow $1 security_t:security compute_av;
> > which has an interface:
> > 	selinux_compute_access_vector($1)
> > which is already in authlogin.if.  No change required for allowing the
> > call to happen.
> > 
> > What you are instead trying to do is to define the _result_ of that
> > compute_av call based on its arguments, not whether it can be made by
> > login.  So the TE rule would go into userdomain.if and be of the form:
> > 	allow $1 self:context <permissionname>;
> 
>  Ok, I think I have it now. Both patches are at (with the renamed
> permission):
> 
>  http://people.redhat.com/jantill/pam-config_role/upstream/

They look sane to me.  Please post them in separate messages, preferably
inline, and cc Chris PeBenito on the policy patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
