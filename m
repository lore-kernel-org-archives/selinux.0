Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2BH3iDo008809
	for <selinux@tycho.nsa.gov>; Fri, 11 Mar 2005 12:03:45 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2BGwVP0023877
	for <selinux@tycho.nsa.gov>; Fri, 11 Mar 2005 16:58:32 GMT
Date: Fri, 11 Mar 2005 17:07:48 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
Subject: Re: Policy for giFT p2p
Message-ID: <20050311170747.GE8481@lkcl.net>
References: <1110246204.20298.10.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1110246204.20298.10.camel@cobra.ivg2.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

great!  i also use giftd, with apollon.

does it work if the giftd daemon has already been launched?

what happens if i run the giftd daemon manually and _then_
run say apollon?

also remember apollon is one of the gift front-ends.

l.

On Mon, Mar 07, 2005 at 08:43:20PM -0500, Ivan Gyurdiev wrote:
> The following makes the giFT peer to peer software work without denials
> on strict selinux. It is a plugin-based app that lets you connect
> to various p2p networks at the same time. It is currently not part
> of Fedora Core (or Extras), but I use it all the time.
> 
> Instantiate with this:
> gift_domains(user)
> gift_domains(staff)
> gift_domains(sysadm)
> 
> Any complaints? 
> 
> The .fc file obviously needs to be tuned for rpm distribution - 
> I believe there are rpm packages of this out there. 
> If not, maybe I'll write some. 
> 
> This is against selinux-policy-strict-sources-1.21.15-6 
> on Fedora Rawhide. 
> 
> -- 
> Ivan Gyurdiev <ivg2@cornell.edu>
> Cornell University

> /usr/local/bin/giftd	--	system_u:object_r:giftd_exec_t
> /usr/local/bin/giftui	-- 	system_u:object_r:gift_exec_t
> HOME_DIR/\.giFT(/.*)?		system_u:object_r:ROLE_gift_home_t

> #
> # Macros for giFT
> #
> # Author: Ivan Gyurdiev <ivg2@cornell.edu>
> #
> # gift_domains(domain_prefix)
> # declares a domain for giftui and giftd
> 
> #########################
> #  gift_domain(user)    #
> #########################
> 
> define(`gift_domain', `
> 
> # Connect to X
> x_client_domain($1, gift, `')	
> 
> # Transition
> domain_auto_trans($1_t, gift_exec_t, $1_gift_t)
> can_exec($1_gift_t, gift_exec_t)
> role $1_r types $1_gift_t;
> 
> # Self permissions
> allow $1_gift_t self:process getsched;
> 
> # Home files
> home_domain($1, gift)
> 
> # Fonts, icons
> r_dir_file($1_gift_t, usr_t)
> r_dir_file($1_gift_t, fonts_t)
> 
> # Launch gift daemon
> allow $1_gift_t self:process fork;
> domain_auto_trans($1_gift_t, giftd_exec_t, $1_giftd_t)
> 
> # Connect to gift daemon
> can_network($1_gift_t)
> 
> # Read /proc/meminfo
> allow $1_gift_t proc_t:dir search;
> allow $1_gift_t proc_t:file { getattr read };
> 
> # Tmp/ORBit
> tmp_domain($1_gift)
> file_type_auto_trans($1_gift_t, $1_tmp_t, $1_gift_tmp_t)
> can_unix_connect($1_t, $1_gift_t)
> can_unix_connect($1_gift_t, $1_t)
> allow $1_t $1_gift_tmp_t:sock_file write;
> allow $1_gift_t $1_tmp_t:file { getattr read write lock };
> allow $1_gift_t $1_tmp_t:sock_file { read write };
> dontaudit $1_gift_t $1_tmp_t:dir setattr;
> 
> # Access random device
> allow $1_gift_t urandom_device_t:chr_file { read getattr ioctl };
> 
> # giftui looks in .icons, .themes, .fonts-cache.
> dontaudit $1_gift_t $1_home_t:dir { getattr read search };
> dontaudit $1_gift_t $1_home_t:file { getattr read };
> 
> ') dnl gift_domain
> 
> ##########################
> #  giftd_domain(user)    #
> ##########################
> 
> define(`giftd_domain', `
> 
> type $1_giftd_t, domain;
> 
> # Transition from user type
> domain_auto_trans($1_t, giftd_exec_t, $1_giftd_t)
> role $1_r types $1_giftd_t;
> 
> # Self permissions, allow fork
> allow $1_giftd_t self:process { fork signal sigchld setsched };
> allow $1_giftd_t self:unix_stream_socket create_socket_perms;
> 
> read_sysctl($1_giftd_t)
> read_locale($1_giftd_t)
> uses_shlib($1_giftd_t)
> 
> # Access home domain
> home_domain_access($1_giftd_t, $1, gift)
> 	
> # Allow networking
> allow $1_giftd_t port_t:tcp_socket name_bind;
> allow $1_giftd_t port_t:udp_socket name_bind;
> can_network_server($1_giftd_t)
> can_network_client($1_giftd_t)
> 
> # FIXME: ???
> dontaudit $1_giftd_t self:udp_socket listen;
> 
> # Plugins
> r_dir_file($1_giftd_t, usr_t)
> 
> # Connect to xdm
> ifdef(`xdm.te', `
> allow $1_giftd_t xdm_t:fd use;
> allow $1_giftd_t xdm_t:fifo_file write;
> ') 
> 
> ') dnl giftd_domain
> 
> ##########################
> #  gift_domains(user)    #
> ##########################
> 
> define(`gift_domains', `
> gift_domain($1)
> giftd_domain($1)
> ') dnl gift_domains

> # DESC - giFT file sharing tool
> #
> # Author: Ivan Gyurdiev <ivg2@cornell.edu>
> #
> 
> type gift_exec_t, file_type, exec_type, sysadmfile;
> type giftd_exec_t, file_type, exec_type, sysadmfile;
> 
> # Everything else is in macros/gift_macros.te


-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
