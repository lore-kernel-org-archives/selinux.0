Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6IAjEMT002055
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2011 06:45:14 -0400
Received: from mail-yw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6IAjDJC010088
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2011 10:45:13 GMT
Received: by ywm21 with SMTP id 21so1368294ywm.12
        for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2011 03:45:13 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 18 Jul 2011 12:45:13 +0200
Message-ID: <CAGFYgbPN41ax88SYosv2e4_RBvc6k3R+hV07vsBiyTZiUreKVw@mail.gmail.com>
Subject: is "type poisoning" possible?
From: Zoltan Arnold NAGY <zoltan.arnold.nagy@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I apologize in advance if my use of nomenclature is a bit sloppy. I'm
new to this. :)

Let's say I have a process with type P, but it needs a config file.

Is there a way to specify that if P accesses any file having a type Q, then
the process type should transition to T?

This would allow to mitigate attacks where specific config changes are allowed
(but are always coupled with a relabeling to type Q), but we don't
trust the changer.
A side question would be how to force this relabeling to take place
automatically?

Thanks,
Zoltan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
