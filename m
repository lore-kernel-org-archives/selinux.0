Subject: Re: vserver and vprocunhide
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200610240847.58333.Daniel.Gil-Mayol@brunel.de>
References: <200610231751.50609.Daniel.Gil-Mayol@brunel.de>
	 <1161625986.3316.108.camel@moss-spartans.epoch.ncsc.mil>
	 <200610240847.58333.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 11:53:25 -0400
Message-Id: <1161705205.3987.88.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-24 at 08:47 +0200, Daniel Gil Mayol wrote:
> > On Mon, 2006-10-23 at 17:51 +0200, Daniel Gil Mayol wrote:
> > > 1.)
> > >
> > > I have read that vserver and selinux have conflicts, is that true?
> >
> > Define "conflicts".  You will need to configure SELinux policy
> > appropriately, but I'm not aware of any fundamental conflict (e.g. there
> > would be a real conflict if vserver used the LSM security fields or
> > hooks, but it doesn't AFAIK).
> 
> I read that "SELinux conflicts with Linux-VServer. Disable it 
> in /etc/selinux/config (SELINUX=disabled)" about CentOS in this link: 
> http://oldwiki.linux-vserver.org/CentOS_HowTo

I'm not aware of any fundamental conflict, as I said.  Just a matter of
policy configuration.  I believe that their advice to disable SELinux is
just because they don't use SELinux themselves and don't want to have to
help users figure out how to configure SELinux for vserver.

> I want to unhide /proc/1 because seems that vserver try to access there:

That isn't clear.  IIUC, you are getting these denials because you are
trying to unhide /proc/1, not the other way around.  So, again, why are
you trying to unhide /proc/1, i.e. why does it need to be visible within
the vserver instances?

> Oct 24 07:45:55 cnsu kernel: audit(1161675955.340:8577): avc:  denied  
> { search } for  pid=28537 comm="pidof" name="1" dev=proc ino=65538 
> scontext=root:system_r:vserver_ids_t tcontext=user_u:system_r:unconfined_t 
> tclass=dir

So now you have a vserver_ids_t domain; in the prior message you were
showing a vserver_test_t domain.  Are they different?  Or did you just
change the name?  Where does this process run?  On the "base" system or
within each vserver instance?

> Move init into its own domain means relabel /proc/1 with for example 'init_t'? 
> because I tried but this relabeling had no effect, it is, I have used "chcon 
> -t init_t /proc/1/*", doesn't report me any error but after a "ls -Z" I see 
> that the labelling haven't been done, is still 
> "user_u:system_r:unconfined_t".

No, you wouldn't relabel the /proc/1 files; you would define a domain
transition for init in your policy and then init would automatically run
in init_t, and the /proc/1 files would automatically inherit that
domain.  This is already done in strict policy, as well as in newer
targeted policies in Fedora Core.

> I haven't found any definition of type init_t (something like "type 
> init_t,..."), but after "sestatus -v" I see this line:
> 'Init context:           user_u:system_r:unconfined_t'
> Should I try to change this init context? How? defining simply "type 
> init_t ..."

See the strict policy or a newer targeted policy from Fedora for
examples.  In those policies, the system doesn't start in unconfined_t;
it starts in kernel_t, transitions to init_t upon running /sbin/init
(the second time, after policy load), and then init_t transitions to
other domains as appropriate.

> I have two vservers: lets says 'vserver_1' and 'vserver_2'. Each one has its 
> own labelling for bin and libs ('vserver_1_exec_t',  'vserver_1_lib_t') and 
> the rest as 'vserver_1_modules_t' (the same for vserver_2). 
> Other services like httpd don't use any specific labelling for each vserver.

I'm not sure I understand.  By "vserver", do you mean daemon processes?
But what about the rest of the processes running within each vserver
instance?  Does httpd run as httpd_t within each vserver instance?  

> > And what was that assertion?  Likely just requires an attribute on
> > vprocunhide_t to mark it as a mount point directory.
> 
> This line in policy.conf correspond to the following rule:
> 
> # for gross mistakes in policy
> neverallow domain domain:dir ~{ read getattr lock search ioctl };
> 
> that doesn't mention mounton.

I thought that vprocunhide_t was a file type, not a domain.  Did you put
"domain" in its attribute list?  That would be a mistake.  Domains are
for processes (the rule above has to do with their /proc/pid entries,
which are labeled with the domain of the associated process), file_type
is for file types.


> > Is this process running within a vserver?  
> > Is the process running as 
> > root?  Does it have the necessary capabilities to send audit messages?
> 
> After execute "ps aux | grep bus" I see the next:
> 
> dbus     21879  0.0  0.3 10508  768 ?        Ssl  Oct23   0:00 dbus-daemon-1 
> --system
> 
> so it is not running within a vserver, has its own process; 
> And appear dbus instead of root, must be root?

dbusd can run as a system-wide message bus (as root) and as a
per-session message bus (as the user who is logged in).  In the latter
situation, it cannot generate audit messages, and that is ok.  Current
versions of dbusd have been changed to not try generating audit messages
in that case, IIUC.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
