Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j591o1gA007422
	for <selinux@tycho.nsa.gov>; Wed, 8 Jun 2005 21:50:01 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j591gGD5008557
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 01:42:16 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 643DBAEF83
	for <selinux@tycho.nsa.gov>; Thu,  9 Jun 2005 02:03:30 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22929-04 for <selinux@tycho.nsa.gov>;
 Thu,  9 Jun 2005 02:03:28 +0100 (BST)
Received: from [192.168.0.1] (unknown [81.1.89.213])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 3BC80AEF82
	for <selinux@tycho.nsa.gov>; Thu,  9 Jun 2005 02:03:28 +0100 (BST)
Subject: general selinux questions
From: antoine <antoine@nagafix.co.uk>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 02:50:58 +0100
Message-Id: <1118281858.9481.4.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
apologies if this is not the correct mailing list for these questions.
Also, I am fairly new to selinux.

The setup in question: Gentoo64 system (2004.1), running on an Opteron
box, custom 2.6.11.11 kernel with selinux in permissive mode.

1) I've labelled some of my cron scripts with a specific type to allow
them to do things like ping, then I added:
	domain_auto_trans(system_crond_t, mycron_exec_t, mycron_t)
so that these scripts run in mycron_t domain, then
	domain_auto_trans(mycron_t, ping_exec_t, ping_t)
so that a script in mycron_t can run ping_t (I omitted the rest)

It stopped complaining about so many things (mainly network) but I still
get these messages:
audit(1118170810.570:0): avc:  denied  { read } for  pid=27056
exe=/bin/ping path=pipe:[477173] dev=pipefs ino=477173
scontext=system_u:system_r:ping_t tcontext=system_u:system_r:crond_t
tclass=fifo_file
audit(1118170810.570:0): avc:  denied  { write } for  pid=27056
exe=/bin/ping path=pipe:[477174] dev=pipefs ino=477174
scontext=system_u:system_r:ping_t tcontext=system_u:system_r:crond_t
tclass=fifo_file
audit(1118174404.518:0): avc:  denied  { read } for  pid=29150
exe=/bin/ping path=pipe:[482483] dev=pipefs ino=482483
scontext=system_u:system_r:ping_t tcontext=system_u:system_r:crond_t
tclass=fifo_file
audit(1118174404.518:0): avc:  denied  { append } for  pid=29150
exe=/bin/ping path=/tmp/tmp.j5fwDc dev=tmpfs ino=484140
scontext=system_u:system_r:ping_t tcontext=system_u:object_r:tmpfs_t
tclass=file
audit(1118174404.518:0): avc:  denied  { write } for  pid=29150
exe=/bin/ping path=pipe:[482484] dev=pipefs ino=482484
scontext=system_u:system_r:ping_t tcontext=system_u:system_r:crond_t
tclass=fifo_file
audit(1118174404.519:0): avc:  denied  { getattr } for  pid=29150
exe=/bin/ping path=/tmp/tmp.j5fwDc dev=tmpfs ino=484140
scontext=system_u:system_r:ping_t tcontext=system_u:object_r:tmpfs_t
tclass=file
audit(1118174404.519:0): avc:  denied  { ioctl } for  pid=29150
exe=/bin/ping path=/tmp/tmp.j5fwDc dev=tmpfs ino=484140
scontext=system_u:system_r:ping_t tcontext=system_u:object_r:tmpfs_t
tclass=file

The ping used is:
ping -w 10 -W 10 -i 1 -c 2 -I $IFACE $IP

Which could be allowed by this:
allow ping_t crond_t:fifo_file { read write };
allow ping_t tmpfs_t:file { append getattr ioctl };
But why would I need to change the definition for crond_t? If anything
it should be for mycron_t? Also, why does ping_t need to use /tmp if it
is not in the default policy file?


2) Is there any online documentation on what all the macros do?
It would be a lot easier to be able to take the output from audit2allow
and know which parts map to which macro (can_network, uses_shlib, etc)
I'd prefer using google to look it up than vi ./macros/*
The closest pointer I found is on this page:
http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/selinux-guide/rhlcommon-section-0053.html
but it is still largely a manual process. I understand that being
macros, a full text search cannot guarantee accuracy, but for most cases
it would do the (painful) work for me. Can't we generate documentation
with typical examples automatically? Or write a command line tools (or
scripts) for performing these operations?

3) A lot of my current services are chrooted, labelling files in the
chroot seems to be a little bit difficult: I would like to re-use the
same label used outside the chroot (ie: etc_t for chroot/(.*)/etc(/.*)*)
but when I do, setfiles complains: "Operation not permitted". (-d tells
you what you would have expected it to do, but not what went wrong) - I
want to find which rule makes this illegal.

4) If I run ssh on a non-standard port, I need to tweak net_contexts,
what is the preferred place for keeping these settings? Generally
speaking, how do you maintain local customisations of the core policies?

5) If one of my script needs to restart a service (like apache) what do
I need to do to make it run without authentication. (run_init requires
authentication - do I just allow a transition to initrc_t? I haven't
tested this yet)

6) Can someone explain in layman's terms what needs to be fixed to get
rid of warnings like:
"security:  context system_u:system_r:[domain_t] is invalid"
What is missing from my policy for [domain_t]? Assuming [domain_t] can
be entered from initrc_t or sysadm_t for example, and that I have
domain_auto_trans(initrc_t, [domain_bin_t], [domain_t]) +same for sysadm

Thanks
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
