Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i56NZLrT000797
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 19:35:21 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i56NZFRQ016121
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 19:35:17 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: fireflier (cool firewall program) policy files
Date: Mon, 7 Jun 2004 09:35:10 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040606161333.GI10890@lkcl.net>
In-Reply-To: <20040606161333.GI10890@lkcl.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uo6wAt5z8BJkMhH"
Message-Id: <200406070935.10880.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_uo6wAt5z8BJkMhH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 7 Jun 2004 02:13, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> fireflier is a client-server architecture firewall program that uses
> ip queueing to block packets until you've approved or rejected them.
>
> only used it the once and love it already: you can set it to approve
> packets on a per-program-name basis as well which i persn'y really
> like.
>
> my bug-bear with the program and the corresponding policy i had to
> create is that it demands to know the names of all programs it
> could possibly want to tell you about, and so it does a quite
> extensive directory search.
>
> therefore i added the last two lines as an "afterthought".

I've attached a version with some suggested changes.

Having two types fireflier_etc_t and fireflier_conf_t which are both writable 
by the daemon seems to provide no benefit.

Allowing iptables to be executed in the same domain is a bad idea, it should 
run in it's own domain (and fireflier_t can probably lose some permissions as 
a result).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_uo6wAt5z8BJkMhH
Content-Type: text/plain;
  charset="iso-8859-1";
  name="fireflier.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fireflier.te"

#DESC FireFlier - Firewall Server
#
# Author:  Luke Kenneth Casson Leighton <lkcl@lkcl.net>
# X-Debian-Packages: fireflier-server, fireflier-client-kde
#


daemon_domain(fireflier)

can_network(fireflier_t)
logdir_domain(fireflier)

type fireflier_conf_t, file_type, sysadmfile;
type fireflier_etc_t, file_type, sysadmfile;
type fireflier_var_lib_t, file_type, sysadmfile;

domain_auto_trans(initrc_t, fireflier_exec_t, fireflier_t)

#allow fireflier_t self:capability { net_admin net_bind_service };
file_type_auto_trans(fireflier_t, etc_t, fireflier_etc_t, file)
file_type_auto_trans(fireflier_t, fireflier_etc_t, fireflier_conf_t, file)
file_type_auto_trans(fireflier_t, var_run_t, fireflier_var_run_t, sock_file)
file_type_auto_trans(fireflier_t, var_lib_t, fireflier_var_lib_t, file)

# startup script /etc/init.d/fireflier needs to read the config file
allow initrc_t fireflier_conf_t:file { getattr read };

allow fireflier_t self:unix_dgram_socket create_socket_perms;
allow fireflier_t self:netlink_socket { create bind write read getattr };
allow fireflier_t self:unix_stream_socket create_stream_socket_perms;
allow fireflier_t port_t:tcp_socket name_bind;

allow fireflier_t { sbin_t bin_t }:dir search;
domain_auto_trans(fireflier_t, iptables_exec_t, iptables_t)
allow fireflier_t var_lib_t:dir search;
allow fireflier_t bin_t:lnk_file read;
can_exec(fireflier_t, shell_exec_t)

allow fireflier_t self:capability { net_admin net_raw };

allow fireflier_t etc_runtime_t:file { read getattr };
allow fireflier_t etc_t:file { getattr read };
allow fireflier_t proc_t:file { read getattr };

allow fireflier_t fireflier_var_lib_t:dir { add_name search write };

allow fireflier_t self:rawip_socket { create getopt setopt };
allow fireflier_t sysctl_modprobe_t:file { getattr read };

# this is *sigh* to allow the daemon to read program names
# so that it can tell users what program is doing network access.
allow fireflier_t exec_type:file { getattr read };


--Boundary-00=_uo6wAt5z8BJkMhH--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
