Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6GBmWrT028530
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 07:48:32 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6GBm8bx003150
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 11:48:09 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 7B453C4C09A
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 13:48:25 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 21176-05 for <selinux@tycho.nsa.gov>;
	Fri, 16 Jul 2004 13:48:24 +0200 (CEST)
Date: Fri, 16 Jul 2004 13:48:24 +0200
From: Erich Schubert <erich@debian.org>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux Policy patches
Message-ID: <20040716114824.GB25607@legolas.drinsama.de>
References: <20040716002210.GA1081@wintermute.xmldesign.de> <200407161234.03434.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200407161234.03434.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

BTW: can someone tell the listmaster's admins that their network is
misconfigured, the list server is not reachable with ECN enabled.

> > # can be a link, too - maybe dontaudit, since this is the "build" link
> > # in my case, which it does not need to read...
> > allow initrc_t modules_object_t:lnk_file read;
> 
> I think that dontaudit is the correct thing to do.

For me for sure, but maybe someone else has a case where this does make
sense? OTOH: modules are small and should reside on the primary
partition. One should copy them there, not link them.

> > # spamd going for a link in the perl dirs (5.8 -> 5.8.1 or so)
> > allow spamd_t usr_t:lnk_file read;
> 
> OK, I've put it in my tree.

I think there were some more things wron with spamd, but i can't check
now. I think my spamd was unable to read the /etc/spamassassin/local.cf
config file (and probably other spam filter files stored there)

> > # I also added (don't remember what that was needed for):
> > can_exec(logrotate_t, logrotate_exec_t)
> 
> Can you find out what it is needed for?

I'll check, but maybe this is gone by now, too.

> > # Newer versions of pppd can update the utmp file:
> > allow pppd_t initrc_var_run_t:file rw_file_perms;
> 
> Is it really updating the utmp file or just inappropriately opening the file 
> read/write for a read operation?  Please tell me where this is documented.

Oh, sorry. Actually this belongs to pptpd. It is a pppd plugin included
with pptpd that stores the remote login in wtmp.
pptpd: /usr/lib/pptpd/pptpd-logwtmp.so

Maybe this rules should go into the pptpd.te file then.

> > Then a small change for the file_contexts/program/named.fc
> > -/etc/bind/rndc\.key    --  system_u:object_r:rndc_conf_t
> > +/etc/bind/rndc.*   --  system_u:object_r:rndc_conf_t
> > (debian default installation included rndc.conf i think)
> 
> What version of the package is this?

The config file is not shipped by default, there is only the man page
for it: rdnc.conf and the tool "rndc-confgen" to generate it.
Basically "named.conf" contains the information for named, and
"rndc.conf" contains the remote-control-tool configuration.

> > I have a couple of access violation with applications of
> >   foo var_lib_t:dir search;
> >   foo var_lib_t:lnk_file read;
> > for example syslogd, inetd, postfix_masteri, staff_ssh_t.
> > Should i allow these or use dontaudit, and should i submit patches for
> > such? Is there a known reason for such behaviour?
> 
> What are they trying to access under /var/lib?

I think they just want to scan the directory. I havn't written
additional rules, just the "dir search" and not gotten additional
violations, which surprises me a bit.

> > "amavis.te" is causing two violations (consider dontaudit)
> > # allow amavis to search clamd socket in /var/run/clamav
> > allow amavisd_t clamd_var_run_t:dir search;
> > # cron job trying to search /var/lib/amavis
> > allow crond_t amavisd_lib_t:dir search;
> 
> Brian, what do you think?

Recent versions of clamd in Debian have moved the clamd sockets into a
subdir (see the other changes i submitted). The first is related to
that, amavisd needs to access the new socket location.

I'm not sure what crond_t is doing. I havn't checked if it is the
cron.d/ or the cron.daily/ job, but i think the first.
The inline entry was just checking if the amavis binaries are
executable/existent. (usual thing to do, in case the package gets
uninstalled but the config files remain)

> logdir_domain(clamd) does this.  Added to my tree.

Ah, thanks. BTW: is there a good overview for all these macros and the
proper way to use them?

> > Should i keep such rules in my local.te file, or should i also publish
> > them somehow? Some things like the dhcpd-failover or named-log thing
> > could be of general interest.
> 
> The dhcpd-failover thing sounds useful.

It just two lines, maybe they should be made something like "examples"
or "snippets" kindof. I wouldn't put them in a separate rule file; but i
would also avoid enabling them by default and i dislike modifying the
"upstream" rule files when unneeded.

Maybe the could be added as comments to the dhcpd.te file, kind of

# Copy these lines to your local.te file or uncomment them
# to enable DHCPD failover communication
# allow dhcpd_t port_t:tcp_socket { send_msg recv_msg };
# allow dhcpd_t port_t:tcp_socket name_bind;

Note that there is no standard port for DHCP failover. You can choose an
arbitrary port, making the configuration more difficult.
The example configuration could of course include defining which port is
being used for dhcp-failover and employing dhcp_failover_port_t.
Note that two hosts don't have to use the same port here.
I don't know if SELinux rules also apply for outgoing ports, maybe one
would have to allow dhcpd_t to send to an arbitrary port, but bind only
the local listen port.

I'd like to have a "local.te" file, where i can do thinks like
define(`feature: amavis_uses_ldap')
define(`feature: nss_ldap')
define(`feature: named_dyndns')

to customize rule files without actually changing the files.

> Also for the attached files please send another message describing the
> changes with diffs.

The attached files were new, unless someone submitted the same policies
recently. ;-)

How about adding support for /var/log/named.* ?
It's not enabled by default but i find it very useful, especially if you
have a big amout of logging data such as dynamic DNS updates.
I think it won't do any harm if enabled by default?

Greetings,
Erich
-- 
      erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
    Wenn zwei gute Freunde sind, die einander kennen, Sonn' und Mond   V_/_
     begegnen sich, ehe sie sich trennen. --- Clemens von Brentano

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
