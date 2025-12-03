Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6A92DF153
	for <selinux@vger.kernel.org>; Wed,  3 Dec 2025 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799377; cv=none; b=a3+nmDfdQ5yDnDe9icRxhRISacOStALbpYTN8OKX/abh6M8l7n8oJJy1UBZxg9hsbtuHbLWlcnseHlVpZqSVQC8jn68RBJjy6qQXCRdHnjG6kwAyfJJVQczmqE4erD/zaqpZThp1esXYsMjDSktLeFYT/M2cb8Is5ltHjwNlDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799377; c=relaxed/simple;
	bh=VIpZ+1HPAKSiZ7sfAdtNFmL5nKeo1YhQ9nfd4hZqylk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kyx65xjVpr7rqyA/+gQ8Lx0hOPnpECzjXMuH6MG6GeEYwTwRS3o/b+BmkM3QqLuS3EQSuy1bi0lgJed0FBmBkeg0eFMCFVZnGbijQpVE+e5RYkw9GIDG3qnn61NK7ERfQ69KpyQkAYoLiKmzc6xMtC7hTR6wOlqJdibArVkMs4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=XoGzblbO; arc=none smtp.client-ip=66.163.184.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XoGzblbO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764799374; bh=VIpZ+1HPAKSiZ7sfAdtNFmL5nKeo1YhQ9nfd4hZqylk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XoGzblbOhRUmfnoEMflmM5pefJi9RlN5YGWZV54E79kkRF0JkbBr3A+JYQBM/O0c9j0mKM+PARo9AwN8ffH6pY4JmASjm3rNdy28R/tc0RQEZaQY+kSHQFn3kX3qSd0C9s7FCENidnYTxko6o1f1F1je1YvPD9AeBBK1lYbrzoKFZyadJgsBj1Md2vG/uaiXPjyXEV5wuvBQnmH9ng8jOcI+Bi2520k1DcmaJoMLicrWWsieWGlJP4xcRDm2fR0U3GsQcQHOAxxihpGVV9iCl0HNDgwqF7Q8r3qn4xHvQ+pwnMl6UgpnyHFBhB3KHvo/WAaKBSJMQ3dFiKl+4d+glg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764799374; bh=1AbWTgEGnWhi7O/3JaQTqQ2O0/d+dKSG9C5hB/qR4FG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=XEJIVwd8UR9jB2Ytby1arDwJ7yvzZD9TZPPUN+7rfk8BeULkM6H75lYmM2NS6AEeSd4XGhjR9BRfOvILl/P4sPVeO9wgPv4r6d2ZqfP24MjGEmWGWo6DFmBpCCuGSd7Nw6IIK40JOusiiDjGo3VvGnLXgk4FcdqHIUa8kLSgtRW+l2PKGQiYfzCFh2yYwD0aDgTW+2RlP73O/RvMD7EzOcCZZ5Wkx25g+h8tASmdMPlnPtbTsbAcuRziZWOc15Ua6VQKePWvt2rDo3Zw330BGf9xC+kGvlZTaUflnzB5oR9syMNVBjDYQhVdu/U3J5qFUHJJPkA0LKeHQbhHmusuaA==
