Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3OB0bI4007253
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 07:00:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3OB0VVf015345
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 11:00:32 GMT
Received: from narya.grin.hu (adsl-vip-1.tvnet.hu [195.38.117.96])
	by jazzswing.ncsc.mil  with ESMTP id h3OB0S4D015336
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 11:00:29 GMT
Received: from grin by narya.grin.hu with local (Exim 3.36 #1 (Debian))
	id 198eSd-0004ae-00
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 13:00:15 +0200
Date: Thu, 24 Apr 2003 13:00:15 +0200
From: Peter Gervai <grin@tolna.net>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: several wee things about exim and macros (was: please offer your good advices...)
Message-ID: <20030424110015.GJ2556@narya.grin.hu>
Reply-To: grin@tolna.net
References: <20030423111231.GV3993@narya.grin.hu> <200304241329.03351.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200304241329.03351.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 24, 2003 at 01:29:03PM +1000, Russell Coker wrote:
> In regard to your policy patch:
> +# run init scripts? valid? secure?? --<g>
> +#domain_auto_trans(sysadm_t, etc_t, initrc_t)
> 
> Not secure as it may allow the administrator to be tricked into running the 
> daemon.  Also it does not allow role transition to system_r and the daemon 
> domains would need to be allowed to be in sysadm_r, and it would have the 
> daemons running with the identity of the administrative user (bad idea).

I miss a FAQ in regards of utilities (and, in fact, in the next few days I
hope to be able to browse through the last months of the mailing list and
distill the answers), in this case run_init. I wasn't aware of its
existence, and thus I was unable to figure out what is the way to start the
daemons. 

Disregard the foul try I did up there. Correct way is (I s'ppose) to do

run_init /etc/init.d/exim start

> +# can start exim --<g>
> +ifdef(`exim.te', `
> +domain_auto_trans_read(dhcpc_t, exim_exec_t, exim_t)
> +')
> I don't think that this is the right way to do it. 

This was another hopeless try. Doesn't work anyway.

> On my laptop I have a 
> script running as system_u:system_r:initrc_t that listens on a named pipe.  
> When an IP address is assigned then that script is informed by the pipe and 
> it will start the necessary daemons.

problem is that - as I mentioned in my email last week to you - dhcpcd does
_not_ start anything. like:

  116    298 system_u:system_r:dhcpc_t                [dhclient]
  199    303 system_u:system_r:syslogd_t              [syslogd]
  202    304 system_u:system_r:klogd_t                [klogd]
  216    307 system_u:system_r:httpd_t                [apache2]
  218    307 system_u:system_r:httpd_t                 \_ [apache2]
  219    307 system_u:system_r:httpd_t                 \_ [apache2]
[...]
  228    309 system_u:system_r:dovecot_master_t       [dovecot]
  245    313 system_u:system_r:dovecot_authdaemon_t    \_ [dovecot-auth]
  246    314 system_u:system_r:dovecot_imap_t          \_ [imap-login]
  247    314 system_u:system_r:dovecot_imap_t          \_ [imap-login]
  248    314 system_u:system_r:dovecot_imap_t          \_ [imap-login]
  250    315 system_u:system_r:dovecot_pop_t           \_ [pop3-login]
  251    315 system_u:system_r:dovecot_pop_t           \_ [pop3-login]
  252    315 system_u:system_r:dovecot_pop_t           \_ [pop3-login]
  234    310 system_u:system_r:inetd_t                [inetd]
  241    312 system_u:system_r:sshd_t                 [sshd]
 5584    312 system_u:system_r:sshd_t                  \_ [sshd]
[...]

it is no way related to the processes, but still receives the packet_socket
recv events for everybody. As far as I know the startup goes on initrc_t,
starts dhcpcd, it obtains IP address, then the system goes on and starts
other rc.d scripts, including exim, apache, whatever. And still, dhcpcd gets
the receive events because it somehow "owns"(???) the interface. (Can I see
contexts of the interfaces? ...if there is such a thing.)

> -/var/run/dhclient\.pid         system_u:object_r:var_run_dhcpc_t
> +/var/run/dhclient\.(.+\.)?pid          system_u:object_r:var_run_dhcpc_t
> What does this do?

grin@latyak:~$ ls -la --con /var/run/dh*
-rw-r--r--  root     root     system_u:object_r:var_run_dhcpc_t /var/run/dhclient.eth0.pid

> For port 53, I think that having the name always be named_port_t is the 
> correct thing to do.  It allows the possibility of running two different DNS 
> servers on different IP addresses, and also allows having the policy for 
> multiple DNS servers to be loaded at the same time to allow an easy 
> transition between server programs.  I suggest doing what was done for the 
> POP port.

Sounds logical, I'll change the policy as time permits. However I'd like to
note that port 53 is called 'domain' by /etc/services, and not 'named'.

Peter

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
