Subject: Re: new user types
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1202494415.3577.18.camel@bluejay.goodinassociates.com>
References: <1202426088.2801.500.camel@bluejay.goodinassociates.com>
	 <1202479171.27371.320.camel@moss-spartans.epoch.ncsc.mil>
	 <1202494415.3577.18.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Fri, 08 Feb 2008 14:13:49 -0500
Message-Id: <1202498029.27371.409.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-08 at 12:13 -0600, Jeremiah Jahn wrote:
> On Fri, 2008-02-08 at 08:59 -0500, Stephen Smalley wrote:
> > On Thu, 2008-02-07 at 17:14 -0600, Jeremiah Jahn wrote:
> > > I can't seem to login as the right user, and I'm not sure what I missed.
> > > 
> > > I added the following roles and users to my monetra.te file:
> > > 
> > > 
> > > #admin roles
> > > role monetra_admin_r types monetra_t;
> > > role monetra_admin_r types monetra_lib_t;
> > 
> > role-type statements are only required for domain types, not file types.
> > Files use the generic object_r role.
> thanx.
> 
> 
> > 
> > > #client roles
> > > role monetra_client_r types monetra_t;
> > > role monetra_client_r types monetra_lib_t;
> > > role monetra_client_r types monetra_client_t;
> > > 
> > > #monetra users
> > > user monetra_u roles { monetra_client_r monetra_admin_r } level s0 range s0 - s0;
> > > 
> > > 
> > > 
> > > 
> > > I ran the add login command:
> > > semanage login -a -s monetra_u bob
> > > 
> > > 
> > > 
> > > I get the following output:
> > > [root@xxx ~]# semanage login -l
> > > 
> > > Login Name                SELinux User              MLS/MCS Range            
> > > 
> > > __default__               user_u                    s0                       
> > > root                      root                      s0-s0:c0.c255            
> > > system_u                  system_u                  s0-s0:c0.c255            
> > > bob                      monetra_u                 s0                       
> > > 
> > > [root@xxx ~]# semanage user -l
> > > 
> > >                 Labeling   MLS/       MLS/                          
> > > SELinux User    Prefix     MCS Level  MCS Range                      SELinux Roles
> > > 
> > > 
> > > monetra_u       user       s0         s0                             monetra_admin_r monetra_client_r
> > > root            sysadm     s0         s0-s0:c0.c255                  sysadm_r staff_r
> > > staff_u         staff      s0         s0-s0:c0.c255                  sysadm_r staff_r
> > > sysadm_u        sysadm     s0         s0-s0:c0.c255                  sysadm_r
> > > system_u        user       s0         s0-s0:c0.c255                  system_r
> > > unconfined_u    unconfined s0         s0-s0:c0.c255                  unconfined_r
> > > user_u          user       s0         s0                             user_r
> > > 
> > > yet when I login I get:
> > > [bob@xxx ~]$ id -Z
> > > system_u:system_r:unconfined_t:s0-s0:c0.c255
> > > 
> > > 
> > > thanx for any help you can give.
> > 
> > First, by login, I assume you mean a real login (via console login, gdm,
> > or ssh), not just a su.  su doesn't change SELinux context in RHEL 5.
> correct.
> 
> > 
> > Second, have you authorized a domain transition from the domain in which
> > the login process is running to your new domain?
> can you give me a quick pointer as to where to go to find an example of
> this? userdomain.te didn't help, nor locallogin.te. I need to both do it
> from the console, and from ssh. And one other dumb question, what the
> heck are prefixes, and how do they apply to this? 

(cc'ing Chris, refpolicy maintainer)

The login domains call the userdom_spec_domtrans_all_users() or
unpriv_users() interfaces to allow the domain transition to happen to
user domains, where user domains have the 'userdomain' attribute (when
declared via the userdom_base_user_template() interface or one of its
callers).

You also need to allow the role transition to happen and to ensure that
the constraint passes.  All of which should be covered if using
userdom_base_user_template() or one of its callers to define your user
domain.

The prefix is the string prepended to the home directory types for the
user domain.  Conventionally, this is the same as the user domain
prefix, e.g. user_t has prefix "user", thus yielding user_home_dir_t,
user_home_t, etc for the home directory labeling.

Chris can likely comment on the best way to create new roles presently;
there has been work done to simplify it and allow tools like SLIDE to
help automate it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
