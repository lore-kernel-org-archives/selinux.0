Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA21999
	for <selinux@tycho.nsa.gov>; Wed, 4 Sep 2002 10:02:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA16298
	for <selinux@tycho.nsa.gov>; Wed, 4 Sep 2002 14:01:13 GMT
Received: from meryl.it.uu.se (meryl.it.uu.se [130.238.12.42])
	by jazzswing.ncsc.mil  with ESMTP id OAA16290
	for <selinux@tycho.nsa.gov>; Wed, 4 Sep 2002 14:01:11 GMT
Received: from meretrix.it.uu.se (dhcp-8-192.it.uu.se [130.238.8.192])
	by meryl.it.uu.se (8.8.5/8.8.5) with ESMTP id QAA10992
	for <selinux@tycho.nsa.gov>; Wed, 4 Sep 2002 16:02:24 +0200 (MET DST)
Content-Type: text/plain;
  charset="us-ascii"
From: Magnus Johansson <magnusj@it.uu.se>
To: selinux@tycho.nsa.gov
Subject: Buildproblems
Date: Wed, 4 Sep 2002 16:01:07 +0000
MIME-Version: 1.0
Message-Id: <200209041601.07772.magnusj@it.uu.se>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

I just tried to build the latest tarball, but ran into problems compiling
'more'. However, I found both the problem and the solution in the
mailinglist archive from January. I just want to point out that the problem
still exists in the current tar-ball (lsm-2.4-selinux-2002082308.tgz).

Regards,
Magnus Johansson

Here is the original message:

>Hi, 
>
>I came across this problem as well. A library is missing in the Makefile 
>(utils/util-linux-2.11f/text-utils) for building 'more'. 
>
>more: more.o $(LIB)/xstrncpy.o 
>        $(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@ $(LIBTERMCAP) 
>
>
>I added $(LIBCURSES) at the end of this line and 'more' built properly. 
>
>
>Trent. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
