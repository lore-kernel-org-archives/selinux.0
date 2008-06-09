Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m59LUx3F006994
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 17:30:59 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m59LUv3R001937
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 21:30:58 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1591442fgg.40
        for <selinux@tycho.nsa.gov>; Mon, 09 Jun 2008 14:30:57 -0700 (PDT)
Message-ID: <cadfc0e40806091430j7d4734c6l7af3cfbce395eeae@mail.gmail.com>
Date: Mon, 9 Jun 2008 16:30:57 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux Mail List" <selinux@tycho.nsa.gov>,
        "Eamon Walsh" <ewalsh@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>
Subject: X in MLS enforcing problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

type=AVC msg=audit(1213041678.053:8): avc:  denied  { read } for
pid=2649 comm="Xorg" name="mem" dev=tmpfs ino=3893
scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
tcontext=system_u:object_r:memory_device_t:s15:c0.c1023
tclass=chr_file
type=AVC msg=audit(1213041678.432:10): avc:  denied  { write } for
pid=2649 comm="Xorg" name="mem" dev=tmpfs ino=3893
scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
tcontext=system_u:object_r:memory_device_t:s15:c0.c1023
tclass=chr_file

The xserver_common_domain_template seems to have the necessary allow
rules (dev_read_raw_memory and dev_wx_raw_memory) for the types so  I
create a local module and added:
mls_trusted_object(xdm_xserver_t)
to deal with the MLS constraint violation but I'm still getting these
AVC.What else can it be?

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
