Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9O6mACa004474
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 02:48:10 -0400
Received: from mailgate1.arcor-ip.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9O6ke9b010638
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 06:46:41 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate1.adm.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id 97A6A1D319B
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 08:48:06 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id 0B0FD596E
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 06:48:06 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01905-03 for <selinux@tycho.nsa.gov>;
 Tue, 24 Oct 2006 08:48:03 +0200 (CEST)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id C3BA258A1
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 08:48:03 +0200 (CEST)
From: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
To: selinux@tycho.nsa.gov
Subject: Re: vserver and vprocunhide
Date: Tue, 24 Oct 2006 08:47:58 +0200
References: <200610231751.50609.Daniel.Gil-Mayol@brunel.de> <1161625986.3316.108.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1161625986.3316.108.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200610240847.58333.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain;
  charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Mon, 2006-10-23 at 17:51 +0200, Daniel Gil Mayol wrote:
> > 1.)
> >
> > I have read that vserver and selinux have conflicts, is that true?
>
> Define "conflicts".  You will need to configure SELinux policy
> appropriately, but I'm not aware of any fundamental conflict (e.g. there
> would be a real conflict if vserver used the LSM security fields or
> hooks, but it doesn't AFAIK).

I read that "SELinux conflicts with Linux-VServer. Disable it 
in /etc/selinux/config (SELINUX=disabled)" about CentOS in this link: 
http://oldwiki.linux-vserver.org/CentOS_HowTo

