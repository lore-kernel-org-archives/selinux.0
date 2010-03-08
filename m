Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o28LMpBF014788
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2010 16:22:51 -0500
Received: from relay1.gtri.gatech.edu (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o28LNGNb010811
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2010 21:23:16 GMT
Received: from apatlisdmfe2.core.gtri.org (apatlisdmfe2.core.gtri.org [130.207.199.71])
	by relay1.gtri.gatech.edu (Spam Firewall) with ESMTP id A5C3277F57B
	for <selinux@tycho.nsa.gov>; Mon,  8 Mar 2010 16:22:49 -0500 (EST)
Received: from apatlisdmfe2.core.gtri.org (apatlisdmfe2.core.gtri.org [130.207.199.71]) by relay1.gtri.gatech.edu with ESMTP id AFtKfZEOpqLZLm9e for <selinux@tycho.nsa.gov>; Mon, 08 Mar 2010 16:22:48 -0500 (EST)
Message-ID: <4B956AA9.4040004@gtri.gatech.edu>
Date: Mon, 8 Mar 2010 16:22:49 -0500
From: Joshua Roys <joshua.roys@gtri.gatech.edu>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] mod_selinux: setcon earlier
References: <4B917BCF.7060200@gtri.gatech.edu> <4B949C72.4040104@ak.jp.nec.com>
In-Reply-To: <4B949C72.4040104@ak.jp.nec.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms020707020900000200090503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--------------ms020707020900000200090503
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: quoted-printable

On 03/08/2010 01:42 AM, KaiGai Kohei wrote:
>> The current code ends up calling setcon after sockets have been opened=
,
=2E..
>> noticed issues with labeled networking having the setcon() called afte=
r
>> the listening sockets are opened.
>=20
> Hmm. The purpose of selinuxServerDomain allows to drop unnecessary
> categories on the starting up time, although mod_selinux.pp set it
> to translate into 's0 - mcs_systemhigh'. So, the listener sockets
> also should be created in the configured domain.
> It seems to me what you pointed out is fair enough.
>=20
> However, I cannot agree to change security context of the server
> which it parses the configuration file, because we can call setcon()
> in the open_logs hook earlier than listener sockets are created using
> APR_HOOK_FIRST, not APR_HOOK_MIDDLE.
>=20
> Thanks,
>=20

Hello,

Do you mean instead of mod_selinux hooking post_config, it would now
hook open_logs?  If so, I think you would have to use something like:
(APR_HOOK_REALLY_FIRST-1), because prefork.c hooks open_logs using
REALLY_FIRST...

Thanks,

Josh


--------------ms020707020900000200090503
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
LVeih694ixsJODR5LQAAAAAAAA==
--------------ms020707020900000200090503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
