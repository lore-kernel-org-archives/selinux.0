Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA26185
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 17:00:52 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA26313
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 21:59:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA26309
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 21:59:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: ntp policy
Date: Wed, 20 Mar 2002 23:00:39 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203201553140.11981-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203201553140.11981-100000@raven>
MIME-Version: 1.0
Message-Id: <20020320220040.E4147419EC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Mar 2002 22:01, Stephen Smalley wrote:
> On Wed, 20 Mar 2002, Russell Coker wrote:
> > I've attached the ntp.te file.
>
> Thanks.  A few comments and questions below.
>
> >allow ntpd_t root_t:dir r_dir_perms;
>
> This rule can probably be generalized and moved into uses_shlib as well,
> as you've done with the lib_t permissions.  Probably usr_t as well
> to pick up /usr/lib.

What about the following:
#################################
#
# uses_shlib(domain)
#
# Permissions for using shared libraries.
#
define(`uses_shlib',`
allow $1 { root_t usr_t var_t }:dir r_dir_perms;
allow $1 ld_so_t:file rx_file_perms;
allow $1 ld_so_t:file execute_no_trans;
allow $1 ld_so_t:lnk_file r_file_perms;
allow $1 shlib_t:file rx_file_perms;
allow $1 shlib_t:lnk_file r_file_perms;
allow $1 ld_so_cache_t:file r_file_perms;
allow $1 lib_t:dir r_dir_perms;
allow $1 lib_t:file rx_file_perms;
')

#################################
#
# uses_base_bins(domain)
#
# Permissions for running basic programs
#
define(`uses_base_bins',`
uses_shlib($1)
allow $1 bin_t:dir r_dir_perms;
allow $1 bin_t:{ file lnk_file } r_file_perms;
')dnl

Then we can have some other macros which use uses_base_bins (which probably 
isn't a good name) and add extra functionality of executing shells or sbin_t.

How about the following for defining domains for daemons:
define(`daemon_domain', `
type $1_t, domain, privlog;
type $1_exec_t, file_type, sysadmfile, exec_type;

role system_r types $1_t;

domain_auto_trans(initrc_t, $1_exec_t, $1_t)

# Inherit and use descriptors from init.
allow $1_t { init_t newrole_t }:fd inherit_fd_perms;
allow $1_t { init_t newrole_t }:process sigchld;
allow $1_t self:process signal;

uses_shlib($1_t)

# Create pid file.
type var_run_$1_t, file_type, sysadmfile, pidfile;
file_type_auto_trans($1_t, var_run_t, var_run_$1_t)

allow $1_t self:process fork;
')dnl

> >allow ntpd_t domain:packet_socket recvfrom;
>
> Does ntpd truly need the ability to receive from any domain?

Not certain, I'll have to look into it again.

> >allow ntpd_t self:unix_dgram_socket create_socket_perms;
>
> What domains need to be able to send to this socket?

Only itself apparently, here's the log:
Mar 20 22:57:53 lyta kernel: avc:  denied  { create } for  pid=18529 
exe=/usr/sbin/ntpd scontext=system_u:system_r:ntpd_t 
tcontext=system_u:system_r:ntpd_t tclass=unix_dgram_socket
Mar 20 22:57:53 lyta kernel: avc:  denied  { connect } for  pid=18529 
exe=/usr/sbin/ntpd scontext=system_u:system_r:ntpd_t 
tcontext=system_u:system_r:ntpd_t tclass=unix_dgram_socket
Mar 20 22:57:53 lyta kernel: avc:  denied  { write } for  pid=18529 
exe=/usr/sbin/ntpd scontext=system_u:system_r:ntpd_t 
tcontext=system_u:system_r:ntpd_t tclass=unix_dgram_socket

> >allow ntpd_t self:process fork;
>
> Might ntpd need the ability to signal forked copies of itself?

Good point, I guess so.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
