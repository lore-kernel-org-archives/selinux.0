Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C99433D6F9
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307556; cv=pass; b=hhiKq6dCcBblaD10baLaH/sjlU1+BHAFEPAA5lxG3cnk0lgmUwxunz0OZEyco7mLw90FUWJ7G5oLodz/GjGK4woP928L04tbmiAg0QQ+GECmy9CNzdmGheZP8NyrqfqRt3knS8wt8w8S9dRRSs9Jy9caP/GjrmCarLCQ+3fwpqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307556; c=relaxed/simple;
	bh=BtSeVz+1vYfojd6IDl9q3iCBFH8FgvM9XJKUESWeHTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRF268lb4m2j0gOjMndyDGn1xewRbxzLXbp0yXutDJ3vAzrVI+3V9uesP0pirD+tpecK4koKI1FEk6w4EyoKptzGU4JBQB3XBgRB2Quo62KlNccU6QIVv++iJosTQ3pAzMtXpOGXA0mlCn8NHLIMxqU3fAe1JU/sFTvqU82daXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FouGXYb6; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FouGXYb6"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8c6fc5fd3so6128444e87.0
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 13:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779307553; cv=none;
        d=google.com; s=arc-20240605;
        b=Mdg9wDU08a+sc9z5hAUzICziPx3rDuYnIyeCiKQ8zbvBLql7V3w37pwJmZxM7ueIO+
         DIwfKw4dysQJ2APf1B/673qQTwhctkMMgLwayfkiaskeiP5abQG6+vsW1y6xIgMkaHsD
         CgkGZ11JoIVSdslOUSZoOEsdP4BBurScFJ3KE9ToJDaKGXWdbkL6wRCUxs30R/VDOf/p
         DlfGIakmizur8gswjybl7Ph7LgMx4PseSefCEebBIV2zDQ9LlOtqdYX2RzG2OOyms6eD
         SlonxomEu69+g/kFECWCuDcu2YZd+B/6Wh3FqPN+T404W+OhubOX/gOGBkT8ab8xT55K
         YIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/Hc+sN7WhPfu52dJbGtJeYyfKuX8McU4Nd7LhLCxvM=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=jKZnZGgWzuOOlHfcjFlPtwAB3g5V2J5IkqfDOQW7iyEHfdDuShmKGMbViaaTb280UJ
         oooiIScRtHGdjJJINsX7vjdCr4v/yTQMjQ0/jToOMuz8ukP72Nger3J2mRtPePtaUdH7
         gLvQz/vgGmOumbwLFxaUatWabsgGuSsQfla0aplsypTMwO5veBo7LYPwqscb3pIdtiCL
         VyQ3ipE/AkKQMLreaFaYA5l5wuJrt+QpQHXv7Mawpjvl6SsHYRK4S8uW5fpbCY8eNeiz
         gBEKZiLQTDtCDAJWDc6vGMWLQ1pAs9L/dC4OIyOWJJLFY3wqXDajikHHU6nZXqiU0tBH
         cAIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779307553; x=1779912353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/Hc+sN7WhPfu52dJbGtJeYyfKuX8McU4Nd7LhLCxvM=;
        b=FouGXYb6PDxEaafg2C97AYrhMbUG5pRi+8/BzG9eu9U6C6MjNKYCEVTMlKEKMpmMUE
         aSSZy3cIY4ZfIRjSHwFmbadj8PHB7cbPz3jlym/Fam2QaflwqzJJ5HtBQ8K1FP3UVOut
         YLxPBLLIeKFDdI4y/87lYjalJC5cXRqeEGJPxxWiTmfRpPTi4lQo8FDWgg3hKl93JtyS
         oqm1sORDL8YWR5Fg5hOx8FqovhByWqJXje6H2CyQIU75MqI+5bX1gHPM7ecxzq8zAgPg
         j6LvKCLvHRAMWYa6y7LBs8suW6QmEsfp92n/sIQmQTPj0GzYdB+RqjbHWggVUu0yESRX
         Tisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307553; x=1779912353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/Hc+sN7WhPfu52dJbGtJeYyfKuX8McU4Nd7LhLCxvM=;
        b=GSCryqTsNLLswTfOgCM0cIvfryTOaNqNUK65y1AvyMnChXoaFU1MIOAba8gI3qpamm
         JpWd33T1fENwZbDKEaZC/he81bw82JkyHXkwpqLp1nwB/+GggfmJkKIgc+mJgaeyTlcy
         J7jujFvto03Z2uCCJwYawwzlAySfMbMgx1lEjz3uU2WyvI4eUiNtuuFtErkJfLtHC9/c
         cLDe4m7WmJZiyzTg7RUL0CD99CyyGtapteHYKZeZJOe9MRAE+T037QPe+0+zXMQCQkto
         sL5IDQfhH2ycHWCQSaNNw7K3A5UAGV4rz87N3wBO1sx2TwXd7pZhcr1uhIq41BzWCZUQ
         SOSg==
