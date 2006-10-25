Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9P8XR30016560
	for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2006 04:33:34 -0400
Received: from mailgate1.arcor-ip.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9P8VuTr012569
	for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2006 08:31:56 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate1.adm.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id 5151C1DBF95
	for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2006 10:33:25 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id 02DA75ABB
	for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2006 08:33:25 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20526-01 for <selinux@tycho.nsa.gov>;
 Wed, 25 Oct 2006 10:33:23 +0200 (CEST)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id 15F37597D
	for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2006 10:33:23 +0200 (CEST)
From: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
To: selinux@tycho.nsa.gov
Subject: Re: vserver and vprocunhide
Date: Wed, 25 Oct 2006 10:33:18 +0200
References: <200610231751.50609.Daniel.Gil-Mayol@brunel.de> <200610240847.58333.Daniel.Gil-Mayol@brunel.de> <1161705205.3987.88.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1161705205.3987.88.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200610251033.18810.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain;
  charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Tue, 2006-10-24 at 08:47 +0200, Daniel Gil Mayol wrote:
> > > On Mon, 2006-10-23 at 17:51 +0200, Daniel Gil Mayol wrote:
> > > > 1.)
> > > >
> > > > I have read that vserver and selinux have conflicts, is that true?
> > >
> > > Define "conflicts".  You will need to configure SELinux policy
> > > appropriately, but I'm not aware of any fundamental conflict (e.g.
> > > there would be a real conflict if vserver used the LSM security fields
> > > or hooks, but it doesn't AFAIK).
> >
> > I read that "SELinux conflicts with Linux-VServer. Disable it
> > in /etc/selinux/config (SELINUX=disabled)" about CentOS in this link:
> > http://oldwiki.linux-vserver.org/CentOS_HowTo
>
> I'm not aware of any fundamental conflict, as I said.  Just a matter of
> policy configuration.  I believe that their advice to disable SELinux is
> just because they don't use SELinux themselves and don't want to have to
> help users figure out how to configure SELinux for vserver.
>
> > I want to unhide /proc/1 because seems that vserver try to access there:
>
> That isn't clear.  IIUC, you are getting these denials because you are
> trying to unhide /proc/1, not the other way around.  

But the "denied messages" I sent you before, are reported before I try to 
unhide the /proc/1.

> So, again, why are 
> you trying to unhide /proc/1, i.e. why does it need to be visible within
> the vserver instances?

The problem is that I haven't programmed the vservers.


> > Oct 24 07:45:55 cnsu kernel: audit(1161675955.340:8577): avc:  denied
> > { search } for  pid=28537 comm="pidof" name="1" dev=proc ino=65538
> > scontext=root:system_r:vserver_ids_t
> > tcontext=user_u:system_r:unconfined_t tclass=dir
>
> So now you have a vserver_ids_t domain; in the prior message you were
> showing a vserver_test_t domain.  Are they different?  Or did you just
> change the name?  

I just change the name, are the same.

> Where does this process run?  On the "base" system or 
> within each vserver instance?

Do you mean vserver_ids? I think within each vserver.

> > Move init into its own domain means relabel /proc/1 with for example
> > 'init_t'? because I tried but this relabeling had no effect, it is, I
> > have used "chcon -t init_t /proc/1/*", doesn't report me any error but
> > after a "ls -Z" I see that the labelling haven't been done, is still
> > "user_u:system_r:unconfined_t".
>
> No, you wouldn't relabel the /proc/1 files; you would define a domain
> transition for init in your policy and then init would automatically run
> in init_t, and the /proc/1 files would automatically inherit that
> domain.  This is already done in strict policy, as well as in newer
> targeted policies in Fedora Core.

I wrote the following:
     domain_auto_trans(init_t, vserver_ids_exec_t, vserver_ids_t);

and I am still receiving the same:

Oct 25 09:18:06 cnsu kernel: audit(1161767886.890:1510): avc:  denied  
{ search } for  pid=3322 comm="pidof" name="1" dev=proc ino=65538 
scontext=root:system_r:vserver_ids_t tcontext=user_u:system_r:unconfined_t 
tclass=dir
Oct 25 09:18:06 cnsu kernel: audit(1161767886.890:1511): avc:  denied  
{ read } for  pid=3322 comm="pidof" name="stat" dev=proc ino=65550 
scontext=root:system_r:vserver_ids_t tcontext=user_u:system_r:unconfined_t 
tclass=file
Oct 25 09:18:06 cnsu kernel: audit(1161767886.894:1512): avc:  denied  
{ getattr } for  pid=3322 comm="pidof" name="stat" dev=proc ino=65550 
scontext=root:system_r:vserver_ids_t tcontext=user_u:system_r:unconfined_t 
tclass=file
Oct 25 09:18:06 cnsu kernel: audit(1161767886.894:1513): avc:  denied  
{ read } for  pid=3322 comm="pidof" name="exe" dev=proc ino=65545 
scontext=root:system_r:vserver_ids_t tcontext=user_u:system_r:unconfined_t 
tclass=lnk_file


