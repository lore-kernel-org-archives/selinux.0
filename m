Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r65IdTnk001556
	for <selinux@tycho.nsa.gov>; Fri, 5 Jul 2013 14:39:29 -0400
Received: by mail-we0-f171.google.com with SMTP id m46so2198286wev.16
        for <selinux@tycho.nsa.gov>; Fri, 05 Jul 2013 11:39:11 -0700 (PDT)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id w4sm11150461wia.9.2013.07.05.11.39.05
        for <selinux@tycho.nsa.gov>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 11:39:07 -0700 (PDT)
Date: Fri, 5 Jul 2013 20:39:02 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Labeled IPSec trying to match policy for peer label?
Message-ID: <20130705183902.GA26996@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

I'm trying to get a Labeled IPSec working, but the moment I enable a context
on the SPD, any attempt to set up an SA (by racoon) fails with the following
message:

Jul  5 20:25:16 test racoon: INFO: respond new phase 2 negotiation: 192.168.100.152[500]<=>192.168.100.153[500]
Jul  5 20:25:16 test racoon: ERROR: no policy found: 10.1.3.0/24[0] 10.1.2.0/24[0] proto=any dir=in sec_ctx:doi=1,alg=1,len=24,str=root:sysadm_r:ping_t:s0
Jul  5 20:25:16 test racoon: ERROR: failed to get proposal for responder.

There is (of course?) no policy for ping_t, only for ipsec_spd_t. Let me
show you the setkey instructions:

spdadd 10.1.2.0/24 10.1.3.0/24 any -ctx 1 1
  "system_u:object_r:ipsec_spd_t:s0" -P out ipsec
  esp/tunnel/192.168.100.152-192.168.100.153/require;

spdadd 10.1.3.0/24 10.1.2.0/24 any -ctx 1 1
  "system_u:object_r:ipsec_spd_t:s0" -P in ipsec
  esp/tunnel/192.168.100.153-192.168.100.152/require;

If I drop the "-ctx 1 1 "system_u:object_r:ipsec_spd_t:s0"" then the IPSec
works (I verified that it is indeed IPSec traffic). For allowing ping to
work across the Labeled IPSec setup, I have added allow rules for kernel_t
and ping_t to association:polmatch against ipsec_spd_t (without those, IPSec
isn't used as expected).

Considering I get the error message on the server side tells me that the
label is properly passed on (so ping_t is the peer label) but I was
expecting that it would match the policy on the ipsec_spd_t context?

What am I missing here? Is there a particular check that IPSec does further
that I'm not seeing (no denials are shown, even disabled all dontaudits)?

On the client side (where ping is invoked) the following is logged:

Jul  5 20:24:32 test racoon: INFO: initiate new phase 2 negotiation: 192.168.100.153[500]<=>192.168.100.152[500]
Jul  5 20:24:58 test racoon: INFO: unsupported PF_KEY message REGISTER
Jul  5 20:25:06 test racoon: INFO: security context doi: 1
Jul  5 20:25:06 test racoon: INFO: security context algorithm: 1
Jul  5 20:25:06 test racoon: INFO: security context length: 24
Jul  5 20:25:06 test racoon: INFO: security context: root:sysadm_r:ping_t:s0
Jul  5 20:25:06 test racoon: NOTIFY: no in-bound policy found: 10.1.2.0/24[0] 10.1.3.0/24[0] proto=any dir=in sec_ctx:doi=1,alg=1,len=24,str=root:sysadm_r:ping_t:s0
Jul  5 20:25:06 test racoon: INFO: initiate new phase 2 negotiation: 192.168.100.153[500]<=>192.168.100.152[500]
Jul  5 20:25:36 test racoon: INFO: IPsec-SA expired: ESP/Tunnel 192.168.100.152[500]->192.168.100.153[500] spi=220218943(0xd20463f)
Jul  5 20:25:36 test racoon: WARNING: PF_KEY EXPIRE message received from kernel for SA being negotiated. Stopping negotiation.


Wkr,
  Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