X-Gm-Message-State: AOJu0Yxjh5nnmueKRUFGGjZrx4uSSRFFQCksGTjtcdqQXaDJTGu6tO7F
	03hbRMYo5OisrenD2QRqXEw8aAay0bUHshJozxKkSN0ZzTMPpjoOaY+eC/Sv1aucDAI0Rx+niA2
	6b3VX+g0bsWKdeaKQjJoTGyq8b/E8J7Z4ouxy
X-Gm-Gg: Acq92OFD48wc3ZeHb9PMs23zL2bFtLVXeE5Ey4CPvJ4ZjORppbgk9sFc16Qo7OD9USt
	axFXDvuUGoqgV5A0h6T72sVn9wGmUytol9wreqti8ZvuipmbNXYAimLQa9DVWWiR3ZbFFfVD5rs
	TtCyLOsuOUDeN6WEbkhCAfgel0D3CkhZFaBiqpJoCaRhtSJHYOygPoMVsjkTy2I3JexymZvPpj8
	izRyxSCjKgxdCuF/xMQUsNnax9nQo4jmIfjL9yh67TCn+VK/L4HD5deFRkDeeryqOmUvmwN1jeR
	yRcD
X-Received: by 2002:ac2:5bc1:0:b0:5a8:6cd7:3203 with SMTP id
 2adb3069b0e04-5aa2ae2452cmr228649e87.3.1779307553423; Wed, 20 May 2026
 13:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515144548.13795-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260515144548.13795-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 May 2026 16:05:42 -0400
X-Gm-Features: AVHnY4I_9NByPYuZjTgCdxrS9XGR6TDgpBJ-f1ttFVt1RPmZeYQkFfXN3vsVOVk
Message-ID: <CAP+JOzQsYmrevuw6fKu7LE_Pi0JH1X15wqTqd0zuvv8vJ1s7OA@mail.gmail.com>
Subject: Re: [PATCH] gui: do not load from cwd and properly quote inputs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 10:45=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> gui can be called via pkexec and therefore should never trust
> its cwd. The initial arguments and file names can be
> user-supplied so ensure they are properly quoted.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  gui/modulesPage.py           | 5 ++++-
>  gui/polgengui.py             | 6 +-----
>  gui/sepolgen                 | 2 +-
>  gui/system-config-selinux.py | 5 +----
>  4 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/gui/modulesPage.py b/gui/modulesPage.py
> index 02b79f15..7ae5a80a 100644
> --- a/gui/modulesPage.py
> +++ b/gui/modulesPage.py
> @@ -194,7 +194,10 @@ class modulesPage(semanagePage):
>      def add(self, file):
>          try:
>              self.wait()
> -            status, output =3D getstatusoutput("semodule -i %s" % file)
> +            p =3D Popen(["semodule", "-i", file], stdout=3DPIPE, stderr=
=3DPIPE,
> +                      universal_newlines=3DTrue)
> +            out, err =3D p.communicate()
> +            status, output =3D p.returncode, (out or "") + (err or "")
>              self.ready()
>              if status !=3D 0:
>                  self.error(output)
> diff --git a/gui/polgengui.py b/gui/polgengui.py
> index 9c151a11..76751e02 100644
> --- a/gui/polgengui.py
> +++ b/gui/polgengui.py
> @@ -85,7 +85,6 @@ except:
>  version =3D "1.0"
>
>  sys.path.append('/usr/share/system-config-selinux')
> -sys.path.append('.')
>
>  # From John Hunter http://www.daa.com.au/pipermail/pygtk/2003-February/0=
04454.html
>
> @@ -98,10 +97,7 @@ def foreach(model, path, iter, selected):
>  ##
>  xml =3D Gtk.Builder()
>  xml.set_translation_domain(PROGNAME)
> -if os.access("polgen.ui", os.F_OK):
> -    xml.add_from_file("polgen.ui")
> -else:
> -    xml.add_from_file("/usr/share/system-config-selinux/polgen.ui")
> +xml.add_from_file("/usr/share/system-config-selinux/polgen.ui")
>
>  FILE =3D 1
>  DIR =3D 2
> diff --git a/gui/sepolgen b/gui/sepolgen
> index 2f0c1cc7..f99fd01c 100644
> --- a/gui/sepolgen
> +++ b/gui/sepolgen
> @@ -1,2 +1,2 @@
>  #!/bin/sh
> -sepolicy generate $*
> +exec sepolicy generate "$@"
> diff --git a/gui/system-config-selinux.py b/gui/system-config-selinux.py
> index 0b6ba4b5..694a791c 100644
> --- a/gui/system-config-selinux.py
> +++ b/gui/system-config-selinux.py
> @@ -74,10 +74,7 @@ version =3D "1.0"
>  ##
>  xml =3D Gtk.Builder()
>  xml.set_translation_domain(PROGNAME)
> -if os.access("system-config-selinux.ui", os.F_OK):
> -    xml.add_from_file("system-config-selinux.ui")
> -else:
> -    xml.add_from_file("/usr/share/system-config-selinux/system-config-se=
linux.ui")
> +xml.add_from_file("/usr/share/system-config-selinux/system-config-selinu=
x.ui")
>
>
>  class childWindow:
> --
> 2.54.0
>
