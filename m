Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA19943
	for <selinux@tycho.nsa.gov>; Thu, 18 Oct 2001 05:11:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id JAA05577
	for <selinux@tycho.nsa.gov>; Thu, 18 Oct 2001 09:10:53 GMT
Received: from marla.i2net.com (marla.i2net.com [208.179.142.252])
	by jazzband.ncsc.mil  with SMTP id JAA05573
	for <selinux@tycho.nsa.gov>; Thu, 18 Oct 2001 09:10:51 GMT
Subject: Re: Updated release
From: J <jack@i2net.com>
To: selinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.33.0110171035500.18757-100000@raven>
References: <Pine.GSO.4.33.0110171035500.18757-100000@raven>
Content-Type: text/plain
Date: 18 Oct 2001 02:11:15 -0700
Message-Id: <1003396275.3729.34.camel@BufferOverflow>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2001-10-17 at 08:05, Stephen Smalley wrote:
> 
> A few additional notes about this release:
> 
> 1) A new run_init utility program and domain have been created to allow
> administrators to run the init scripts with the appropriate security
> context (e.g. to restart daemons) in a secure manner.  This was requested
> by several SELinux users.  See the updated README, utils/run_init, and
> utils/appconfig/initrc_context.

If you are not using PAM it didn't compile so I just moved 
#define CONTEXT_FILE .....
out of the ifdef PAM block. in run_init.c  FYI.

Also newrole.c line 412 almost certanly has an error

I changed
if ( !authenticate_via_shadow_passwd(d p_passwd_line) ) {
to
if ( !authenticate_via_shadow_passwd(p_passwd_line) ) {

Also, I have integrated this with a Slackware 8.0 filewall
that is re-exporting nfs filesystems to samba for windows clients.
It is also running dhcp. I have created iptables, dhcpd, and samba
domains. I also had to change a huge amount of file_contexts. It is
working fine as a production server. I am very pleased with selinux.

J


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
