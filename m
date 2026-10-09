Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3DB4DA9B3
	for <selinux@vger.kernel.org>; Fri,  9 Oct 2026 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549016; cv=pass; b=OrQz84j3aURXjD3jMx5dq3Ze4kpHxWLU/ZT8gLYYZ3aO5LxnGRi0wvNO72SlQZOsL8vqeVLQjVOmzfJe6Orzww0Dze3zUxqmGpx35wTbwduv53ItxdK8kySIH86taEfREtdH6qFOMk0hfygtYuGAXOmVyGGd2IAODY5Px7CkVx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549016; c=relaxed/simple;
	bh=Xl0apDYJgM3vn1nys+iidPPtsOZH2es30W3H6QtHHxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBp+QcIu5rhPjISQTUE3FVEIq+SSkKVwFPj7fR0l7leneYGM7Tem+HbWr3NvyLj2hFHXhsF13hWhjkwbg4gL/iiwjFyiaJ8/Dm3jSBLHx7UBOOx3usx9J8bieYlVg1HEhJaqLBTt8oWtlMDt3L55VLtW6VvWdjuQVPCyVaEa3PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFQQq9NX; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFQQq9NX"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8726acc5eadso33007387b3.0
        for <selinux@vger.kernel.org>; Fri, 09 Oct 2026 05:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791549009; cv=none;
        d=google.com; s=arc-20260327;
        b=j5di/hn7fkwVhwe6+kJaib9fkx+6QT6KNYAJW1fSMRGE2AuEqCpKlMy+y70CR+4hZj
         R0IgW9TjIhEFj+D1g+ejW+hbPTHKeh/1b/meb1PDIAf2WU4hxRhuInmPi2YcLwwtyHDZ
         aZhhhOyCprnLv/v8EZJD/ZLgWnnE5QJrUZOmnIFCd7G3/Nhwe7raFJpgOBtAgEUwBSvr
         UTJpFsCWmoLp3G4bCWA7IU3vyepaBBpHp45mgvpWTA1XsO2XZckL40LpdgVU1+14q+Hn
         tmJUcjLJS3nU9PKgvpqXtzNbS/x4NwsCC+NDucfIhwt/YEz7f8MlyFoT1sI4H7URNHl7
         ssqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xl0apDYJgM3vn1nys+iidPPtsOZH2es30W3H6QtHHxY=;
        fh=0lV2+1N9LYX6/0U2UvxMCkn2c0ttJ1RBNIVPFMYdkF4=;
        b=JMoAtgHd8qCaHQkfjU0Y/faHp6tfTtE16DVAPfzE0/jymyYMl1+VdhfmmaiGmyBw13
         oxNI0QuLoflSudNppmZDsWSmHJUZUeQ6f8/EfzoK+YI49HsK1wIM2cY3sSBI5GPwlwf0
         5eWT0VFIcikh3Cg7YIjaLvuJz1t+ywRvA32HOnaHIRh3/QXPQhZB6o4nuUySBWI8K1EJ
         yu2iQvskAeSRTGUsX+SGXbeRB1lRBHRDVuq1krWKLKozqFASVRIj7eXuYdKxpJVOdTF0
         uOWKDMEZVvQReNiSE0DVLUGNSObf9XhGBQw2s2PqDCVGacTgxlDMCR3+eTo2MfP185ya
         OVoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791549009; x=1792153809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xl0apDYJgM3vn1nys+iidPPtsOZH2es30W3H6QtHHxY=;
        b=UFQQq9NXngJXXFTXhDBXAGKDMeBor5xJJBiaknFT7EGybJ7YOImgzk9ZLHpOHA+a9G
         DDblIkywmmulDxqKNELJr110VGno7sttnh3JTqSh3s1YTYjRT5N09nhLeY8dYZnyiaYW
         AYfWMsjxqi3eHXB8YI362uKU8+XJyOXfjbsuiM5lRVquhZJ4QsW9tRwd5WPROaym2Kzr
         KGbpobbizhrmm4PiioKcAPNi30pBEABERGVmCIEDXtGJdQUp8P5njAdNL169qBNvcmpK
         stnb4gTWUIDAXTkRadtC62q2Y+o9Py6BA9YkJFqgC3W0ObAG2OkaxVaGjD9w0vGSHvSe
         r90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791549009; x=1792153809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xl0apDYJgM3vn1nys+iidPPtsOZH2es30W3H6QtHHxY=;
        b=hlxbh34MMzYGIUGF/uzJmCr0v1Wr3iKza0aRyOugTUy6wn8brk2Z9KJ7Kv7exwdqiE
         Tmb7cfV7OjGecgIjyTLJW8iicv0M8tFSbhKKwtsm0IhgJJCheP1h1ZpXGRk8LaZFnWV6
         RXB9b0PsipHvqT65mxiDf78Vn2a/fD6i1OeDMe1pYGWWpxlEqGuYuqsih2YaKN5UR13o
         a6iVlMzCTrq0ezcL+3zScwl1ecHi28wM7Iqry2aDt639e2tKFrbFyAxAJRTJSpMvxaAr
         D5ZyNTajzzcHFy5yyvla2nqwP4hgxzk2in/cjbOoUwCT+9F/zCC4CLZdOMiflYgkG6mb
         C+ZA==
