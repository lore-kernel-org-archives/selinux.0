Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1941B373E
	for <selinux@vger.kernel.org>; Fri, 16 Aug 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821781; cv=none; b=e/IUtKAP9T7qVIY5GiCw3XKklQeKFiuzZTHImowGPAkUyJbuu6Q57mumiAMrMuA9tIujxnUlW4ePHXwiU/COxF6SYxI761Fi3lrmWjhWi7iovoEfUVmDpiDCiftMquHLKuLwZYCwTKhLmrMtjxW3vZeq1FSuka4z+J7CZgqK4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821781; c=relaxed/simple;
	bh=fLvaTkGvRdLsgq5Dj0tSKLcokqAL19voXBCAjQTFulw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0jzgMu/BzuNzHY+sUUAaV5ye4g8545ko5Ov6XzojMiOJZhA5EyH+9Hixb947aMXZUnxLEJjXKjNWORbFngcgJZHLRKr99ybdhw38ZhAZtVkYSgUDzjA6jEIEEQzVZsSsT+NH1sSMVCn5RgarDMAhhSgZHuAyv0m7n80At6iABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=OlNfDSHK; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OlNfDSHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723821778; bh=MIFyQp1CEggY9pZdTeezYQ2752r9+comGSOIocVkolQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=OlNfDSHKNNiD4yGxpidyRJH1zd58xSuyYXXVpdpmde3P/epHkY4dVothEesD4TezELn2PZ/5scCiVoYMl/ucRfmq8qpKisfm/W9IIJS25JAbylxRSaCfpZZZ9D0hbVfV7d7uLLZTnYYALquZlA49QznvIGYC+/+Tr+WQrg7s7Bs40hLe3c7Jz7LGAs141aYqPfzBrEYtypktrpsvPEo0j60hjUmJnVBXCl7940ur9cC78twYl3T8ImEhssWo0zStC1lvxss90QMHXjfJz8h82dN6jacraRdzbvUbnSquaLM6Q2I2R0Rn8B6FsqgqoR+WgDWMnmxbcIDEPlJC+aYq9A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723821778; bh=DpXBlGZACuSCWAPlRLx2WjVe9PdDjJyz0z3eIfEGL7R=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jumVWwDBKj5FiUsyvnzy2lPisro+hmxGLB23qEnfU1+ZoMetnmSEg52du1egM0YOdUdR0ko6RfA53soWrjTPTu2/mHSXmh93qD6YP17RWt5ejNKiubw8vRKIAhu0LpsEFuvde5i0BCe8sugw3tPqymJZvqFEtGnYCa0RuKMH5Z0Df0qLaz9TJ4TudsJsTgkH3JEUu3KtuK2ABgO3AtEOucww7sbS1Eag6xcAxyC8CKhqyc0RItQoFOeMuU6YgToDt9YjJN3TqfF+u3dGSCOPpsi27Bn36YwnpIDzlJ6vQnzyqwW/5aeamke/Ut1y+/CXHeyUgIsXqZJbbbt2sdNL/A==
