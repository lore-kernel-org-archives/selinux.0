Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0C9YgSV019649
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2012 04:34:42 -0500
Received: from mail1.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q0C9YfmI028778
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2012 09:34:41 GMT
Message-ID: <4F0EA92B.20400@windriver.com>
Date: Thu, 12 Jan 2012 17:34:35 +0800
From: Pascal Ouyang <Xin.Ouyang@windriver.com>
MIME-Version: 1.0
To: Xin Ouyang <xinpascal@gmail.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, <eparis@redhat.com>,
        <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 20/25] libsemanage: Fallback_user_level can be NULL if
 you
References: <4EEFAC91.6060903@redhat.com> <4F0EA482.5050109@gmail.com>
In-Reply-To: <4F0EA482.5050109@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry. That should be "segfault still exists".

This patch could fix the segfault without
"0020-libsemanage-Fallback_user_level-can-be-NULL-if-you-a-1.patch".

Thanks.

- Pascal O.Y.

On 2012年01月12日 17:14, Xin Ouyang wrote:
> segfault still not exist.
>
> 1. Download and extract refpolicy-2.20110726.tar.bz2
> 2. cd refplicy && edit build.conf
> TYPE = standard
> ...
> 3. make conf && make policy && make load
> ...
> make: *** [load] Segmentation fault (core dumped)
>
>
> The attached patch will be OK. :)
>
> - Pascal O.Y.
>
>
> On 2011年12月20日 05:28, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>> This patch looks good to me. acked.
>>
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.11 (GNU/Linux)
>> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>>
>> iEYEARECAAYFAk7vrJEACgkQrlYvE4MpobP4ewCfUTl1JHSaXTpPtNUn1yJWDo1j
>> TMgAn0HPi8GRUqi8WdOugTGJReqXBKUV
>> =MQcr
>> -----END PGP SIGNATURE-----
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
