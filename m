Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1K0xxYF029915
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 19:59:59 -0500
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1K0xtoF010910
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 00:59:56 GMT
Message-ID: <47BB7B6A.1090207@ak.jp.nec.com>
Date: Wed, 20 Feb 2008 09:59:22 +0900
From: Kohei KaiGai <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov, paul.moore@hp.com, DGoeddel@TrustedCS.com,
        vyekkirala@TrustedCS.com
Subject: Re: [PATCH] Labeled IPsec for PostgreSQL/MySQL/SSHd (Re: [PATCH]
 IPsec SPD default security context)
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>	 <47331BAB.8040107@kaigai.gr.jp>  <473872F8.7000208@ak.jp.nec.com>	 <1195055160.13737.33.camel@gorn.columbia.tresys.com>	 <473B23F9.4080506@ak.jp.nec.com>	 <1195064402.13737.42.camel@gorn.columbia.tresys.com>	 <473BB437.3070005@ak.jp.nec.com>	 <1195136813.13737.67.camel@gorn.columbia.tresys.com>	 <4740F30D.9000304@ak.jp.nec.com> <1195498093.16660.44.camel@gorn>	 <4742A571.1060601@ak.jp.nec.com> <1195583693.16660.49.camel@gorn>	 <4743B38D.3070803@ak.jp.nec.com> <1196095135.20918.32.camel@gorn>	 <474EA68E.9010108@ak.jp.nec.com> <4796ADE9.8000608@ak.jp.nec.com>	 <47BA8094.5000707@ak.jp.nec.com> <1203428116.13618.77.camel@gorn>
In-Reply-To: <1203428116.13618.77.camel@gorn>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2008-02-19 at 16:09 +0900, Kohei KaiGai wrote:
>>>>> Merged [1], but I made some changes.  I created corenetwork interfaces
>>>>> to use instead of the patterns, so the current MLS-only netlabel case
>>>>> can be handled too.  I also updated the domain module to use the
>>>>> interfaces.
>>>>>
>>>>> The thing that makes me a little nervous, which I didn't realize at
>>>>> first, is if you use non-labeled networking, the peer policy will still
>>>>> be needed, since the corenet connect/sendrecv calls are abstracted into
>>>>> the interface.  Consider the non-labeled case for apache.  The
>>>>> httpd_can_network_connect_db tunable won't work for postgresql, if the
>>>>> postgresql module isn't in the apache server's policy.  Whats worse is,
>>>>> to make it work, you need to bring in the entire postgresql policy, even
>>>>> though you only need one type, and only need the recvfrom rules.
>>>>>
>>>>> [1] http://oss.tresys.com/projects/refpolicy/changeset/2531
>> Chris, what is the current status of my patch submitted previously?
>>
>> You pointed out that undeprecating postgresql_tcp_connect() to allow
>> permissions for labeled and traditional networks can make unneeded
>> dependency.
>>
>> The attached patch reverts postgresql_tcp_connect() and related part,
>> and puts corenet_tcp_recvfrom_labeled() and ipsec_match_default_spd()
>> within optional_policy block, if necessary.
>> It enables any userdomain to communicate PostgreSQL/MySQL/SSHd via
>> labeled networking, at first.
>> However, I believe we can apply this method for other domains also.
> 
> The use of types outside their modules is not acceptable, for example:
> 
> +               corenet_tcp_recvfrom_labeled(httpd_t,postgresql_t)

Is it acceptable one, if we provide an interface to allow a domain
to communicate postgresql_t via labeled networking, separated from
existing permissions for local ports and nodes?

For example:
-- at postgresql.if
interface(`postgresql_labeled_connect',`
	gen_require(`
		type postgresql_t;
	')
	corenet_tcp_recvfrom_labeled($1,postgresql_t)
')

and
-- at apache.te
postgresql_labeled_connect(httpd_t)

I think this approach enables to keep independency between modules
in unlabeled networking cases too.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