X-YMail-OSG: Yi_LE9kVM1k2fxr31ZlQmG1QrUQ_RrtbugaTSi0.ym_hIZDcTWoYc_xdUt5Dna.
 Vig4sUUqFzsKYkxDkYiVZwuCNEBD20EbNgeOC9XN96GPNerxNadtP.bE1gYLdbIaYYtwPWd1OjZc
 Fy0dZD7G_X70Vkv8soaCP5ozd6y0a1DtLT7_qACVHj9ZP1Nk4CVff58kaGF7vfCHZJ.PW9YvalSD
 oeoDSMF1j4EXMElXyzHrK2.mpegpOrn0HiXGn1_LT.ClOFkkdsKGDmctvAFM.uDOS5D6r4IePeQ7
 aAi.Z6MG7cNG9N7CBgqqaqSr4F9cnlCXEhgYXsqqr3MzKG5gzDT7ww.f5Y6Czzl90npk7faTwYpm
 _b6L36AZDZvcuMvJwmiSKQwWMPRowhRD7G77Eed.eeO.iDSPnPnnNv7pi4yIcBrygm1FtFb0SFhI
 9nTD6HvANUIWHHKr5HkMAeFhBVhsR9lw9HDmzLJCW6D4B2rGqDCbU.yZymb9OsfWPH40G_p.yRH5
 Koq.t3lJrXTuLFnEE3oa3kfCjgfqpOCK.QCMcs_MqVHrBOnpQokp0A8E5YVCkeDXlHeIcpgj7SFy
 MvO6GyfvMfpHCegcDV3X3RoAjyUuu_nMbAD2p7LX_fHr5nR9DvtbRD9DQ3n.7lIQ.hLrEJZx9l1J
 BWvuzHnTEYgEci96qvx3OuyWpRL3c6aSDasRQQGevcxf3ReUTLWmX7J3KqJ_N3djHsmjjg6kS4_V
 lkhwsdpxKV4TEWG2sn.htVGDsXJCUkLFMcG2GmIb0B606D_7yOfT_FLrwWbXk1wPYSRyoETO.5qy
 Dj4gNYVGda3suCrCdJCq7DtKqNGHcKHgkPnZrvmGfZjEGx1kynMhawP.fzUc88fMERgDXRAtOST1
 As1Iuy1sed2pXUavpqI205CEInwQIL_UtfZOHIMYzlJSUwGRPHw7jvYgBR1NZ2M0r5yqKTUiW_D3
 jsZV5DYnA0K2F4jVcLBsdk144loc0LdtWUGs28zmz9uDzcrWWu.paUjeEnglVo7D8iuRpCK4Yyro
 iswv3uFWRcYRQmn4hpgA0x6vwffz_xuupwrLIJINK4B8ej0v1x51CWe6zJNiFAoNqsFnGHlrd02H
 _bg8xc_8wyPUmz19qE0GGixXyDe_N9cs_uE6jdjq13b4It_zHfXpZDnHz6Rtjh7p.2t7jo6r6.eR
 CRRvwkzlkM5alX27ej.UwzFOpvpTPpXpFTutpID8o7NUFTqwOJKFa8H5xfXJ5WGfSkDPdNYrawpa
 Du36eoDZUx87v33DnMBUxHJDvsXyfs5XhIQcddziJLlYtXjqN54gqBvnQ47b1gn6R9jlOrMNVggu
 q12_2kN_G4UDw4d_4VlG.mUCc0NcCnIRfB2kkmn6RSJPkvYyWpKAkLNtoHvDYS1gB_tFgKWodvQW
 fZ7q6cj75IFUpxrvgnDk3QqxMKxPhQ1t11aFRTM0g.Ila0xmwiSk9nw77_Hd7sw1Bf1zhYIXt_rI
 HJD4TwyMZww6tuz9iEg2LO5q5qLja3_8BaAtPVIeWiB8Om5JktyOngVhADsx_X3ru5mNHMU3Arol
 X2rGzLsYP.hgKkkabIHe9xTcNeO.ioW82E0FZvZmvczEszMrxTyqWGf0KTlRAU_9QJSr6wIQPN4k
 HY7bmzv42pa1VAg2N.fDs29bxoPbB.bNqW2Y6Z29u01LHA4oMnP04U2vIIh1C1HXWiNbYT3fsc_C
 qrsJiQoiENhXMi2CxC1qV4ncZttTd8axSiEfjMUOTstNZ4WvwhWeDm2r6MHjy1q0_965c_QJPGd8
 B0GixBRE1SG0FAcu28mEl2OICjJFU.ejSNFHJsgz8SlC6AugmaaCAHiwGwtZLM49VvgghI0mCDZq
 fitdNp8_rUtcpH8kNwGP609717emx6UZZj0i_hF9X3nmg0ePWMiXEe4GaM3Fa1.94Rjf6U_V2mRq
 lGNVzFG3Sz5ypCoDPizfguCgt0gR86UxX22355NQ6cfScFW.cQQD72DAi_.YQwDQKh8vOf.CFFCK
 8en9xNlEa4V_z7MTzdTKuNP5iXPa.sY99W6RQKUxkwKLmll7Vlp1C1xjtnK27.1IaxhR6Tu8KMV7
 FTKl82P2unyC1B2dgAk5WLBJDc.ieusM9hKByREFo9McawhVqR9AcFaflpMYPN.jWOLEBE5fOo7U
 Uyxa0PRm6p2s8XDoYuevhvkAf.VTuKr4oN2F3QyAeIxsl8tJhInHdls0nMLen_RBxZ4fBfVxqarA
 tK2m6HrVQWz0e8hkpUTafJCOSGyW1EIkMP2Q944miZC.xNnELVGu0Hqcd6E8iHGoZXh.yUojeBPj
 poJtj1Vf.IFKfu_ufiekF_cU-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 811c09c9-1a34-4384-a35b-421b3a72e0e5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Aug 2024 15:22:58 +0000
Received: by hermes--production-gq1-5d95dc458-5j27b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dee787246a3caccfbad7a506c49f3fa7;
          Fri, 16 Aug 2024 15:02:41 +0000 (UTC)
Message-ID: <9aa53afd-efd8-4552-8239-14f99ff7a1b1@schaufler-ca.com>
Date: Fri, 16 Aug 2024 08:02:40 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
 <CAEjxPJ7WUzN=0Yv4POgPVHPG1wEjNn=-Tb53NiuMpWf+bEuF-w@mail.gmail.com>
 <CAEjxPJ758jx7X5Tauz=xQXsmWcZhx_V7AkU=PtsH6S3S9CUCbw@mail.gmail.com>
 <CAEjxPJ50ADVSOys58eYUktv4sjYYnEDroxA9Wnt6HiY9ySk=gg@mail.gmail.com>
 <CAEjxPJ6QsYR-Kj8k0C=54cix8rdpBsCphDV5_QnjGONDuOm+ew@mail.gmail.com>
 <CAEjxPJ6p3oD99_aTEeSCx6FMob7BH8-2vxdoT69c8sw11oHuEA@mail.gmail.com>
 <CAEjxPJ5jup5o9piVPuA97_radSzvshpnRB1CdBde8sV3ZXVc2Q@mail.gmail.com>
 <CAEjxPJ7UtCjQw=v1--6ZWXo-bbkndGbwfXhcT8RkX_cddjCqkQ@mail.gmail.com>
 <CAEjxPJ5a1KzSjB31gcqWqJW_zdy8OCmwKKGYwCivvFG4Jvncyg@mail.gmail.com>
 <CAEjxPJ6WupdxzSkh54NLJkZoH=Umayj8+HrX5TmbAXvVYzgPfw@mail.gmail.com>
 <CAEjxPJ7iL11xSVs4gxhMPSCtVmYEqfgQQmBpVNAVXV7UG=P3nw@mail.gmail.com>
 <CAEjxPJ7C41QdEgAFYVdTyZE=TjGq+pyzCmy7BbHMss7=njvJmg@mail.gmail.com>
 <CAHC9VhRDF0DBAWM-=ynks1=Zm5LcQYq0_4xfQy4pKvHfW6FoBg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRDF0DBAWM-=ynks1=Zm5LcQYq0_4xfQy4pKvHfW6FoBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/8/2024 1:53 PM, Paul Moore wrote:
