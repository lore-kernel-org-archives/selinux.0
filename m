Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3EIgi4V028333
	for <selinux@tycho.nsa.gov>; Tue, 14 Apr 2009 14:42:44 -0400
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3EIgi36010976
	for <selinux@tycho.nsa.gov>; Tue, 14 Apr 2009 18:42:44 GMT
Received: by an-out-0708.google.com with SMTP id c38so1573814ana.39
        for <selinux@tycho.nsa.gov>; Tue, 14 Apr 2009 11:42:43 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 14 Apr 2009 14:42:43 -0400
Message-ID: <faa16b610904141142v1d1e92ddxd78d5e1a0fbb0be7@mail.gmail.com>
Subject: libselinux behavior in permissive mode wrt invalid domains
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I'd like broader input on:
http://bugs.freedesktop.org/show_bug.cgi?id=21072

Is this something we can do inside libselinux itself?  Or are we
planning similar patches around avc_has_perm calls for the X server,
libvirt and other userspace programs?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
