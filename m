Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9D3uO8P015683
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 23:56:24 -0400
Received: from out4.smtp.messagingengine.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p9D3uOx1012088
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2011 03:56:24 GMT
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CEB8F20B80
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 23:56:23 -0400 (EDT)
Message-Id: <1318478183.9025.140258154258765@webmail.messagingengine.com>
From: "Damian Gerow" <dgerow@afflictions.org>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Upstart not transitioning to target domain
Date: Wed, 12 Oct 2011 23:56:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been struggling for a few hours trying to write a new policy on an
install of RHEL6.1.  I'm still cutting my teeth on SELinux, so if
there's a more appropriate forum for this, I apologize.

I can't seem to convince upstart to transition to the target domain. 
I've tried using init_daemon_domain, domain_auto_trans, and specifying
the transition manually, but the resulting daemon continues to run under
initrc_t.  Curiously, the logging_log_filetrans macro seems to be
working just fine, as log files are created with an appropriate context.

The current policy is quite simple:

-----
policy_module(foobar,0.5.7)

require {
        attribute port_type;
};

type foobard_t;
type foobard_exec_t;
init_daemon_domain(foobard_t, foobard_exec_t)

type foobard_etc_t;
files_type(foobard_etc_t)

type foobard_log_t;
files_type(foobard_log_t)

type foobard_var_lib_t;
files_type(foobard_var_lib_t)

type foobar_port_t, port_type;
-----

I've verified that the filesystem is labelled properly, yet the service
itself continues to run under initrc_t:

-----
system_u:system_r:initrc_t:s0   root      8724  0.0  1.5 694524 15636 ? 
      Ssl  23:50   0:00 /usr/local/foobar/bin/foobard -a input -f
/usr/local/foobar/conf/input.conf
-----

What am I doing wrong?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
