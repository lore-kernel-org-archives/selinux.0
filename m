Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5A6K7gA016227
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 02:20:08 -0400 (EDT)
Received: from smtp.hivsa.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5A6Bv1O025260
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 06:12:07 GMT
Subject: Re: general selinux questions
From: Jayendren Anand Maduray <jayendren@hivsa.com>
Reply-To: jayendren@hivsa.com
To: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118319901.10190.25.camel@localhost>
References: <1118281858.9481.4.camel@localhost>
	 <1118319901.10190.25.camel@localhost>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 08:11:26 +0000
Message-Id: <1118391086.4239.1.camel@shiva>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!
I am looking to start coding in SELinux.
What are the perquisites and what media should i look into?

God bless.

On Thu, 2005-06-09 at 13:25 +0100, antoine wrote:
> Some more questions:
> 7) What can I do to logrotate.te to make it rotate my mysql logfiles but
> have the correct label on the new /var/log/mysql/mysql.log file. As it
> is now it comes up as var_log_t rather than mysql_var_log_t
> 
> 8) How can I allow daemons to write to /dev/log?
> allow psad_t devlog_t:sock_file write;
> Is not allowed...
> 
> 9) One of my scripts needs to kill a few processes by name (if they
> exist) so it does something like 'ps -ef | grep "someLongUniqueString in
> processName"' but that triggers all sorts of violations. Is there a
> better way?
> 
> Thanks
> Antoine
> 
> 
> 
> On Thu, 2005-06-09 at 02:50 +0100, antoine wrote:
> > Hi,
> > apologies if this is not the correct mailing list for these questions.
> > Also, I am fairly new to selinux.
> > 
> > The setup in question: Gentoo64 system (2004.1), running on an Opteron
> > box, custom 2.6.11.11 kernel with selinux in permissive mode.
> > 
> > 1) I've labelled some of my cron scripts with a specific type to allow
> > them to do things like ping, then I added:
> > 	domain_auto_trans(system_crond_t, mycron_exec_t, mycron_t)
> > so that these scripts run in mycron_t domain, then
> > 	domain_auto_trans(mycron_t, ping_exec_t, ping_t)
> > so that a script in mycron_t can run ping_t (I omitted the rest)
> > 
> > It stopped complaining about so many things (mainly network) but I still
> > get these messages:
> > audit(1118170810.570:0): avc:  denied  { read } for  pid=27056
> > exe=/bin/ping path=pipe:[477173] dev=pipefs ino=477173
> > scontext=system_u:system_r:ping_t tcontext=system_u:system_r:crond_t
> > tclass=fifo_file
> > audit(1118170810.570:0): avc:  denied  { write } for  pid=27056
> > exe=/bin/ping path=pipe:[477174] dev=pipefs ino=477174
> > scontext=system_u:system_r:ping_t tcontext=system_u:system_r:crond_t
> > tclass=fifo_file
> > audit(1118174404.518:0): avc:  denied  { read } for  pid=29150
> > exe=/bin/ping path=pipe:[482483] dev=pipefs ino=482483
> > scontext=system_u:system_r:ping_t tcontext=system_u:system_r:crond_t
> > tclass=fifo_file
> > audit(1118174404.518:0): avc:  denied  { append } for  pid=29150
> > exe=/bin/ping path=/tmp/tmp.j5fwDc dev=tmpfs ino=484140
> > scontext=system_u:system_r:ping_t tcontext=system_u:object_r:tmpfs_t
> > tclass=file
> > audit(1118174404.518:0): avc:  denied  { write } for  pid=29150
> > exe=/bin/ping path=pipe:[482484] dev=pipefs ino=482484
> > scontext=system_u:system_r:ping_t tcontext=system_u:system_r:crond_t
> > tclass=fifo_file
> > audit(1118174404.519:0): avc:  denied  { getattr } for  pid=29150
> > exe=/bin/ping path=/tmp/tmp.j5fwDc dev=tmpfs ino=484140
> > scontext=system_u:system_r:ping_t tcontext=system_u:object_r:tmpfs_t
> > tclass=file
> > audit(1118174404.519:0): avc:  denied  { ioctl } for  pid=29150
> > exe=/bin/ping path=/tmp/tmp.j5fwDc dev=tmpfs ino=484140
> > scontext=system_u:system_r:ping_t tcontext=system_u:object_r:tmpfs_t
> > tclass=file
> > 
> > The ping used is:
> > ping -w 10 -W 10 -i 1 -c 2 -I $IFACE $IP
> > 
> > Which could be allowed by this:
> > allow ping_t crond_t:fifo_file { read write };
> > allow ping_t tmpfs_t:file { append getattr ioctl };
> > But why would I need to change the definition for crond_t? If anything
> > it should be for mycron_t? Also, why does ping_t need to use /tmp if it
> > is not in the default policy file?
> > 
> > 
> > 2) Is there any online documentation on what all the macros do?
> > It would be a lot easier to be able to take the output from audit2allow
> > and know which parts map to which macro (can_network, uses_shlib, etc)
> > I'd prefer using google to look it up than vi ./macros/*
> > The closest pointer I found is on this page:
> > http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/selinux-guide/rhlcommon-section-0053.html
> > but it is still largely a manual process. I understand that being
> > macros, a full text search cannot guarantee accuracy, but for most cases
> > it would do the (painful) work for me. Can't we generate documentation
> > with typical examples automatically? Or write a command line tools (or
> > scripts) for performing these operations?
> > 
> > 3) A lot of my current services are chrooted, labelling files in the
> > chroot seems to be a little bit difficult: I would like to re-use the
> > same label used outside the chroot (ie: etc_t for chroot/(.*)/etc(/.*)*)
> > but when I do, setfiles complains: "Operation not permitted". (-d tells
> > you what you would have expected it to do, but not what went wrong) - I
> > want to find which rule makes this illegal.
> > 
> > 4) If I run ssh on a non-standard port, I need to tweak net_contexts,
> > what is the preferred place for keeping these settings? Generally
> > speaking, how do you maintain local customisations of the core policies?
> > 
> > 5) If one of my script needs to restart a service (like apache) what do
> > I need to do to make it run without authentication. (run_init requires
> > authentication - do I just allow a transition to initrc_t? I haven't
> > tested this yet)
> > 
> > 6) Can someone explain in layman's terms what needs to be fixed to get
> > rid of warnings like:
> > "security:  context system_u:system_r:[domain_t] is invalid"
> > What is missing from my policy for [domain_t]? Assuming [domain_t] can
> > be entered from initrc_t or sysadm_t for example, and that I have
> > domain_auto_trans(initrc_t, [domain_bin_t], [domain_t]) +same for sysadm
> > 
> > Thanks
> > Antoine
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Jayendren Anand Maduray
Microsoft Certified Professional
Network Plus
IT Administrator

Perinatal HIV Research Unit
Old Potch Road
Chris Hani Baragwanath Hospital
Soweto
South Africa

Tel: +27 11 989 9776
Tel: +27 11 989 9999
Fax: +27 11 938 3973
Cel: 082 22 774 94

Alternate email address: jayendren@mweb.co.za


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