X-Gm-Message-State: AFq9FYIHZP08UjiTTssDEce/NVWAnPJyInsSZnRaRMr61Q5h4qjd6LYY
	kAcqhl5mb21kGAyNgXbJf7WARNe2ThqJQi1RDbTMIsqI2aY5qsYgXPDxLkBt86g9BWyyqxqrwjt
	5CtRXja41guG/8G7ELnexo+7iNCG1tjJu0i5E
X-Gm-Gg: AYBFou0Mfu5sf0J9sTDYcP9qMBxNjqmhe06/6Y1/FUnoWhdw13Bxv/rJSMICuXELds/
	eBCYGdzJB5WkMjUmKLWDt8UMn/qjfI8gysScxp1BMdMIdQLPgfOb8TYd7akBEGRhK1E+Z+I/e61
	NHU1NImFeULfHtKDCs3C7G1WTWIzzbJqXABjGIoPowno7DGDRYYEkSdfCrOIH4kJWDOfsOND+7/
	Sr0HEfqgA6NY/nEWa5XQ9buROgCAYNt8/rOMv/CU9g9FxIQriF/nfnIKiKcg41QHUDbTFWBnBdk
	YToUeFTEFeStRi7Ehl/DRX9o4Zb0uJJ4nKaIgS7Yz77UvhdQTFC37kI=
X-Received: by 2002:a05:690e:4853:b0:677:d6b1:d95f with SMTP id
 956f58d0204a3-67936a2eca2mr277195d50.75.1791549008676; Fri, 09 Oct 2026
 05:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4Uh+_GsevF3xtxeKPkz=KAgwj-=+JNq3Uc7SWrLDq04Q@mail.gmail.com>
 <20261009055713.16085-1-esgor@altlinux.org>
In-Reply-To: <20261009055713.16085-1-esgor@altlinux.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 9 Oct 2026 08:29:57 -0400
X-Gm-Features: AclHuK8z8FJECjDj5ci1ZLd4sWge_oTlZ73EwvDMptvuJ6os9Fk2BCVdcDdTlIg
Message-ID: <CAEjxPJ6kCc5y8bbPnqVgjyGOpxKRrBKHv4b-EFregua3enYftw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: avcstat: reject out-of-range interval values
To: Evgeniy Gorbanyov <esgor@altlinux.org>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 1:57=E2=80=AFAM Evgeniy Gorbanyov <esgor@altlinux.or=
g> wrote:
>
> strtoul() returns unsigned long, but avcstat stored the result in a
> signed int and passed it to sleep(). A value above INT_MAX becomes
> negative, and sleep() then treats it as a large unsigned duration.
> Compare the full strtoul() result with INT_MAX before narrowing it.
>
> Clear errno before strtoul() so a stale ERANGE cannot reject a valid
> interval.
>
> Signed-off-by: Evgeniy Gorbanyov <esgor@altlinux.org>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
