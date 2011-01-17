Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0HFKYga027920
	for <selinux@tycho.nsa.gov>; Mon, 17 Jan 2011 10:20:34 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0HFKU19004696
	for <selinux@tycho.nsa.gov>; Mon, 17 Jan 2011 15:20:30 GMT
Message-ID: <4D345E39.1070905@redhat.com>
Date: Mon, 17 Jan 2011 10:20:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Kohei KaiGai <kaigai@kaigai.gr.jp>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, refpolicy@oss1.tresys.com,
        selinux@tycho.nsa.gov
Subject: Re: [refpolicy] [PATCH] New database object classes
References: <4D01F7A4.90708@ak.jp.nec.com>	<4D2FEAE9.8080201@ak.jp.nec.com>	<4D3057AC.3040903@redhat.com> <AANLkTi=vHcJBGpUKQa0VZDtnFJGQ8Ozgmt4mhihYH-r+@mail.gmail.com>
In-Reply-To: <AANLkTi=vHcJBGpUKQa0VZDtnFJGQ8Ozgmt4mhihYH-r+@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/15/2011 07:48 AM, Kohei KaiGai wrote:
>>> How about getting inclusion of this patch?
>>>
>>> These new object classes and corresponding rules are necessary
>>> to run SE-PostgreSQL based on the upcoming v9.1.
>>>
>  :
>> KaiGai, I believe we have your patches in Fedora and RHEL6, If not
>> please ping me to add them.
> 
> I'm not certain about the latest RHEL6 policy, because I don't know
> the way to reference its repository.
> However, these new object classes are not included within the latest
> Fedora policy right now. I checked it using "fedpkg co selinux-policy".
> Do I see the same tree with you, don't I?
> 
> Thanks,
Please send me your latest patch.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk00XjgACgkQrlYvE4MpobMefQCg4dQ7Ly32ED1hGfxlsc8EVqSQ
/vUAn1cMj5jooXAiwm3+McKnI53ypM0I
=FmtN
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
