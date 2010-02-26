Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1QI86Ar001784
	for <selinux@tycho.nsa.gov>; Fri, 26 Feb 2010 13:08:09 -0500
Received: from relay1.gtri.gatech.edu (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o1QI8Spr023776
	for <selinux@tycho.nsa.gov>; Fri, 26 Feb 2010 18:08:28 GMT
Message-ID: <4B880E03.1040903@gtri.gatech.edu>
Date: Fri, 26 Feb 2010 13:08:03 -0500
From: Joshua Roys <joshua.roys@gtri.gatech.edu>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] netlabel: fix export of SELinux categories > 127
References: <1267030357-26366-1-git-send-email-joshua.roys@gtri.gatech.edu> <201002241852.44136.paul.moore@hp.com>
In-Reply-To: <201002241852.44136.paul.moore@hp.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms080205080105020301030606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--------------ms080205080105020301030606
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

On 02/24/2010 06:52 PM, Paul Moore wrote:
> On Wednesday 24 February 2010 11:52:37 am Joshua Roys wrote:
>> This fixes corrupted CIPSO packets when SELinux categories greater
>> than 127 are used.  The bug occured on the second (and later) loops
>> through the while; the inner for loop through the ebitmap->maps array
>> used the same index as the NetLabel catmap->bitmap array, even though
>> the NetLabel bitmap is twice as long as the SELinux bitmap.
>>
>> Signed-off-by: Joshua Roys<joshua.roys@gtri.gatech.edu>
>
> Ha!  I came to the same conclusion and sent you a similar patch a few h=
ours
> ago (should have checked my SELinux email folder first it seems).
>
> Acked-by: Paul Moore<paul.moore@hp.com>
>
> This should also be sent to stable - James or Josh do one of you guys w=
ant to
> do that?
>

Cool!  I'm glad we came to the same solution, although next time I'll CC =

you directly to avoid doing duplicate work.

Thanks for your help,

Josh


--------------ms080205080105020301030606
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Zyz9ukkJX7M9+hL8UgAAAAAAAA==
--------------ms080205080105020301030606--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