> > I haven't found any definition of type init_t (something like "type
> > init_t,..."), but after "sestatus -v" I see this line:
> > 'Init context:           user_u:system_r:unconfined_t'
> > Should I try to change this init context? How? defining simply "type
> > init_t ..."
>
> See the strict policy or a newer targeted policy from Fedora for
> examples.  In those policies, the system doesn't start in unconfined_t;
> it starts in kernel_t, transitions to init_t upon running /sbin/init
> (the second time, after policy load), and then init_t transitions to
> other domains as appropriate.
>
> > I have two vservers: lets says 'vserver_1' and 'vserver_2'. Each one has
> > its own labelling for bin and libs ('vserver_1_exec_t', 
> > 'vserver_1_lib_t') and the rest as 'vserver_1_modules_t' (the same for
> > vserver_2).
> > Other services like httpd don't use any specific labelling for each
> > vserver.
>
> I'm not sure I understand.  By "vserver", do you mean daemon processes?

Yes, each vserver is a daemon.

> But what about the rest of the processes running within each vserver
> instance? 
> Does httpd run as httpd_t within each vserver instance? 

Yes, httpd is shared for both vservers.

> > > And what was that assertion?  Likely just requires an attribute on
> > > vprocunhide_t to mark it as a mount point directory.
> >
> > This line in policy.conf correspond to the following rule:
> >
> > # for gross mistakes in policy
> > neverallow domain domain:dir ~{ read getattr lock search ioctl };
> >
> > that doesn't mention mounton.
>
> I thought that vprocunhide_t was a file type, not a domain.  Did you put
> "domain" in its attribute list?  That would be a mistake.  Domains are
> for processes (the rule above has to do with their /proc/pid entries,
> which are labeled with the domain of the associated process), file_type
> is for file types.

You are right, it is not a daemon....it is a simple script, I made a mistake 
using the macro daemon_domain(). 

> > > Is this process running within a vserver?
> > > Is the process running as
> > > root?  Does it have the necessary capabilities to send audit messages?
> >
> > 
> > I forgot to write -Z (--context), after "ps auxZ | grep bus", I see this:
> > 
> > root:system_r:dbusd_t           dbus     21879  0.0  0.3 10508  968 ?        
> > Ssl  Oct23   0:00 dbus-daemon-1 --system
> > 
> > So runs as root.
> 
> So it is the system bus.  So it should be able to generate
> the audit messages.  Possibly it lacks the following permissions:
>         allow dbusd_t self:capability { audit_write };
>         allow dbusd_t self:netlink_audit_socket { create read write
> nlmsg_relay };

The second "allow" was in my policy, I have added the first (audit_write) and 
I see the same message:

Oct 25 07:57:27 cnsu dbus: Can't send to audit system: USER_AVC pid=26679 
uid=81 loginuid=-1 message=avc:  0 AV entries and 0/512 buckets used, 
longestchain length 0

#---------------------------------------------------------------

I am trying to understand the "denied messages" to avoid to use allow with 
unconfined. For example the following:

Oct 25 08:02:37 cnsu kernel: audit(1161763357.211:1434): avc:  denied  
{ search } for  pid=30655 comm="ls" name="util-vserver" dev=hda5 ino=208827 
scontext=root:system_r:unconfined_t 
tcontext=system_u:object_r:vserver_utils_t tclass=dir

Oct 25 08:02:37 cnsu kernel: audit(1161763357.239:1435): avc:  denied  
{ getattr } for  pid=30655 comm="ls" name="vserver-wrapper" dev=hda5 
ino=208979 scontext=root:system_r:unconfined_t 
tcontext=system_u:object_r:vserver_utils_t tclass=file

In the first denied, ino=208827 is a node that, after execute "find / -inum 
208827" I see that corresponds with the following 
directory: /usr/lib/util-vserver that is labelled with 
"system_u:object_r:vserver_utils_t", it is not unconfined. So, the denied 
message says the process with pid 30655 (that I don't know who is it because 
when I execute "ps -e | grep 30655" nothing appears) from the unconfined 
domain, executes "ls" over the directory "/usr/lib/util-vserver" and have not 
the rights to search in directories labelled with vserver_utils_t. Did I 
interpretate right the denied? What can I do to avoid this denied without 
write:
    allow unconfined_t vserver_utils_t:dir { search };
    allow unconfined_t vserver_utils_t:file { getattr }


Something that for me is strange is that the "find -inum NUMBER" sometimes 
reports me more than one files/directories for the same ino number, can that 
happen?

Another thing that I don't understand is, why the unconfined domain ask for 
some new permissions like:
     allow unconfined_t crontab_exec_t:file getattr;
I thought unconfined is free to do everything.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
