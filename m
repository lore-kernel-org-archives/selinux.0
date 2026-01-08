Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093313563EA
	for <selinux@vger.kernel.org>; Thu,  8 Jan 2026 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862655; cv=none; b=SbAo7JWwv0YR6II+t3wryfuPjByHm7L1a7q/Z+eJs8c8dIGl+xzt6+gYA61a73BUbFLRGUrU0G5zUVk/WjUm9QQ3ddtqQPcFscrOZjQBiGxChL0dj9quHQdT1ZDouwreGk0spnvsSjMfPFlqSCprtj67bcKwmOMq9fD7aYuTb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862655; c=relaxed/simple;
	bh=YZdDiqjPhgzu1t06dqsKfSRXVHrUFJk1xD8q3oJLcDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=biYJd9hO7GGSzudCUcGLCdCZfb8QmdtIna1Ef5hsw0iIF1mcw5+2o1KOa705rwjOK4Rl3nEH4kSD25AhGbZCKcpxZSW3dXFKT4yHcxEAXjYgTrA6YB0G9cqiOJMtVbf1VBlJQK0letXcV4PUFD3A0NqmxoC/5Wwquj9WmdqxmAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCS9tKAo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCS9tKAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767862643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OoMqqKEMophNpuQS8oECxtNAD3osl3IKbxVl1JimFfw=;
	b=dCS9tKAoTytgHpz9cH5VSP0BfhbqneeweDavmBvWYR7zbE+3cni/L1DQoVO2kUlVXsnFXr
	XHMtasK2nc8u4MrSdgYaYLI4RTekDA4KlC45BcvpfoNl69LQ+dHBMiI6RFCTGCiXlN9o/I
	Bg4iKKyzU8p8Eit7Xhb6Rc8JhFaSkHM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-Sa7yrZBwMzSTvI624jhJSA-1; Thu,
 08 Jan 2026 03:57:20 -0500
X-MC-Unique: Sa7yrZBwMzSTvI624jhJSA-1
X-Mimecast-MFC-AGG-ID: Sa7yrZBwMzSTvI624jhJSA_1767862639
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38F5F19560B2;
	Thu,  8 Jan 2026 08:57:19 +0000 (UTC)
Received: from localhost (unknown [10.44.33.184])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94CAC18004D8;
	Thu,  8 Jan 2026 08:57:18 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
In-Reply-To: <CAHC9VhQmYLMqFzytgauijn_C6TXksBVsptEdNb2ZcyKFT8fsCg@mail.gmail.com>
References: <20260105174020.887724-1-lautrbach@redhat.com>
 <CAHC9VhRaKE2fuXik5xxaw5i1f9QgveFj0_FgzMVyRCHebueZGQ@mail.gmail.com>
 <87h5sxvd52.fsf@redhat.com>
 <CAHC9VhQmYLMqFzytgauijn_C6TXksBVsptEdNb2ZcyKFT8fsCg@mail.gmail.com>
Date: Thu, 08 Jan 2026 09:57:17 +0100
Message-ID: <87cy3kv5w2.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Paul Moore <paul@paul-moore.com> writes:

> On Wed, Jan 7, 2026 at 7:08=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
>> Paul Moore <paul@paul-moore.com> writes:
>> > On Mon, Jan 5, 2026 at 12:46=E2=80=AFPM Petr Lautrbach <lautrbach@redh=
at.com> wrote:
>> >>
>> >> The key is available at:
>> >> https://github.com/bachradsusi.gpg
>> >> https://plautrba.fedorapeople.org/lautrbach@redhat.com.gpg
>> >>
>> >> Also update the email address
>> >>
>> >> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>> >> ---
>> >>  SECURITY.md | 3 ++-
>> >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/SECURITY.md b/SECURITY.md
>> >> index 2a7ce5b317a7..faa060ccff03 100644
>> >> --- a/SECURITY.md
>> >> +++ b/SECURITY.md
>> >> @@ -24,7 +24,8 @@ list is below. We typically request at most a 90 da=
y time period to address
>> >>  the issue before it is made public, but we will make every effort to=
 address
