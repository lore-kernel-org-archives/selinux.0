Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3NG6HI4002679
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 12:06:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3NG6DVf023102
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 16:06:13 GMT
Received: from narya.grin.hu (adsl-vip-1.tvnet.hu [195.38.117.96])
	by jazzswing.ncsc.mil  with ESMTP id h3NG6B4D023098
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 16:06:11 GMT
Received: from grin by narya.grin.hu with local (Exim 3.36 #1 (Debian))
	id 198MlC-0005Qv-00
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 18:06:14 +0200
Date: Wed, 23 Apr 2003 18:06:14 +0200
From: Peter Gervai <grin@tolna.net>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: please offer your good advices / new policies: exim, dovecot, maradns, (aptitude)
Message-ID: <20030423111231.GV3993@narya.grin.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I subscribed the list as I became confident that my contributions aren't
worthless after my very complex patch got into newrule.pl. :-)

Apart from kidding... I have had small and large problems with selinux, and
most of them was resolved by my humble self, or with the help of
#selinux@irc.debian.org, but I'm not confident that my policies are really
as secure as I would like to have them to be.

The server is a school server with some hundred young users, which was once
compromised, due to the clueless morons walking with root pw to be able to
create users and due to other morons being friends of the before mentioned
ones installing attacking software of questionnable source (not that the
source would change the roots of the problems) containing RST.B and other
linux viruses.

Now enough was enough, selinux goes on the system. 

Mailserver, dns, webserver, and some usual goodies run on it. Mailserver is
exim, dns was chosen maradns (it handles both auth and recur queries, free,
and the author isn't a moron :)), imap/pop is dovecot (pretty nice piece of
sw), apache is apache. Debian sid/unstable is the base with the valuable
help of Russel's packages.

My policies are on http://narya.grin.hu/selinux/policy/
There is a diff to help to show my actions, and the policies are there as
well if someone needs them.

I'd be happy if you would read the README and do what it says, which is
basically a beg for peer review of the beforementioned policies of mine and
sharing good advices.

				*

Other question: what is the advised way to have the server an admin
(staff_t?) who is able to create/delete users? Probably emitting user_u
users are okay in the beginning, because I believe everything more would
require policy reloading. (I'm checking this after this email anyway, but
maybe you're faster.)

This probably need changing to uid=0, and I see that there is no sudo.te in
the default... but I don't think sharing the root pw is better than su. Is
it safe to allow sudo setuid:capability? Does anyone already have a sudo.te?

				*

There was a question a month ago about dhcpc_t (and sshd_t and newrole_t in
cases) emitting this:

avc:  denied  { recvfrom } for  pid=1059 exe=/usr/sbin/exim saddr=10.1.1.16
 source=17664 daddr=10.1.1.1 dest=60 netif=eth0
 scontext=system_u:system_r:dhcpc_t tcontext=root:sysadm_r:sysadm_t
 tclass=packet_socket

(One line for every packet ever arriving on the network!)

I don't see the reason for this (I have wild guesses), and I don't see the
solution. And I don't get why nobody had this problem before. Shall I
dontaudit these (modifying dhcpc, newrole, sshd, ...)? Is there a better
solution?


Thanks for the reading,
Peter


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
