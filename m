Subject: Re: adding objects classes and permissions to policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andy Warner <warner@rubix.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <48F8ABBC.9060808@rubix.com>
References: <48F798BB.6070602@rubix.com>
	 <1224186793.9247.139.camel@moss-spartans.epoch.ncsc.mil>
	 <1224186905.9247.141.camel@moss-spartans.epoch.ncsc.mil>
	 <48F85ECC.108@rubix.com>
	 <1224245613.18694.26.camel@moss-spartans.epoch.ncsc.mil>
	 <48F89EBE.6020800@rubix.com>
	 <1224253435.19562.23.camel@moss-spartans.epoch.ncsc.mil>
	 <48F8ABBC.9060808@rubix.com>
Content-Type: text/plain
Date: Fri, 17 Oct 2008 11:15:22 -0400
Message-Id: <1224256522.19562.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-10-17 at 17:14 +0200, Andy Warner wrote:
> 
> 
> Stephen Smalley wrote: 
> > On Fri, 2008-10-17 at 16:18 +0200, Andy Warner wrote:
> >   
> > > Stephen Smalley wrote: 
> > >     
> > > > On Fri, 2008-10-17 at 11:45 +0200, Andy Warner wrote:
> > > >   
> > > >       
> > > > > Stephen Smalley wrote: 
> > > > >     
> > > > >         
> > > > > > On Thu, 2008-10-16 at 15:53 -0400, Stephen Smalley wrote:
> > > > > >   
> > > > > >       
> > > > > >           
> > > > > > > On Thu, 2008-10-16 at 21:40 +0200, Andy Warner wrote:
> > > > > > >     
> > > > > > >         
> > > > > > >             
> > > > > > > > When adding new object classes and permissions to SELinux policy is it
> > > > > > > > necessary to re-create flask.h and av_permissions.h header files so
> > > > > > > > that a user-space object manager can access the associated defines? If
> > > > > > > > so, would someone give me some pointers as to how these are
> > > > > > > > generated? 
> > > > > > > >       
> > > > > > > >           
> > > > > > > >               
> > > > > > > You should use the dynamic class/permission lookup facilities for any
> > > > > > > new code.  man selinux_set_mapping
> > > > > > > 
> > > > > > > XSELinux and SE-PostgreSQL are already using it I believe.
> > > > > > >     
> > > > > > >         
> > > > > > >             
> > > > > I can't find any evidence that my version of libselinux contains the
> > > > > selinux_set_mapping function. I am using CentOS 5.1 with libselinux
> > > > > version 1.33.4. I have been learning RHEL 5 tends to be a bit behind
> > > > > the times with regards to SELinux functionality. Does libselinux
> > > > > 1.33.4 not have the dynamic class/permission lookup facilities? If it
> > > > > does not, any advice on how to add object classes / permissions to
> > > > > policy ? Moving to Fedora is a possibility, maybe it's worth
> > > > > considering as this would not be the first issue we have had with an
> > > > > outdated SELinux mechanism on RHEL 5 (?). We are integrating SELinux
> > > > > TE / MLS with our commercial DBMS, and I have learned that RHEL 5 does
> > > > > not have the database related object classes /permissions in the base
> > > > > policy where the most recent Fedora does, hence my need to add the
> > > > > object classes /permissions in RHEL 5.
> > > > >     
> > > > >         
> > > > To use the object class/perm discovery support, you'd need to use a
> > > > modern libselinux (>= 2.0.21) and a modern kernel (>= 2.6.23).
> > > > 
> > > > Note that regardless of whether you use object class/permission
> > > > discovery support, you have to add the classes and permissions to the
> > > > policy flask definitions and rebuild your policy.  The object class/perm
> > > > discovery support just changes how the object manager obtains the values
> > > > - whether they are hardcoded into it or dynamically looked up at object
> > > > manager startup.  But the policy itself still needs to be taught about
> > > > them.
> > > > 
> > > > As Ted said, the old way to teach libselinux about new classes/perms is
> > > > described in:
> > > > http://selinuxproject.org/page/Adding_New_Permissions
> > > > 
> > > > After updating the policy/flask files, you run make in the flask
> > > > subdirectory (different Makefile than the policy build one) and it will
> > > > regenerate the header files that are used by libselinux and by the
> > > > kernel.  Then you can install the libselinux ones into a libselinux
> > > > source tree via make LIBSELINUX_D=/path/to/libselinux tolib, and then
> > > > rebuild your libselinux.
> > > > 
> > > >   
> > > >       
> > > When I install our product on a fresh machine in addition to the
> > > actual product and the new policy files, will I also need to install a
> > > new version of the libselinux libraries?
> > >     
> > 
> > Yes (when using the old way).
> > 
> >   
> > > I assume that the linux kernel needs to somehow access the new object
> > > class / permissions defines (I'm guessing there is a potential for
> > > pre-existing defines to change through my policy rebuild), would that
> > > be through the shared libselinux libraries? Kernel rebuild? (Mucking
> > > with Linux itself is way out of my area of knowledge.)
> > >     
> > 
> > No, the kernel doesn't need userspace object class/perm definitions,
> > because it never references them itself.
> >   
> My concern was not that the kernel would need to access my userspace
> object class/perm definitions but that through creating a new flask.h
> I would change the definitions of pre-existing object classes. For
> instance, my current flask.h has:
> 
> #define SECCLASS_FILE   6
> 
> If after I generated a new flask.h this somehow changed to:
> 
> #define SECCLASS_FILE   7
> 
> I would think this could cause an issue with the kernel if it uses the
> SECCLASS_FILE define in code built with the original flask.h. Is this
> possible or are the pre-existing kernel object class defines
> guarenteed to be consistent accross policy builds which have new
> object class definitions?

You have to add new classes to the end of security_classes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
