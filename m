Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA29610
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 14:53:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA24378
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 18:53:18 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id SAA24374
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 18:53:17 GMT
Date: Thu, 27 Jun 2002 14:52:52 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Bergauer <privateryan@mindspring.com>
cc: <selinux@tycho.nsa.gov>
Subject: RE: Configuration issues on a new installation
In-Reply-To: <001701c21daa$28a60550$6501a8c0@donkey>
Message-ID: <Pine.GSO.4.33.0206271424450.21230-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 27 Jun 2002, Ryan Bergauer wrote:

> Hah, tonight I've actually been working on policy files for Samba. This
> is my first time dabbling with domains - could any of you who are much
> more versed with SELinux take a quick look and tell me if everything
> seems in order?
>
> I haven't had anything denied recently, but that's when Samba's being
> used for my purposes. Your mileage may vary. The above files also
> required a small change to the dhcpc domain, adding:
>
> allow dhcpc_t nmbd_t:packet_socket recvfrom;
> allow dhcpc_t smbd_t:packet_socket recvfrom;
> allow dhcpc_t tcp_socket_t:packet_socket recvfrom;
>
> Feeback is highly appreciated. No better way to get used to SELinux than
> jumping in head-first...

Thanks for contributing.  A few questions/suggestions:
1) You may want to be more restrictive in granting read access to
smbd/nmbd than what is currently permitted under every_domain() and by
your allow rules to home_type.  Ideally, we'd like to see all of the
domains reworked to move away from using every_domain in order to
provide true least privilege.  Notice that every_domain is already
partitioned into some smaller macros that you can use and that
you could easily define even finer-grained subset macros.
2) You can pick up some common declarations and rules for daemons from
the daemon_domain macro in global_macros.te, contributed by Russell.
3) It would be a good idea to define a separate type for /var/cache/samba
and only grant smbd/nmbd access to it rather than the generic var_t type.
4) Why does nmbd_t need recvfrom permission to initrc_t?  Are any of your
system processes being left in initrc_t due to a lack of a domain?  Check
your ps -e --context output.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