>> >>  the issue as quickly as possible and shorten the disclosure window.
>> >>
>> >> -* Petr Lautrbach, plautrba@redhat.com
>> >> +* Petr Lautrbach, lautrbach@redhat.com
>> >> +  *  (GPG fingerprint) 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1=
 C13E
>> >
>> > I think you may want to list the fingerprint of your primary key and
>> > not a subkey, as the primary key is what carries the signatures and
>> > helps verify trust.
>> >
>>
>> I guess I need help then:
>>
>> $ gpg --show-keys --fingerprint lautrbach@redhat.com.gpg
>
> You want to use the key fingerprint which displays when you run 'gpg
> --fingerprint <email>'.  Assuming you have the keys for the other devs
> in your keyring, you'll notice that command can be used to reproduce
> the other fingerprints in the file.
>
> %  gpg --fingerprint plautrba@redhat.com
> pub   rsa4096 2012-04-03 [SC]
>      E853 C184 8B01 85CF 4286  4DF3 63A8 AD4B 982C 4373
> uid           [  full  ] Petr Lautrbach <plautrba@redhat.com>
> sub   rsa4096 2012-04-03 [E]
> sub   rsa4096 2017-12-05 [S]
> sub   rsa4096 2017-12-05 [A]

I've also changed my email contact address to lautrbach@redhat.com which I
use for some time already:

> From: Petr Lautrbach <lautrbach@redhat.com>

> -* Petr Lautrbach, plautrba@redhat.com
> +* Petr Lautrbach, lautrbach@redhat.com

> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>


$ git log | grep lautrbach@redhat.com | wc -l
175

$ gpg --fingerprint lautrbach@redhat.com
pub   rsa4096/FB4C685B5DC1C13E 2024-11-04 [SC] [expires: 2026-11-04]
      Key fingerprint =3D 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E
      Keygrip =3D 834230A0854D7A8698B5432C007560FE7AECC504
uid                 [ultimate] Petr Lautrbach <lautrbach@redhat.com>
sub   rsa4096/C500C028A770AB66 2024-11-04 [E] [expires: 2026-11-04]
      Key fingerprint =3D 58E9 06B2 5680 15A7 91C8  D2EC C500 C028 A770 AB66
      Keygrip =3D 2EF1D48B43E234CAAE155A0AD032C00063FCB102
sub   rsa4096/CDCAE8C927C6BE31 2024-11-04 [S] [expires: 2026-11-04]
      Key fingerprint =3D 7200 EB2C 3F5E 4884 63C0  CE9E CDCA E8C9 27C6 BE31
      Keygrip =3D CAE3E6B80FFD15958C813CC635CFFDF9F86D9C17
sub   rsa4096/37BCD711A64B2890 2024-11-04 [AR] [expires: 2026-11-04]
      Key fingerprint =3D 832F CF4A 82B0 7F2A 51E4  3DDB 37BC D711 A64B 2890
      Keygrip =3D 850707DAF56607DEABD28933FD0A77D382923F1C

pub   rsa4096/BC3905F235179CF1 2022-10-26 [SC] [expired: 2024-10-25]
      Key fingerprint =3D B868 2847 764D F60D F52D  992C BC39 05F2 3517 9CF1
      Keygrip =3D FA0CE92171EEBAC2DD084E6399F18709A2F7353B
uid                 [ expired] Petr Lautrbach <lautrbach@redhat.com>




> %  gpg --fingerprint paul@paul-moore.com
> pub   rsa4096 2011-10-10 [SC]
>      7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8A
> uid           [ultimate] Paul Moore <paul@paul-moore.com>
> uid           [ultimate] Paul Moore <pcmoore@umich.edu>
> sub   rsa4096 2018-10-15 [E]
> sub   rsa4096 2018-10-15 [S]
> sub   rsa4096 2020-06-19 [A]
>
>> >>  * Nicolas Iooss, nicolas.iooss@m4x.org
>> >>    *  (GPG fingerprint) E25E 254C 8EE4 D303 554B  F5AF EC70 1A1D A494=
 C5EB
>> >>  * Jeffrey Vander Stoep, jeffv@google.com
>> >> --
>> >> 2.52.0
>
> --=20
> paul-moore.com