> > I am using a vserver and it tries to access ( to /proc/1 (init)  labelled
> > as unconfined, that means, it tries to {getattr search} over the
> > directory /proc/1 and audit show me a denied. Vprocunhide have a list of
> > directories of /proc to "unhide" for vserver. The problem is that I can't
> > add /proc/1 in vprocunhide (I receive an error when
> > start /etc/init.d/vprocunhide restart). I can't relabel /proc/1 using
> > chcon or setfiles. I can't write
> > "allow vserver_test_t unconfined_t:dir { getattr search };"
> > because there are in assert.te the following neverallow:
> >
> > # Confined domains must never see unconfined domain's /proc/pid entries.
> > neverallow { domain -unrestricted -snmpd_t -pegasus_t }
> >  unconfined_t:dir { getattr search };
> >
> > What I have done is substract also the vserver daemon:
> >
> > neverallow { domain -unrestricted -snmpd_t -pegasus_t -vserver_test}
> >  unconfined_t:dir { getattr search };
> >
> > and then I can write
> >
> > allow vserver_test_t unconfined_t:dir { getattr search };
> >
> > Don't seems very elegant this solution, is the right one?
>
> What are your goals?  Even aside from the question of allowing the
> vserver daemon to access /proc/1, why do you want to unhide /proc/1 in
> the vservers? 
> Enabling a "confined" domain to access the /proc/pid 
> entries of an unconfined domain is naturally undesirable.  You could
> also move init into its own domain (already true in strict policy), so
> that you only have to allow access to init_t and not to all processes in
> unconfined_t, but even there I have to question why you are allowing
> this.

I want to unhide /proc/1 because seems that vserver try to access there:

Oct 24 07:45:55 cnsu kernel: audit(1161675955.340:8577): avc:  denied  
{ search } for  pid=28537 comm="pidof" name="1" dev=proc ino=65538 
scontext=root:system_r:vserver_ids_t tcontext=user_u:system_r:unconfined_t 
tclass=dir
Oct 24 07:45:55 cnsu kernel: audit(1161675955.340:8578): avc:  denied  
{ read } for  pid=28537 comm="pidof" name="stat" dev=proc ino=65550 
scontext=root:system_r:vserver_ids_t tcontext=user_u:system_r:unconfined_t 
tclass=file
Oct 24 07:45:55 cnsu kernel: audit(1161675955.340:8579): avc:  denied  
{ getattr } for  pid=28537 comm="pidof" name="stat" dev=proc ino=65550 
scontext=root:system_r:vserver_ids_t tcontext=user_u:system_r:unconfined_t 
tclass=file
Oct 24 07:45:55 cnsu kernel: audit(1161675955.340:8580): avc:  denied  
{ read } for  pid=28537 comm="pidof" name="exe" dev=proc ino=65545 
scontext=root:system_r:vserver_ids_t tcontext=user_u:system_r:unconfined_t 
tclass=lnk_file
Oct 24 07:46:03 cnsu kernel: audit(1161675963.693:8581): avc:  denied  
{ mounton } for  pid=28738 comm="mount" name="/" dev=hda2 ino=2 
scontext=root:system_r:initrc_t tcontext=system_u:object_r:vprocunhide_t 
tclass=dir

I check which node correspond with ino=65538 with "find /proc -inum 65538" and 
appear "/proc/1";
(for ino=65550  =>  /proc/1/stat)
(for ino=65545  =>  /proc/1/exe)

Move init into its own domain means relabel /proc/1 with for example 'init_t'? 
because I tried but this relabeling had no effect, it is, I have used "chcon 
-t init_t /proc/1/*", doesn't report me any error but after a "ls -Z" I see 
that the labelling haven't been done, is still 
"user_u:system_r:unconfined_t".

I haven't found any definition of type init_t (something like "type 
init_t,..."), but after "sestatus -v" I see this line:
'Init context:           user_u:system_r:unconfined_t'
Should I try to change this init context? How? defining simply "type 
init_t ..."

Could I profit the macro "init_service_domain()"?

> Note btw that there are different ways of configuring SELinux policy in
> your environment:
> - Define a single SELinux domain for each vserver, applied to all
> processes in that vserver (e.g. all processes within vserver X run in
> x_t, all processes within vserver Y run in y_t, ...).  This uses SELinux
> just to reinforce the vserver separation.
> - Define different SELinux domains for different processes within each
> vserver, and use the same set of domains in all vservers (e.g. httpd
> runs in httpd_t in all vservers, and ftpd runs in ftpd_t in all
> vservers).  This uses SELinux just to enforce separation within the
> vservers, not between them.
> - Define different SELinux domains for different processes within each
> vserver, and use orthogonal sets of domains for each vserver (e.g. httpd
> runs in httpd_x_t in vserver X but runs in httpd_y_t in vserver Y, and
> likewise for all other domains).  This uses SELinux to reinforce the
> vserver separation and to enforce separation within each vserver.

I have two vservers: lets says 'vserver_1' and 'vserver_2'. Each one has its 
own labelling for bin and libs ('vserver_1_exec_t',  'vserver_1_lib_t') and 
the rest as 'vserver_1_modules_t' (the same for vserver_2). 
Other services like httpd don't use any specific labelling for each vserver.

> > 2.)
> > Each time I try to restart the vserver daemon:
> >
> > /etc/init.d/vserver_test restart
> >
> > Then I see the following denied message:
> >
> > Oct 23 16:45:02 cnsu kernel: audit(1161621902.211:1167): avc:  denied
> > { mounton } for  pid=9476 comm="mount" name="/" dev=hda2 ino=2
> > scontext=root:system_r:initrc_t tcontext=system_u:object_r:vprocunhide_t
> > tclass=dir
> >
> > and audit2allow writes the next
> >
> > allow initrc_t vprocunhide_t:dir mounton;
> >
> > but when this allow is adedd and I compile I see this message
> >
> > assertion on line 45221 violated by allow initrc_t vprocunhide_t:dir
> > { mounton };
>
> And what was that assertion?  Likely just requires an attribute on
> vprocunhide_t to mark it as a mount point directory.

This line in policy.conf correspond to the following rule:

# for gross mistakes in policy
neverallow domain domain:dir ~{ read getattr lock search ioctl };

that doesn't mention mounton.

> > -------------------------------------------------------------------------
> >---------------------
> >
> > 3.)
> > When I restart the dbus (messagebus) appear the following message.
> >
> > Oct 23 17:50:29 cnsu dbus: Can't send to audit system: USER_AVC pid=21488
> > uid=81 loginuid=-1 message=avc:  0 AV entries and 0/512 buckets used,
> > longestchain length 0
> >
> > It is not a denied, should I try to correct it?
>
> Different kind of error - this means that dbusd could not send an audit
> message to the kernel.  Do you have audit configured into your kernel?

I have check the config-2.6.16.9 file and there is "CONFIG_AUDIT=y", so audit 
is configured into my kernel.

> Is this process running within a vserver?  
> Is the process running as 
> root?  Does it have the necessary capabilities to send audit messages?

After execute "ps aux | grep bus" I see the next:

dbus     21879  0.0  0.3 10508  768 ?        Ssl  Oct23   0:00 dbus-daemon-1 
--system

so it is not running within a vserver, has its own process; 
And appear dbus instead of root, must be root?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
