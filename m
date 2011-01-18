Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0IEMAC5029802
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2011 09:22:10 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0IEM8CL003564
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2011 14:22:08 GMT
Message-ID: <4D35A20A.1020400@redhat.com>
Date: Tue, 18 Jan 2011 09:22:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Kohei KaiGai <kaigai@kaigai.gr.jp>, refpolicy@oss1.tresys.com,
        selinux@tycho.nsa.gov
Subject: Re: [refpolicy] [PATCH] New database object classes
References: <4D01F7A4.90708@ak.jp.nec.com>	<4D2FEAE9.8080201@ak.jp.nec.com>	<4D3057AC.3040903@redhat.com> <AANLkTi=vHcJBGpUKQa0VZDtnFJGQ8Ozgmt4mhihYH-r+@mail.gmail.com> <4D345E39.1070905@redhat.com> <4D352D3B.8000303@ak.jp.nec.com>
In-Reply-To: <4D352D3B.8000303@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/18/2011 01:03 AM, KaiGai Kohei wrote:
> (2011/01/18 0:20), Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 01/15/2011 07:48 AM, Kohei KaiGai wrote:
>>>>> How about getting inclusion of this patch?
>>>>>
>>>>> These new object classes and corresponding rules are necessary
>>>>> to run SE-PostgreSQL based on the upcoming v9.1.
>>>>>
>>>   :
>>>> KaiGai, I believe we have your patches in Fedora and RHEL6, If not
>>>> please ping me to add them.
>>>
>>> I'm not certain about the latest RHEL6 policy, because I don't know
>>> the way to reference its repository.
>>> However, these new object classes are not included within the latest
>>> Fedora policy right now. I checked it using "fedpkg co selinux-policy".
>>> Do I see the same tree with you, don't I?
>>>
>>> Thanks,
>> Please send me your latest patch.
>>
> The attached two are for RHEL6 and Fedora. These patches are made up
> based on selinux-policy-3.7.19-29.el6 and  selinux-policy-3.9.12-7.fc15.
> 
> Don't forget to add the following line in %fileList macro of the specfile
>   %config %{_sysconfdir}/selinux/%1/contexts/sepgsql_contexts \
> 
> Thanks,
It looks like your stuff is now in
selinux-policy-3.9.13-2.fc15
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk01ogoACgkQrlYvE4MpobNSjACgmPqSmScrwalpoWA/zTtQiB8n
/JIAoJQFKt9X/06JBWHQz/MPGFXhpJnV
=qfaA
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
