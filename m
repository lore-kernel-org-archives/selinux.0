Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1FKGB6O028405
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 15:16:11 -0500
Received: from dmzmta102.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1FKG4le019047
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 20:16:04 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m1FKEu48032430
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 15:14:57 -0500
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id m1FKEjEu003429
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 15:14:46 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Brindle example of labeled IPSec 
Date: Fri, 15 Feb 2008 12:15:16 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD02AF96FD@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm running the server client example that Joshua Brindle provided in
his article on labeled IPSec.

 
http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinu
x

I'm running this example on a single host using labeled IPSec over the
loopback interface. I've created brindle_server and brindle_client
domains, which I've included at the bottom of this email.

What's confusing are the rules that I did NOT have to provide. 

Here are the rules that I would have expected were required on the
client side, but are missing:
allow brindle_client_t ipsec_spd_t:association polmatch;
allow brindle_client_t brindle_server_t:association recvfrom;

I would expect equivalent rules to be necessary on the server side as
well. However, without these rules, the client and server work fine in
enforcing mode. Here is the output of the server and client:

[mr_clarkson@blade5 test]$ ./brindle_server
server: got connection from 127.0.0.1,
root:staff_r:brindle_client_t:SystemLow-S
ystemHigh

[mr_clarkson@blade5 test]$ ./brindle_client 127.0.0.1
Received: Hello, root:staff_r:brindle_client_t:SystemLow-SystemHigh from
root:staff_r:brindle_server_t:SystemLow-SystemHigh

The output of the client and server show that the labels are being sent
over the loopback, but just to convince myself that the labeled IPSec
loopback was indeed being used, I flushed the SPDs and SADs using
"setkey -FP" and "setkey -F". Afterward, I get the following output,
which is expected when labeled IPSec is not being used:

[mr_clarkson@blade5 test]$ ./brindle_server
getsockopt: Protocol not available
server: got connection from 127.0.0.1, (null)

[mr_clarkson@blade5 test]$ ./brindle_client 127.0.0.1
getpeercon: Protocol not available
Received: Hello, (null) from (null)

I need the missing association rules (shown above) to be able to apply
MLS constraints on the connection between the client and server. Any
suggestions on how to fix this would be greatly appreciated.

I've included the setkey cmds and policy module rules below for
reference.

Here are the setkey cmds that I execute to create the SPDs:
spdflush;
flush;
spdadd 127.0.0.1 127.0.0.1 any
-ctx 1 1 "system_u:object_r:ipsec_spd_t:s0-s4:c0.c255"
-P in ipsec esp/transport//require;
spdadd 127.0.0.1 127.0.0.1 any
-ctx 1 1 "system_u:object_r:ipsec_spd_t:s0-s4:c0.c255"
-P out ipsec esp/transport//require;


contents of brindle_server.te:
------------------------------------------------------------------
policy_module(brindle_server,1.0.0) 

## This module is designed for the brindle_server processes,
## which is a simple server used to test Labeled IPSec

