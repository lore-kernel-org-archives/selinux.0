Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FNthL9012593
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 18:55:43 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FNsVEP022135
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 23:54:31 GMT
Date: Wed, 16 Feb 2005 00:04:37 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>,
   g@lkcl.net
Subject: Re: sshd transition points
Message-ID: <20050216000437.GD30341@lkcl.net>
References: <20050215155323.GC23765@lkcl.net> <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil> <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net> <20050215225329.GH26294@lkcl.net> <20050215231707.GC29523@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050215231707.GC29523@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 15, 2005 at 11:17:07PM +0000, Luke Kenneth Casson Leighton wrote:
> okay.
> 
> i should explain what this patch actually does, shouldn't i? :)
> 
> on a setcon, if you are in context A, and you are endeavouring to
> setcon to context B, then you "automatically" get thrown instead
> into context C.

example:

	to track the privilege-separated process that handles
	a user's networking communications for you, and thereby
	to be able to "ban" a specific user from being able to
	ssh into your server except from a specific ip address.

in domain/program/ssh.te:

	# to cover the setcon
	dynamic_auto_trans(sshd_privsep_t, restricteduser_t,
	                   sshd_privsep_restricteduser_t)

	# to cover the execve of the execution of the sftp-server
	domain_auto_trans(sshd_privsep_user_t, sshd_sftp_exec_t,
	                  sftp_restricteduser_t)

then i can create a network context:

	nodecon 192.168.0.220 255.255.255.255 system_u:object_r:restricted_ip_t
	        ^^^^^^^^^^^^^

then, instead of using can_network(), i would do this:

	allow sshd_privset_restricteduser_t netif_type:netif      { tcp_send };
	allow sshd_privset_restricteduser_t restricted_ip_t:netif { tcp_recv };
	                                    ^^^^^^^^^^^^^^^

and, in openssh, to finish it off (somewhere around the privsep
child auth function), i do this:

	/* we are in sshd_privsep_t context when this is done,
	 * but how we got there is TBD... */

	get_default_context(.... &scontext);
	setcon(scontext); /* this triggers the dynamic_auto_trans */

if it wasn't for openssh deploying privilege separation [an intermediate
highly restricted process handling networking] then all this lovely
stuff would be completely unnecessary.


... isn't this a _lot_ simpler than pissing about creating hard-coded
security contexts, or fiddling around adding kludges into libselinux
to be able to create security contexts or read some pseudo-default?

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
