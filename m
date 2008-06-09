MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: X in MLS enforcing problem
Date: Mon, 9 Jun 2008 17:49:59 -0400
Message-ID: <D709A20F2164C84E8B7014B0301F5EF8012E7F32@HAVOC.tcs-sec.com>
References: <cadfc0e40806091430j7d4734c6l7af3cfbce395eeae@mail.gmail.com>
From: "Chad Hanson" <chanson@TrustedCS.com>
To: "Xavier Toth" <txtoth@gmail.com>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>,
        "Eamon Walsh" <ewalsh@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


mls_trusted_object(xdm_xserver_t) won't help this problem, but something
like mls_file_read_up and mls_file_write_down would be more approriate
for xdm_xserver_t.

-Chad

> 
> type=AVC msg=audit(1213041678.053:8): avc:  denied  { read } for
> pid=2649 comm="Xorg" name="mem" dev=tmpfs ino=3893
> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:memory_device_t:s15:c0.c1023
> tclass=chr_file
> type=AVC msg=audit(1213041678.432:10): avc:  denied  { write } for
> pid=2649 comm="Xorg" name="mem" dev=tmpfs ino=3893
> scontext=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:memory_device_t:s15:c0.c1023
> tclass=chr_file
> 
> The xserver_common_domain_template seems to have the necessary allow
> rules (dev_read_raw_memory and dev_wx_raw_memory) for the types so  I
> create a local module and added:
> mls_trusted_object(xdm_xserver_t)
> to deal with the MLS constraint violation but I'm still getting these
> AVC.What else can it be?
> 
> Ted
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