################################
    # Declarations

  type brindle_server_t;
  domain_type(brindle_server_t)

  ## Access to shared libraries
  libs_use_ld_so(brindle_server_t)
  libs_use_shared_libs(brindle_server_t)

  miscfiles_read_localization(brindle_server_t)

  ## Type of the exec, which is the entrypoint into brindle_server_t
  type brindle_server_exec_t;
  files_type(brindle_server_exec_t)
  domain_entry_file(brindle_server_t, brindle_server_exec_t)


  ## allow transitions from staff_t to brindle_server_t
  gen_require(`
    type staff_t;
  ')

  userdom_entry_spec_domtrans_unpriv_users(brindle_server_t)
  domain_auto_trans(staff_t, brindle_server_exec_t, brindle_server_t)

  ## allow brindle_server domain to use sshd file descriptors
  ssh_use_fd(brindle_server_t)

  ## Allow brindle_server domain to use newrole file descriptors. Needed
  ## if we newrole to a new shell before running 
  seutil_use_newrole_fds(brindle_server_t)

  ## allow brindle_server domains to use staff_devpts_t 
  userdom_use_user_terminals(staff, brindle_server_t)

  ## allow brindle_server_t to send a SIGCHLD signal back to the shell
process
  ## to notify the shell that the brindle_server_t child process has
ended
  allow brindle_server_t staff_t:process sigchld;

  fs_search_auto_mountpoints(brindle_server_t)
  files_read_etc_files(brindle_server_t)
  files_search_home(brindle_server_t)
  fs_search_nfs(brindle_server_t)
  files_search_usr(brindle_server_t)

  ## These aren't really needed
  ##allow brindle_server_t security_t:dir search;
  ##allow brindle_server_t security_t:file read;
  selinux_get_enforce_mode(brindle_server_t)
  ##allow brindle_server_t selinux_config_t:dir search;
  ##allow brindle_server_t selinux_config_t:file { read getattr };
  seutil_read_config(brindle_server_t)

  ## Allow TCP networking
  ##allow brindle_server_t inaddr_any_node_t:tcp_socket node_bind;
  corenet_tcp_bind_inaddr_any_node(brindle_server_t)
  allow brindle_server_t self:tcp_socket { bind create setopt accept
listen write getopt};
  ##allow brindle_server_t unlabeled_t:packet { recv send };
  corenet_non_ipsec_sendrecv(brindle_server_t)

  ## role statements
  role staff_r types brindle_server_t;
------------------------------------------------------------------

contents of brindle_client.te:
------------------------------------------------------------------
policy_module(brindle_client,1.0.0) 

## This module is designed for the brindle_client processes,
## which is a simple client used to test Labeled IPSec

################################
    # Declarations

  type brindle_client_t;
  domain_type(brindle_client_t)

  ## Access to shared libraries
  libs_use_ld_so(brindle_client_t)
  libs_use_shared_libs(brindle_client_t)

  miscfiles_read_localization(brindle_client_t)

  ## Type of the exec, which is the entrypoint into brindle_client_t
  type brindle_client_exec_t;
  files_type(brindle_client_exec_t)
  domain_entry_file(brindle_client_t, brindle_client_exec_t)


  ## allow transitions from staff_t to brindle_client_t
  gen_require(`
    type staff_t;
  ')

  userdom_entry_spec_domtrans_unpriv_users(brindle_client_t)
  domain_auto_trans(staff_t, brindle_client_exec_t, brindle_client_t)

  ## allow brindle_client domain to use sshd file descriptors
  ssh_use_fd(brindle_client_t)

  ## Allow brindle_client domain to use newrole file descriptors. Needed
  ## if we newrole to a new shell before running 
  seutil_use_newrole_fds(brindle_client_t)

  ## allow brindle_client domains to use staff_devpts_t 
  userdom_use_user_terminals(staff, brindle_client_t)

  ## allow brindle_client_t to send a SIGCHLD signal back to the shell
process
  ## to notify the shell that the brindle_client_t child process has
ended
  allow brindle_client_t staff_t:process sigchld;

  ## give access to /etc/resolv.conf, which is used to get access to
  ## the DNS
  ##allow brindle_client_t net_conf_t:file { read getattr };
  sysnet_read_config(brindle_client_t)

  fs_search_auto_mountpoints(brindle_client_t)
  files_read_etc_files(brindle_client_t)
  files_search_home(brindle_client_t)
  fs_search_nfs(brindle_client_t)
  files_search_usr(brindle_client_t)

  ## These aren't really needed
  ##allow brindle_client_t security_t:dir search;
  ##allow brindle_client_t security_t:file read;
  selinux_get_enforce_mode(brindle_client_t)
  ##allow brindle_client_t selinux_config_t:dir search;
  ##allow brindle_client_t selinux_config_t:file { read getattr };
  seutil_read_config(brindle_client_t)

  ## Allow TCP networking
  allow brindle_client_t self:tcp_socket { read getopt create connect };
  ##allow brindle_client_t port_t:tcp_socket name_connect;
  corenet_tcp_connect_generic_port(brindle_client_t)
  ##allow brindle_server_t unlabeled_t:packet { recv send };
  corenet_non_ipsec_sendrecv(brindle_client_t)

  ## role statements
  role staff_r types brindle_client_t;
------------------------------------------------------------------



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
