Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i589KirT010714
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 05:20:44 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i589Kfcx028950
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 05:20:41 -0400 (EDT)
Date: Tue, 8 Jun 2004 09:17:55 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Cc: fireflier@gibraltar.at
Subject: Re: support for fireflight reading /proc/NNN/fd and /proc/NNN/exe
Message-ID: <20040608091755.GA9103@lkcl.net>
References: <20040607082243.GH4543@lkcl.net> <20040607205957.GA3063@lkcl.net> <20040607232158.GA2073@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040607232158.GA2073@jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 08, 2004 at 01:21:59AM +0200, Thomas Bleher wrote:

> * Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-06-08 00:50]:
> > i picked fireflight because it does on-demand popup firewalling,
> > which i think is great.
> <snip>
> > so what it does is look in /proc/NNN/exe and /proc/NNN/fds and
> > looks up the executable...
> <snip> 
> > .. but it also needs to be able to track the files themselves,
> > getattr, and stuff.
> > 
> > this is what i'm seeing:
> > 
> > 	allow fireflier_t ptmx_t:chr_file { getattr };
> > 	allow fireflier_t sound_device_t:chr_file { getattr };
> > 	allow fireflier_t sysadm_ssh_t:tcp_socket { getattr };
> > 	allow fireflier_t sysadm_tty_device_t:chr_file { getattr };
> > 	allow fireflier_t user_devpts_t:chr_file { getattr };
> > 	allow fireflier_t user_home_t:file { getattr };
> > 	allow fireflier_t user_tmp_t:file { getattr };
> > 	allow fireflier_t user_t:fifo_file { getattr };
> > 	allow fireflier_t user_t:tcp_socket { getattr };
> > 	allow fireflier_t user_t:unix_stream_socket { getattr };
> > 	allow fireflier_t xdm_t:fifo_file { getattr };
> > 
> > 
> > should i be looking to modify the can_ps macro?
> 
> Not the macro directly, otherwise all domains which use can_ps() will be
> affected. If you really need that much access, you should probably add a
> rule like
>         allow fireflier_t file_type:file_class_set getattr;
>         allow fireflier_t domain:{ socket_class_set fifo_file } getattr;
> But this seems just too broad (see below).
> 
> > i mean, basically, everything in /proc/NNN/fds, fireflier is
> > going to try to stat it.
> > 
> <snip>
> 
> > and why, if i have can_ps(fireflier_t, domain), am i still seeing
> > denied getattr on user_home_t?
> 
> user_home_t doesn't have the "domain"-attribute.
> 
> > .. alternatively, has anyone got any better ideas on how fireflier
> > should be checking for executable program's names?
> 
> How about /proc/<pid>/exe ?
>
 yes, it does that, _and_ parses /proc/<pid>/fds/* as well.

> > p.s. if i _don't_ allow it to look up these program names, i can
> > expect fireflier to thoroughly lock up the machine as it can't
> > tell me what to do with a packet, so it gets blocked.
> 
> I still don't get why it needs to look at all fds and stat all the
> files. Could you tell us why it needs to stat all open filehandles to
> find the program name?
 
 .... mmmm.... fireflier-1.14/server/ports.cpp:

	// search for the pid using localport/localip pair
	// calling the other functions. This could be used from another program
	// too.
	// mode = PROT_TCP ---> tcp port
	// mode = PROT_UDP ---> udp port
	int get_pid(int mode, int local_ip, int local_port)
	{
		int inode=-1;

and later:

	// search for the program using this localport/localip.
	// first look into cache
	// search the pid
	// if found look onto /proc/PID/exe
	// put into cache
	// mode = PROT_TCP  ----> tcp
	// mode = PROT_UDP  ----> udp
	char *get_program_name(int mode, int local_ip, int local_port)
	{

wow, cool -  useful comments.


so, the program does this:

* scans /proc/net/tcp and /proc/net/udp looking for a match on
  local_port and ip, and returns the inode doing that.

* scans ALL of /proc/<pid>/fds/* doing a stat() on every single one
  to look up the inode.

* once found, looks up /proc/<matchingpid>/exe

voila.

now, i notice that names of /proc/<pid>/fds/N when it's a socket,
the name is socket:something.

1) can that convention be followed / respected?  i.e. if
(strncmp("socket:", fdname) == 0) proceed otherwise skip?

2) is there a better way?

i mean, how does lsof do this? [download]  ah... lsof is thoroughly
archaic, short-named variables and completely incomprehensible and
untrackeable code: stuff _that_.

martin if you decide to investigate lsof, good luck :)

l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
