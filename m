Subject: Re: Problems with login from serial port.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Ryan Bradetich <rbradetich@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <1173675210.16821.119.camel@localhost.localdomain>
References: <e739902b0703102125r205f725bs89242fdf00480662@mail.gmail.com>
	 <1173663815.29664.31.camel@sgc>
	 <1173675210.16821.119.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 12 Mar 2007 08:45:16 -0400
Message-Id: <1173703516.2738.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-12 at 00:53 -0400, Eric Paris wrote:
> On Mon, 2007-03-12 at 01:43 +0000, Christopher J. PeBenito wrote:
> > On Sat, 2007-03-10 at 21:25 -0800, Ryan Bradetich wrote:
> > > I have been making good progress on my customized policy, but I ran
> > > into a problem that I do not understand.
> > [cut]
> > > Here are the avc message I get when I login in permissive mode:
> > > 
> > > audit(1173587017.702:3): avc:  denied  { relabelfrom } for  pid=199
> > > comm="login" name="ttyS0" dev=hda1 ino=31387
> > > scontext=system_u:system_r:system_t
> > > tcontext=root:object_r:sysadm_tty_device_t tclass=chr_file
> > > 
> > > audit(1173587017.702:3): avc:  denied  { relabelto } for  pid=199
> > > comm="login" name="ttyS0" dev=hda1 ino=31387
> > > scontext=system_u:system_r:system_t
> > > tcontext=root:object_r:sysadm_tty_device_t tclass=chr_file
> > [cut]
> > > I have the following rule in my policy file (I thought this rule will
> > > have addressed the avc  message):
> > > 
> > > allow system_t sysadm_tty_device_t:chr_file { read write ioctl getattr
> > > setattr relabelto relabelfrom };
> > 
> > Notice that the scontext is "system_u::" and the tcontext is "root::".
> > You are hitting the constraint which requires that the SELinux user of
> > the domain doing the relabeling to match the SELinux user of the object:
> > 
> > constrain dir_file_class_set { create relabelto relabelfrom } 
> > (
> > 	u1 == u2
> > 
> > 	or t1 == can_change_object_identity
> > );
> > 
> > So you want domain_obj_id_change_exemption(system_t) to pass this
> > constraint.
> 
> Is this something audit2why can or should pick up?  Maybe something for
> madisen?  I think i've hit this in the past as well....

audit2why already should report that it violates a constraint, but it
won't presently tell you which constraint was violated or what to do
about it.  If Karl succeeds in introducing a policy IR into libsepol
(see his prior RFC), then it will be easier to provide such information
and that functionality can all be rolled into Madison / sepolgen.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
