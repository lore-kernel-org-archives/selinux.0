Subject: Re: libsemanage.semanage_install_active: error during semodule -n
	-v -b base.pp -s refpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
Cc: SELinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>,
        Caleb Case <ccase@tresys.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <48517032.6070805@windriver.com>
References: <4851361E.3030305@windriver.com>
	 <1213288802.17842.195.camel@moss-spartans.epoch.ncsc.mil>
	 <48515E78.40400@windriver.com>
	 <1213293329.17842.246.camel@moss-spartans.epoch.ncsc.mil>
	 <48516379.80609@windriver.com>
	 <1213294846.17842.261.camel@moss-spartans.epoch.ncsc.mil>
	 <48517032.6070805@windriver.com>
Content-Type: text/plain
Date: Thu, 12 Jun 2008 15:12:02 -0400
Message-Id: <1213297922.17842.290.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-06-12 at 14:51 -0400, Vikram Ambrose wrote:
> Stephen Smalley wrote:
> > On Thu, 2008-06-12 at 13:57 -0400, Vikram Ambrose wrote:
> >   
> >> Stephen Smalley wrote:
> >>     
> >>> On Thu, 2008-06-12 at 13:35 -0400, Vikram Ambrose wrote:
> >>>   
> >>>       
> >>>> Stephen Smalley wrote:
> >>>>     
> >>>>         
> >>>>> On Thu, 2008-06-12 at 10:43 -0400, Vikram Ambrose wrote:
> >>>>>   
> >>>>>       
> >>>>>           
> >>>>>> During the "make load" procedure with refpolicy, the semodule command 
> >>>>>> fails, so I tried it manually and I see this error.
> >>>>>>
> >>>>>> root@ubuntu:/home/vikram/refpolicy-ac# semodule -b 
> >>>>>> /usr/share/selinux/refpolicy/base.pp -s refpolicy -v -n
> >>>>>> Attempting to install base module '/usr/share/selinux/refpolicy/base.pp':
> >>>>>> Ok: return value of 0.
> >>>>>> Committing changes:
> >>>>>> libsemanage.semanage_install_active: setfiles returned error code 1. (No 
> >>>>>> such file or directory).
> >>>>>>     
> >>>>>>         
> >>>>>>             
> >>>>> whereis setfiles
> >>>>>
> >>>>>   
> >>>>>       
> >>>>>           
> >>>> setfiles and the rest of the SELinux "toolchain" was all built from svn 
> >>>> and placed into /hone/testing/root
> >>>> root's environment has PATH that contains /home/testing/root/bin
> >>>> as well as LD_LIBRARY_PATH to /home/testing/root/lib
> >>>>
> >>>> Does libsemanage have a hard coded path to setfiles?
> >>>>     
> >>>>         
> >>> Yes, although it can be overridden via /etc/selinux/semanage.conf.
> >>> Add something like:
> >>> [setfiles]
> >>> path = /path/to/setfiles
> >>> [end]
> >>>
> >>>   
> >>>       
> >> I just noticed the hard coded path in conf-parser.y
> >> Is there a way of doing the above with a generic rule to all of the 
> >> selinux toolchain and not specifically to "setfiles" as shown above?
> >>     
> >
> > Not presently; it wasn't really intended for an alternate root mechanism
> > (and apparently doesn't work for it anyway, as you have found).
> >
> >   
> And specifying each and every tool individual is not possible i suppose?

There are only two helpers that are executed by default, setfiles and
load_policy, and you can specify them both, using the same syntax but
different section keyword.

> >> ...
> >> Adding that to semanage.conf produce an almost obvious error " error 
> >> while loading shared libraries: libsepol.so.0: cannot open shared object 
> >> file: No such file or directory"
> >>
> >> what sort of environment is libsemanage using to execute setfiles? 
> >> libsepol and friends are in LD_LIBRARY_PATH
> >>     
> >
> > Ah, semanage_exec_prog() passes a NULL environ to execve().
> >
> >   
> Can this be rectified?

Even if we changed the code, the policy normally won't allow passing of
LD_LIBRARY_PATH and the like across a domain transition (noatsecure
permission to disable setting of AT_SECURE auxv flag), and setfiles and
load_policy typically run in their own domains.  Although you can
certainly customize policy and the code for your particular needs.

> > I think this takes us to the "run it in a chroot environment" scenario
> > if you don't want to install the libraries and programs to your system
> > directories.  I'm not entirely sure what your goal is here though - you
> > seem ok with installing the policy files to system directories.
> >   
> Your last remark there is rather confusing to me. You seem to suggest 
> that "installing the policy files to system directories" is an option I 
> have been given, and as such chosen to do so. To my knowledge the entire 
> toolchain is hard coded to /etc/selinux and as such not possible to 
> provide a /different/syconfig/path. How is it that I go about installing 
> selinux and its configuration to a non "system directory", yet "system 
> wide" path such as /security or /selinux or /seconfig etc..?

Well, yes, that's true.  Running it chroot'd is the only way right now
to do that.  Which would also resolve your problem with setfiles.

The other approach would be to change libselinux to support an alternate
root setting via some mechanism, but we have to be careful to not give
undue influence to callers where it isn't warranted, of course.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
