Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAJ2NCkf007479
	for <selinux@tycho.nsa.gov>; Sun, 18 Nov 2007 21:23:15 -0500
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAJ2N9Yx000990
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 02:23:10 GMT
Message-ID: <4740F30D.9000304@ak.jp.nec.com>
Date: Mon, 19 Nov 2007 11:21:01 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov, paul.moore@hp.com, DGoeddel@TrustedCS.com,
        vyekkirala@TrustedCS.com
Subject: Re: [PATCH] IPsec SPD default security context (Re: security	context
 for SPD entries of labeled IPsec)
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>	 <47331BAB.8040107@kaigai.gr.jp>  <473872F8.7000208@ak.jp.nec.com>	 <1195055160.13737.33.camel@gorn.columbia.tresys.com>	 <473B23F9.4080506@ak.jp.nec.com>	 <1195064402.13737.42.camel@gorn.columbia.tresys.com>	 <473BB437.3070005@ak.jp.nec.com> <1195136813.13737.67.camel@gorn.columbia.tresys.com>
In-Reply-To: <1195136813.13737.67.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> I also suggest two minor improvement toward these updates.
>>
>> 1. Is it considerable to add "allow $1 self : association { sendto };"
>>    at ipsec_match_default_spd interface of ipsec.if?
>>
>>    I think it should be packed with polmatch permission to the default
>>    SPD context, because any domain which want to communicate others using
>>    SPD with default context always have to have 'sendto' permission to
>>    itself.
> 
> Perhaps.  Though I thought that dropping the sendto check was being
> considered, since it really doesn't gain anything.
> 
>> 2. Is it considerable to add "ipsec_match_default_spd($1_t)"
>>    in the userdom_basic_networking_template of userdomain.if?
>>
>>    This interface allows a given userdomain widespread basic networking
>>    permissions. But it is not enough yet, if the networking tunnel
>>    is configured with labeled ipsec.
>>    I think it can be contained in the basic networking permissions
>>    to use ipsec SPD with default context.
> 
> Sounds reasonable.

The attached patch enables the above two features.

Paul mentioned to drop the checks of association:{sendto} permission and
integrate them with the upcaming flow control checks in the future kernel.
However, a rule of "allow <domain> self : association {sendto}" will be
necessary for the backward compatibility.

>>> I'll consider a patch that adds it to a postresql interface.  Perhaps
>>> postgresql_tcp_connect should be un-deprecated.
>> I think similar interfaces are necessary for any other daemon-domain which
>> provides networking-services, even if they don't use getpeercon().
> 
> The recvfrom is needed if the networking is labeled, regardless of
> whether getpeercon() is used or not.

Do you intend to describe the labeled networking rules for each combination
between a server domain and a client domain?

Is it a considerable idea that adding a new attribute to comunicate via
labeled ipsec with default SPD, and attaching it both a server domain and
a client domain?

e.g)
  attribute labeled_communicatable_domain;  # I want to get more shorl naming.
  allow     labeled_communicatable_domain labeled_communicatable_domain : association {resvfrom sendto};

  typeattribute postgresql_t, labeled_communicate_domain;
  typeattribute user_t, labeled_communicate_domain;

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

Index: refpolicy/policy/modules/system/ipsec.if
===================================================================
--- refpolicy/policy/modules/system/ipsec.if	(revision 2524)
+++ refpolicy/policy/modules/system/ipsec.if	(working copy)
@@ -109,6 +109,7 @@
 	')

 	allow $1 ipsec_spd_t:association polmatch;
+	allow $1 self:association sendto;
 ')

 ########################################
Index: refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy/policy/modules/system/userdomain.if	(revision 2524)
+++ refpolicy/policy/modules/system/userdomain.if	(working copy)
@@ -548,6 +548,8 @@
 	corenet_udp_sendrecv_all_ports($1_t)
 	corenet_tcp_connect_all_ports($1_t)
 	corenet_sendrecv_all_client_packets($1_t)
+
+	ipsec_match_default_spd($1_t)
 ')

 #######################################


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
