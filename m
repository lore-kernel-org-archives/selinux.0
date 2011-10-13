Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9DDov7i011040
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2011 09:50:57 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p9DDou6k013014
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2011 13:50:56 GMT
Message-ID: <4E96ECBC.9070606@redhat.com>
Date: Thu, 13 Oct 2011 09:50:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Damian Gerow <dgerow@afflictions.org>
CC: selinux@tycho.nsa.gov
Subject: Re: Upstart not transitioning to target domain
References: <1318478183.9025.140258154258765@webmail.messagingengine.com>
In-Reply-To: <1318478183.9025.140258154258765@webmail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/12/2011 11:56 PM, Damian Gerow wrote:
> I've been struggling for a few hours trying to write a new policy
> on an install of RHEL6.1.  I'm still cutting my teeth on SELinux,
> so if there's a more appropriate forum for this, I apologize.
> 
> I can't seem to convince upstart to transition to the target
> domain. I've tried using init_daemon_domain, domain_auto_trans, and
> specifying the transition manually, but the resulting daemon
> continues to run under initrc_t.  Curiously, the
> logging_log_filetrans macro seems to be working just fine, as log
> files are created with an appropriate context.
> 
> The current policy is quite simple:
> 
> ----- policy_module(foobar,0.5.7)
> 
> require { attribute port_type; };
> 
> type foobard_t; type foobard_exec_t; init_daemon_domain(foobard_t,
> foobard_exec_t)
> 
> type foobard_etc_t; files_type(foobard_etc_t)
> 
> type foobard_log_t; files_type(foobard_log_t)
> 
> type foobard_var_lib_t; files_type(foobard_var_lib_t)
> 
> type foobar_port_t, port_type; -----
> 
> I've verified that the filesystem is labelled properly, yet the
> service itself continues to run under initrc_t:
> 
> ----- system_u:system_r:initrc_t:s0   root      8724  0.0  1.5
> 694524 15636 ? Ssl  23:50   0:00 /usr/local/foobar/bin/foobard -a
> input -f /usr/local/foobar/conf/input.conf -----
> 
> What am I doing wrong?
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 


ls -lZ /usr/local/foobar/bin/foobard /etc/rc.d/init.d/foobard

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6W7LwACgkQrlYvE4MpobOS9wCdGyaMdcaKJjbjNz9sItPS/lWU
uk0An2FAHEoOAHe23yk1UqjuKzZ9pxM0
=CcxQ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