X-YMail-OSG: 3MjFOosVM1lIsYc9Q6F6BeiaMpvIhyRynQOSi9yCD3nEOPz.90uwyXeuyG5ERs0
 N4y7K_ikhQHuXniz.AQUT9eJj6QchnL7odhrf9v1aaIzcMsq9vgp_Yif7GgngFNaDJQD77mTSzqc
 wkimY6Ki7isNuALUlb2965Mp9ECpJBNSZp6nBjK0jJ6IqiqlZfWaLqGo9dRZWLyw5hDg361IV8fB
 Q2tf8nFkzi4Ux_XCgGufArtXAPQD_gNgQSOwnClz1GkA1gA3Pq3EXxaSeMuYiBN2A1O6PSOqBcD1
 jda6.usuGCiwoUZsgmroWHztCwQG.CkStZBOUfe7_I7282xUp9ZZiAbU92AwLsZaOQ3MhVC2QlVG
 Gaz8DmWbHgG.DQtYa_FMTQA6uzfINUtBSDuxfRPegcHrXVBhVNGnxWmGFjF2BQrE7OIT39rKtpdK
 KsIYkJ4OU7tPAM6IWT55Q2Z_0DljH7S_c1EXwMGauHKNM7K4jffFcUJVJYTxajDJ9jKegK8JVg1m
 1ZqZ8XKfFEW4ptau4hw2aA__HY9290tAWB1_QU.mXzzYgle8iKW6hKvfvpZaSuc_d_7nQlhWZdP0
 4lXpE2Lt.MkHhUeS5y2g_hRkxK4MF8RZytFTaSVWCuxcJw4yWfMmUxICXRBgYdcEn9sgUxemYnUn
 UKp9L4OSoMhjv9NoeUTQaa4PvtR1r6ZIoqAumMRDzxweI9k5O6Cp31HcGIi5PljJh_JAmwYeXuso
 oqLciA2iR62IPcGC3EaF_rIHUxFeTiRv_cy3_AiQnE0EteMANh1JrV7dJU6RWBNBlPvLdyFABUAu
 i4UIS5Ex4OiEmbeRPb0grA_Vv.pwobp_8MjzuIXTBDVodmf_I8J2vNLusUC_cXlScSMBOLDYgLm2
 tnMVf.WfdLSJiOvQmb9PcTbU.1j_pIpAmbGe8gUBMOY3qtB5G4Er8nhT.EeXbA8z1AqLXPq7XYbO
 h261MhKZaAvfGYwX_fEmDEVhtQOJavnqAlS5QLGg_tMkXimJ.44FPzsMLQDdkP2jcw2pP8QAnZee
 q4_T9MqvFzD9c39BEKN2LI31MfSYn5q5G9adacQDyKxzM.cMMs50epzqyaLziG60P5ttv7Hz0tnC
 M9ymxq71XuUHH2LJQW3jqP7R0OrNcRJm6fqOSLgL_wi53EItLmYaxIN7k9cpYVXIw8qwh3UggPN6
 v1WpvviYB3CEQqaRaXfskJnkNyy_anfUO2C5CL38t2yFaMTzJh6wYfTaBwn0VX7.rL.oNHvQKPSS
 fWZVa_jCbv3sJK8FmR8ANAlJMf7gFyxbnJGKRUKnn5yfyePjddoK0HjYR9Nxr42j317EjUGQbOLl
 wMhb1lkGPY1.T12wZ1IVYqS_3OozMY4AP8G2eyZCfcBm8RnxGzdKzyIk9595UgdNuWRutYmWe2RJ
 QHWrT.ZF2h3ecRv.fvH7r9ornuX9k7lNragRM07SBfC.MZdeIRXY9AmwDXvD.FZU2iuH_J6wOTGH
 absbpNoA6eUYMudJda1ZmE9D0Y9R7XvEvAYmMWEClKKFG98oR7rNPNti10Oyo3s1y_cf1.6mfc_E
 _1mXoJeQGJw4uqOB.Hz7tPZz45UHmjcf6zd3DHLQtrfbvFvfBifYODjveg.LNKXOveur3bOl4pzB
 HLQbywv.WxqyN3926xBQny.Lf9DVCz8A5K_oaogIY3Bqd4Evd0p0KxvibZOuNdnc9q0GorzuI5uG
 GmMfoP6xekLnwLWPYEKgJn8Q91vod.5FT82Q_dFlzET21khFe.rOfuWY_3Vtp_wsSdYUE7ym0aIq
 RGWvfWUWNCOEWorzBq4ZNTF5BAcWWiVitPTUQEvELTcMpPMkj1eS1JZ7pAO9NJnCTVOuTfcq4ifF
 FwrwA3yXpr5UCSni5pqEmen8MfrHIWiWlDpP0yf_IPakGkjoaK179yCqHV5nkID9RuwKdBp5itDu
 uuCxLpy7a130ExpmWA5Kwqk6b8G8OtvuSS7ZOLGgRvhvVSSgU8t7Z7e8bXPE_awxoKKtnIVwWuaa
 X0BUkXR.f56Xit3laRukDPgsYm.WESzF99ce5CigTDceqMcnTqbHHtRUpOgw_Y.ZMg81D5qaPJBv
 iXS8Aqy2JtBsmH0buX5KAAtvLB5y5gwF5EQ5yDNYMjfsmBA03o0NpHWMhPwE11il3VX4nXLuHULi
 mtIELBUw7TfyBIOsfnNSqQ4xDKIQblaemHm_Q9ZQ0Mw.YEMzO_kpptE5FTUR4.gTdriB3IIEgPTe
 YIn4BjCCD5YWworl9sLC_IaeiindMamZTq65w9GSRwFtmXso16aY74u6KP3VVABehIIa2IvFAGHH
 5MpOiBr2QZuUsPty_TTwp4mGTcPpKAjk6
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b430dad4-8cf3-4f51-b438-6b06dbb6a5ef
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Dec 2025 22:02:54 +0000
Received: by hermes--production-gq1-54bf57fc64-s8ptv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c7eadb1569216fe4a7b96a0992f710a9;
          Wed, 03 Dec 2025 22:02:49 +0000 (UTC)
Message-ID: <866a132a-b6e2-4e40-aba3-d8b733184672@schaufler-ca.com>
Date: Wed, 3 Dec 2025 14:02:47 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: set_security_override_from_ctx()
To: LSM List <linux-security-module@vger.kernel.org>,
 David Howells <dhowells@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>
References: <cb4293da-41dc-4586-adca-2859944905dc.ref@schaufler-ca.com>
 <cb4293da-41dc-4586-adca-2859944905dc@schaufler-ca.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <cb4293da-41dc-4586-adca-2859944905dc@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24794 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Adding David, who wrote the code ...

On 12/3/2025 1:32 PM, Casey Schaufler wrote:
> While trying to ensure sanity in security context processing I
> discovered set_security_override_from_ctx(), which is not used anywhere
> in the upstream kernel. Does anyone here know what its purpose is? I
> would very much like to remove it, but of course wouldn't want to break
> anything important.
>
>
