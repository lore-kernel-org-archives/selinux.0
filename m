Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i57L6mrT007879
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 17:06:48 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i57L6h22021481
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 17:06:43 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i57L6iJQ028828
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 17:06:44 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i57L6iEf028826
	for selinux@tycho.nsa.gov; Mon, 7 Jun 2004 17:06:44 -0400
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i57L2irT007864
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 17:02:45 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i57L2ecx009237
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 17:02:40 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 7 Jun 2004 21:02:35 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BXQcY-0001Ih-29
	for selinux@tycho.nsa.gov; Mon, 07 Jun 2004 20:21:26 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BXRDp-0000oK-WB
	for selinux@tycho.nsa.gov; Mon, 07 Jun 2004 20:59:57 +0000
Date: Mon, 7 Jun 2004 20:59:57 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: support for fireflight reading /proc/NNN/fd and /proc/NNN/exe
Message-ID: <20040607205957.GA3063@lkcl.net>
References: <20040607082243.GH4543@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040607082243.GH4543@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hey, what happened?

sorry about that, i must have hit send rather than cancel.

i picked fireflight because it does on-demand popup firewalling,
which i think is great.

the packet(s) is(are) blocked until approved or rejected, and you
can create a rule immediately from them.

also you can firewall _applications_ so only a certain app is allowed
to do "http" etc.


.. the thing is that, obviously, it requires to know the name
of the applications.

so what it does is look in /proc/NNN/exe and /proc/NNN/fds and
looks up the executable...

and thank you to russell for mentioning the can_ps(...) macro which
allows to read /proc.


.. but it also needs to be able to track the files themselves,
getattr, and stuff.

this is what i'm seeing:

	allow fireflier_t ptmx_t:chr_file { getattr };
	allow fireflier_t sound_device_t:chr_file { getattr };
	allow fireflier_t sysadm_ssh_t:tcp_socket { getattr };
	allow fireflier_t sysadm_tty_device_t:chr_file { getattr };
	allow fireflier_t user_devpts_t:chr_file { getattr };
	allow fireflier_t user_home_t:file { getattr };
	allow fireflier_t user_tmp_t:file { getattr };
	allow fireflier_t user_t:fifo_file { getattr };
	allow fireflier_t user_t:tcp_socket { getattr };
	allow fireflier_t user_t:unix_stream_socket { getattr };
	allow fireflier_t xdm_t:fifo_file { getattr };


should i be looking to modify the can_ps macro?

i mean, basically, everything in /proc/NNN/fds, fireflier is
going to try to stat it.

this is can_ps.

	define(`can_ps',`
		allow $1 $2:dir { search getattr read };
		allow $1 $2:{ file lnk_file } { read getattr };
		allow $1 $2:process getattr;
		# We need to suppress this denial because procps tries to access
		# /proc/pid/environ and this now triggers a ptrace check in recent
		# kernels
		# (2.4 and 2.6).  Might want to change procps to not do this, or only if
		# running in a privileged domain.
		dontaudit $1 $2:process ptrace;
	')


should i change this:

	allow $1 $2:{ file lnk_file } { read getattr };

to this:

	allow $1 $2:{ file lnk_file chr_file tcp_socket fifo_file
					unix_stream_socket } { read getattr };


and why, if i have can_ps(fireflier_t, domain), am i still seeing
denied getattr on user_home_t?



.. alternatively, has anyone got any better ideas on how fireflier
should be checking for executable program's names?

l.

p.s. if i _don't_ allow it to look up these program names, i can
expect fireflier to thoroughly lock up the machine as it can't
tell me what to do with a packet, so it gets blocked.

On Mon, Jun 07, 2004 at 08:22:43AM +0000, Luke Kenneth Casson Leighton wrote:
> hi,
> 
> got an interesting issue that i don't quite know how to tackle.
> 
> i picked fireflight because it's exactly the sort of thing that i
> need to put 
> -- 
> -- 
> expecting email to be received and understood is a bit like
> picking up the telephone and immediately dialing without
> checking for a dial-tone; speaking immediately without listening
> for either an answer or ring-tone; hanging up immediately and
> believing that you have actually started a conversation.
> --
> <a href="http://lkcl.net">      lkcl.net      </a> <br />
> <a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
