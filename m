Subject: Re: question about su and passwd
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: lky <lky77@sjtu.edu.cn>
Cc: SELINUX <SELinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
   Howard Holm <hdholm@epoch.ncsc.mil>
In-Reply-To: <000c01c39cb7$e4e99f50$5d38a8c0@lky>
References: <001401c39a74$ac06b370$5d38a8c0@lky>
	 <1067266352.18818.51.camel@moss-spartans.epoch.ncsc.mil>
	 <000c01c39cb7$e4e99f50$5d38a8c0@lky>
Content-Type: text/plain
Message-Id: <1067279528.18818.129.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 27 Oct 2003 13:32:08 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-27 at 13:26, lky wrote:
> On Monday, October 27, 2003 10:52 PM,Stephen Smalley wrote:
> > - The kernel performs permission checks for the various kernel
> > operations invoked by the passwd program, e.g. invoking cracklib
> > to check the strength of the passwd, accessing the cracklib database,
> > updating /etc/shadow, etc.  The policy or file contexts configurations
> > may need to be adjusted to grant the appropriate permissions or set
> > the appropriate file types.  Is crack.te enabled?
> 
> Sorry,I didn't enable crack.te.Now I can use passwd.Thanks a lot!

I think that this is actually a "bug" in the policy, as you want the
crack database correctly typed for pam_cracklib even if you aren't
running the crack program itself.  I suspect we want the type definition
and file contexts entries for the cracklib enabled even if crack.te is
not.

> > - The passwd program performs a permission check when the password for a
> > user other than the current SELinux user identity would be changed, e.g.
> > you ran passwd after doing a 'su' so that your SELinux user identity
> > no longer matches your Linux uid or you ran passwd with a username
> > argument other than your own.  This is to prevent someone with the
> > Linux root uid from being able to change the passwords of other users
> > unless they are also in an authorized role/domain.
> 
> But in enfoced mode I can still run passwd after doing a 'su' . For example,
> I just login as root and then run 'su tom'(tom is a common user).Next I can 
> run passwd and change the password of tom. And I can change other users' 
> password after login as root.I shouldn't do that,right? But it happened.why?

That's ok as long as you were in sysadm_r:sysadm_t prior to running
passwd, as the policy grants that domain the permission to change other
users' passwords.  We aren't trying to prevent a legitimate
administrator from changing other users' passwords.  We are trying to
prevent arbitrary uid 0 processes in other domains from doing that, e.g.
try the same thing as root from user_r:user_t or staff_r:staff_t or any
daemon domain.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
