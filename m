Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2DRbXZ005094
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 08:27:39 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2DRXAw016501
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 13:27:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
Date: Wed, 3 Nov 2004 00:27:28 +1100
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de> <1099078308.12321.96.camel@moss-lions.epoch.ncsc.mil> <418661C8.8000801@redhat.com>
In-Reply-To: <418661C8.8000801@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411030027.28875.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Nov 2004 03:18, Daniel J Walsh <dwalsh@redhat.com> wrote:

+allow crond_t self:{ tcp_socket udp_socket } connect;

crond.te has no can_network() invocation.  Maybe we should have the following 
in the definition of uncond_can_ypbind():
allow $1 self:{ tcp_socket udp_socket } connect;

It seems that cnan_ypbind() is the only network use in crond.te.


-allow dictd_t self:capability { setuid setgid };
+allow dictd_t self:capability { setuid setgid net_bind_service };

dictd_t is not permitted to bind to any low ports.  How does it need 
net_bind_service capability?

+allow hald_t { device_t }:{ chr_file } { create_file_perms };

Three sets of redundant braces.  Why does it need to create character device 
nodes anyway?  We have udev to do that!

+file_type_auto_trans(kudzu_t, tmp_t, kudzu_tmp_t, chr_file)

Why is kudzu creating device nodes under /tmp?  This sounds like a bug in 
kudzu to me.

+dontaudit mailman_queue_t src_t:dir { search };

I've filed a bugzilla about that one:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=137863

We should have ifdef(`hide_broken_symptoms', around it too.

-allow mysqld_t self:capability { dac_override setgid setuid };
+allow mysqld_t self:capability { dac_override setgid setuid 
net_bind_service };

Why does mysqld_t need name_bind_service?  It doesn't seem to be allowed to 
bind to any low ports anyway.

-allow postfix_$1_t self:capability { setuid setgid dac_override };
+allow postfix_$1_t self:capability { setuid setgid dac_override 
net_bind_service };

What is this for?  Which Postfix programs need such access?  Maybe you should 
have net_bind_service inside the can_ypbind() macro or something.  Normal 
Postfix operation does not need such a change.

-allow radiusd_t self:capability { chown dac_override fsetid kill setgid 
setuid sys_resource sys_tty_config };
+allow radiusd_t self:capability { chown dac_override fsetid kill setgid 
setuid sys_resource sys_tty_config net_bind_service };

Once again, this should not be needed.


If every instance of daemon_domain() is going to get nscd_client_domain added, 
then perhaps we should just change the definition of daemon_domain() 
accordingly?


Why isn't allow $1 self:{ tcp_socket udp_socket } connect; in can_network()?



I think that some structural changes need to be made before any of the changes 
in this can go in the CVS.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
