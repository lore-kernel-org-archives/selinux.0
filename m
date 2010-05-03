Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o43GnC71030937
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 12:49:12 -0400
Received: from mail-yx0-f182.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o43Gma84029267
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 16:48:36 GMT
Received: by yxe12 with SMTP id 12so844520yxe.32
        for <selinux@tycho.nsa.gov>; Mon, 03 May 2010 09:49:11 -0700 (PDT)
Subject: Semanage for domain transitions
From: Martin Spinassi <martins.listz@gmail.com>
Reply-To: martins.listz@gmail.com
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 03 May 2010 13:49:55 -0300
Message-ID: <1272905395.2206.7.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi list!


I'm trying to figure out how to make domain transition using semanage or
any userland command.

My problem is that I've just compiled a new version of memcached, and
configured it to use the sock file /tmp/memcached.sock, but httpd can't
write to it. The scontext is httpd_t, and the dcontext is tmp_t.

Probably later I'll make a context for memcached, but by now, I've just
find out that I don't really know how to make a domiain transition
without having to install selinux source policy, and that's something
that I'm really trying to avoid.

Any link/doc/tip is really appreciated.

Thanks!

Martin


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
