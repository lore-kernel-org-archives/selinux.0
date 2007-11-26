Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQGdYa2019307
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 11:39:34 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lAQGdSHx005322
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 16:39:29 GMT
Subject: Re: [PATCH] IPsec SPD default security context
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov, paul.moore@hp.com, DGoeddel@TrustedCS.com,
        vyekkirala@TrustedCS.com
In-Reply-To: <4743B38D.3070803@ak.jp.nec.com>
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>
	 <47331BAB.8040107@kaigai.gr.jp>  <473872F8.7000208@ak.jp.nec.com>
	 <1195055160.13737.33.camel@gorn.columbia.tresys.com>
	 <473B23F9.4080506@ak.jp.nec.com>
	 <1195064402.13737.42.camel@gorn.columbia.tresys.com>
	 <473BB437.3070005@ak.jp.nec.com>
	 <1195136813.13737.67.camel@gorn.columbia.tresys.com>
	 <4740F30D.9000304@ak.jp.nec.com> <1195498093.16660.44.camel@gorn>
	 <4742A571.1060601@ak.jp.nec.com> <1195583693.16660.49.camel@gorn>
	 <4743B38D.3070803@ak.jp.nec.com>
Content-Type: text/plain
Date: Mon, 26 Nov 2007 11:38:55 -0500
Message-Id: <1196095135.20918.32.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-11-21 at 13:26 +0900, KaiGai Kohei wrote:
> The attached patch provides the followins features:
>  - Two new policy pattern "labeled_(tcp|udp)_pattern" are added
>  - The postgresql_tcp_connect interface is revised to allow a domain
>    to communicate with postgresql_t.
>  - postgresql_t can communicate others via default SPD.
>  - An obvious permission of "$1 self association:{sendto}" is allowed
>    to any domain using ipsec_spd_t.
>  - Any user-domain using core-networks can communicate others via
>    default SPD.
>  - Any user-domain can communicate postgresql_t via labeled networks.

Merged [1], but I made some changes.  I created corenetwork interfaces
to use instead of the patterns, so the current MLS-only netlabel case
can be handled too.  I also updated the domain module to use the
interfaces.

The thing that makes me a little nervous, which I didn't realize at
first, is if you use non-labeled networking, the peer policy will still
be needed, since the corenet connect/sendrecv calls are abstracted into
the interface.  Consider the non-labeled case for apache.  The
httpd_can_network_connect_db tunable won't work for postgresql, if the
postgresql module isn't in the apache server's policy.  Whats worse is,
to make it work, you need to bring in the entire postgresql policy, even
though you only need one type, and only need the recvfrom rules.

[1] http://oss.tresys.com/projects/refpolicy/changeset/2531

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
