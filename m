Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA25572
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:02:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA14094
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 21:01:30 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id VAA14090 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 21:01:30 GMT
Date: Wed, 20 Mar 2002 16:01:45 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ntp policy
In-Reply-To: <20020320145513.919FD22731@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203201553140.11981-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Mar 2002, Russell Coker wrote:

> I've attached the ntp.te file.

Thanks.  A few comments and questions below.

>allow ntpd_t root_t:dir r_dir_perms;

This rule can probably be generalized and moved into uses_shlib as well,
as you've done with the lib_t permissions.  Probably usr_t as well
to pick up /usr/lib.

>allow ntpd_t { var_lib_ntp_t var_log_ntp_t }:dir rw_dir_perms;
>allow ntpd_t { var_lib_ntp_t var_log_ntp_t }:file rw_file_perms;

These rules should be handled already by the file_type_auto_trans
macros, which both set up the type transition rule and grant the
necessary permissions to create and access files of these types.

>allow ntpd_t domain:packet_socket recvfrom;

Does ntpd truly need the ability to receive from any domain?

>allow ntpd_t self:unix_dgram_socket create_socket_perms;

What domains need to be able to send to this socket?

>allow ntpd_t self:process fork;

Might ntpd need the ability to signal forked copies of itself?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