> On Thu, Aug 8, 2024 at 7:59 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Wed, Aug 7, 2024 at 1:02 PM Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>>> On Tue, Aug 6, 2024 at 12:56 PM Stephen Smalley
>>> <stephen.smalley.work@gmail.com> wrote:
>>>> With these changes applied, the following sequence works to
>>>> demonstrate creating a new SELinux namespace:
>>>> # Ask to unshare SELinux namespace on next exec
>>>> $ echo 1 > /sys/fs/selinux/unshare
>>>> # Unshare the mount and network namespaces too.
>>>> # This is required in order to create our own selinuxfs mount for the
>>>> # new namespace and to isolate our own SELinux netlink socket.
>>>> $ unshare -m -n
>>>> # Mount our own selinuxfs instance for our new SELinux namespace
>>>> $ mount -t selinuxfs none /sys/fs/selinux
>>>> # Load a policy into our SELinux namespace
>>>> $ load_policy
>>>> # Create a shell in the unconfined user/role/domain
>>>> $ runcon unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/bash
>>>> $ setenforce 1
>>>> $ id
>>>> uid=0(root) gid=0(root) groups=0(root)
>>>> context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>>>>
>>>> NB This new namespace is NOT currently confined by its parent. And
>>>> there remain many unresolved issues.
>>> A couple of additional changes pushed, one to fix a bug in the inode
>>> handling and another to introduce support for revalidating superblock
>>> SIDs and updating them as needed for the namespace. With these
>>> changes, the selinux-testsuite filesystem-related tests appear to pass
>>> within a new SELinux namespace. Other tests vary - some pass, some
>>> fail, some hang.
>> I think before we proceed further with the SELinux namespaces support,
>> we need to decide on how we are going to handle SIDs since that has a
>> significant impact on the approach. There are (at least) two options:
>> 1) SIDs are maintained per-namespace; this is the current approach in
>> the patch series since the existing SELinux SID table (sidtab) is
>> actually a mapping from SIDs to security context structures, not
>> strings (with the exception of undefined contexts with the deferred
>> mapping support), where the structures contain the policy indices for
>> the relevant user/role/type/level.
>> 2) SIDs are maintained globally, e.g. we introduce a new SID table
>> outside of the security server that maps SIDs to security context
>> strings (hence policy-independent). This would be more akin to Smack's
>> known label list that is also used to assign SIDs, and would provide a
>> stable pointer for context strings that could be cached in the inode
>> security blobs without needing to maintain per-inode copies of the
>> context strings.
>>
>> I started with approach #1 because that was how the existing SID table
>> works within SELinux. However, approach #2 has a number of advantages:
>> - It matches the LSM hook interface handling of secids, which assume
>> that secids are global identifiers and allows kernel data structures
>> outside of LSM to cache and pass secids back into the LSM later, e.g.
>> for audit and networking.
>> - It avoids the need to revalidate and re-map SIDs in the object
>> security blobs prior to each use since they would be global,
>> eliminating the complexity associated with
>> __inode_security_revalidate(), sbsec_revalidate(), and doing the same
>> for all the remaining object security blobs.
>> - It would remove the need to instantiate the network SID caches
>> (netif, netnode, netport) per-namespace.
>> - It would potentially allow for a global AVC (currently
>> per-namespace) aside from the question of how to handle the policy
>> seqno and when to flush the AVC (e.g. introduce a global policy seqno
>> that is incremented on any reload in any namespace?).
>>
>> Given these advantages, I am inclined to switch to approach #2. Thoughts?
> I agree.  I gave this some thought when I was thinking about how to
> handle persistent storage and I think adopting option #2 (global SIDs)
> would help simplify things significantly.

You can achieve a significant performance improvement as well if
we change the SID interfaces to use pointers into the SID table
instead of SIDs. v39 of the stacking patch set included a struct
lsmblob that would make this easy. Alas, there remain some networking
interfaces that will require u32 SID interfaces for the foreseeable
future, so SIDs can't be abandoned completely. I also question whether
this might be the issue that fully brings the security server layer
into question.

