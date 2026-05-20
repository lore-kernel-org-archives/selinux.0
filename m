Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ADB32938D
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307380; cv=pass; b=RQPEKxdLNRFasNTtgs27HIjOgsntmjpijles0V9fcP4pX4ymCWEOxPtQEvPRs01GLbMjMzsu/ZBOZikhAyZxDhZFmWHxjBv3lk8IB5iKRw6cHh864k8q3ErTD6JyuGNQXYTdyReOmAWo+CwpfD9ekd15iQbykygyGNGccSXURxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307380; c=relaxed/simple;
	bh=M8W57GM0JsyeJ1wv+p8iTGSLOEGTQvHXImt18sf5tFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBQbJd6agu3uTuB02AqeH9XebtyyqxI00CMOzttQ/NBUuxSSBCIUJzkI/h7xDgkQIjdEMXTNL+/1hbOshFwmeZIZS1IoWQZq3WGYAey3yAGQ6zRshR+QAvWgJyHKqXPyholrGcimTL6PSKdT4syoktpaV6Cdk4n9zCehIHccbxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er7WII08; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er7WII08"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-394095009beso47163471fa.3
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 13:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779307377; cv=none;
        d=google.com; s=arc-20240605;
        b=HOHu+yaGdb/mJxymEhAwmbYfC91+7UM30v0LV/PjIzyuiniY1BSrz1ajEjE2Aq3SVq
         Vpchja12rzkc1QrQTZeYu4s0R2jTJQUQ1MVRYncQw0u8AIuh48wqcr1wx3xGlAf2xvvH
         lE1Zz3dS6vR55N96oneA4bPNU1ZT+OS5btdG31cyQ7Eqbb4b2UZHZ8C0d94hZPUcKr8j
         s/q4KduMZe0t5SnwHacgrsI5kA3kyIybDQBRcGOxsYwgEhOLrIJWCFqMy3aFU6zObgXS
         IICnUBugaGdkGw0fSaeCSvlWJCfbRCSsLyPzSLXbyQDzyje2PWQYEEyVTFbaRJv39Ew4
         Y9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=948yzfSK/4Gv9pF12L8Jq7KXkxhyBp7hyAwwZk9Nv30=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=Gl0dGs4S4DeWfq6GB+HPGbH0a0avNIC+nhCwXSR0DKZ2FC88SKcZ3C3yip0WI0bkVE
         12lac7NBhil79N6Sb+Y6+6KrtJMRysBldzny3b8TZYieEDZoZqGYMbBfGJ1KIr9AasH0
         rBzo8OkO5e0w//EIEhdkrt9xUDAROH1eeagJeKz7EXMbmMkSyNepbzYPTB9T7uhOy92B
         UoRXyxrdhW797rUcVAXIFyHMDGLY7JMZZa7JxEM3TwfJ8qVNDsfXExPtNIeJA0mROlg9
         BNVHwAzAnzeNHOrXjBhktAGcA6tdUNoyaZdekkUlIIzvomb/N87kBwX1wPZD7lX0e/Zh
         hQKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779307377; x=1779912177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=948yzfSK/4Gv9pF12L8Jq7KXkxhyBp7hyAwwZk9Nv30=;
        b=er7WII08yu8X86P8Py//qKl+p5gp0/lIP6AQbEyOnnpfF6SNQFTulFJLf2qCHvIjEB
         Nfzd3mQ6ec0wSSlUIeTWBUJZV27tgxKiMjgQSLipPguONTB3pq52MOTmrBjxMJvoYKS6
         yd7mchQ66XqVt5LrGrViln72DRQRxlZZooplmMa7hHK5OraJX9v6SJA+e5tAbYFIJIgb
         gwPjHSUI6mpxyyTP4k/KbIasi7maOJhFTN3fCnlhJYQQOze1O3/15kKvcFjaiVsk54Sz
         +vGZbCGP26Qg1uYDDJ/fbTQK8OvdCTtjj6ZN4DCc2Ey1xFIz5cNCjQ0px+BQZHZ+2MYI
         svbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307377; x=1779912177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=948yzfSK/4Gv9pF12L8Jq7KXkxhyBp7hyAwwZk9Nv30=;
        b=jzVcTRPdhbN3zab1E7laKgpdJIQlBVNOoGL7XtWb/C9eKNf0SmrLLPj4NtHVp1fDE+
         L9ulzsO8+t7U0V2+5SmxtnEPv+/4XhuYT4n+wT2j8g0yv8VCeKH9nkcUTw0rz+XkCpcG
         AjihJSX+XgD80Lp2KipheyaQcQ2KBU4zzTQX+yoa3aGWWHZwvJtqPiPF9YFuMIkxNoio
         AGBKlQVnJXrZ9b2yNB0GfDOKRvG6SumFOEjbVo6aQSegkCYNo0h/NDbrJt0Uz6015VjV
         unirPZiQ3hRWlK9Oqx9r8R+90xnAMGbWCFKiLjm4rzAf9sCH709m/AAmPtwojEagybWx
         z5jA==
X-Gm-Message-State: AOJu0YxzAOIBFZkA/hKJaNatTDwBQwlWmkYyuPeL+q9/vj0A27nye3fj
	Ns0qp+YNh8jc1qNhiZMd3h6AzFX9jLMrWQdffED9ju+Gg+MTk1wuZeq2vuqSTkaA6UR6Y7K0h+O
	7d3zgJMRwxwQ7mfv4KP8Qh+o9fVnPVIQ=
X-Gm-Gg: Acq92OE6NxALd07C7kzFcEOGYJxIbHBEp26i1j69GSJsFysLFvo0+x4CuaR6gFETMjw
	E+ogNtHFKPLaJAz/Qrdxk61U8TDAM28UzGEelghANFo9in5/MQom3ktzR+lEMwcp6lAPTUm5MfO
	lNeDhFn9QF9CEJ1pMlcf95W21yUiofgZvHpcGzBkVuKSKTRGrG4R8UCrF/go5biR8s9x+Pijx9r
	1eAz/KWrqFuy7BQf4Xkaq19hVbsUYesnHwoE6vVbpB6OsuVPLteNMAOb5VZ/y6QFE5wdSR4E2NB
	b5cM
X-Received: by 2002:a05:651c:325b:b0:394:987:9450 with SMTP id
 38308e7fff4ca-39561daad40mr76843701fa.31.1779307376584; Wed, 20 May 2026
 13:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515143410.13166-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260515143410.13166-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 May 2026 16:02:45 -0400
X-Gm-Features: AVHnY4K_ROE6hI6QvkhUeYsnQTZdKuRjLZw4ctBOlruNGZP5mOUo4TY0Iiolmkg
Message-ID: <CAP+JOzSX9P3w-Lr4c=P8HkRWihoaMBQ5UboT9Z1FXeO23B-41A@mail.gmail.com>
Subject: Re: [PATCH] dbus/selinux_server.py: validate policy config value
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 10:34=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Perform basic validation of the policy config value; we could
> further limit it to only existing subdirectories of /etc/selinux.
> Also, fix up usage of p.communicate() to avoid potential pipe
> deadlock issues and distinguish error messages.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  dbus/selinux_server.py | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
> index 469c526f..3da2ef30 100644
> --- a/dbus/selinux_server.py
> +++ b/dbus/selinux_server.py
> @@ -6,6 +6,7 @@ from dbus.mainloop.glib import DBusGMainLoop
>  from gi.repository import GObject
>  from gi.repository import GLib
>  import os
> +import re
>  import selinux
>  from subprocess import Popen, PIPE, STDOUT
>
> @@ -33,8 +34,7 @@ class selinux_server(dbus.service.Object):
>          if not self.is_authorized(sender, "org.selinux.semanage"):
>              raise dbus.exceptions.DBusException("Not authorized")
>          p =3D Popen(["/usr/sbin/semanage", "import"], stdout=3DPIPE, std=
err=3DPIPE, stdin=3DPIPE, universal_newlines=3DTrue)
> -        p.stdin.write(buf)
> -        output =3D p.communicate()
> +        output =3D p.communicate(input=3Dbuf)
>          if p.returncode and p.returncode !=3D 0:
>              raise dbus.exceptions.DBusException(output[1])
>
> @@ -48,10 +48,9 @@ class selinux_server(dbus.service.Object):
>          if not self.is_authorized(sender, "org.selinux.customized"):
>              raise dbus.exceptions.DBusException("Not authorized")
>          p =3D Popen(["/usr/sbin/semanage", "export"], stdout=3DPIPE, std=
err=3DPIPE, universal_newlines=3DTrue)
> -        buf =3D p.stdout.read()
> -        output =3D p.communicate()
> +        buf, err =3D p.communicate()
>          if p.returncode and p.returncode !=3D 0:
> -            raise OSError("Failed to read SELinux configuration: %s", ou=
tput)
> +            raise OSError("Failed to read SELinux configuration: %s" % e=
rr)
>          return buf
>
>      #
> @@ -63,10 +62,9 @@ class selinux_server(dbus.service.Object):
>          if not self.is_authorized(sender, "org.selinux.semodule_list"):
>              raise dbus.exceptions.DBusException("Not authorized")
>          p =3D Popen(["/usr/sbin/semodule", "--list=3Dfull"], stdout=3DPI=
PE, stderr=3DPIPE, universal_newlines=3DTrue)
> -        buf =3D p.stdout.read()
> -        output =3D p.communicate()
> +        buf, err =3D p.communicate()
>          if p.returncode and p.returncode !=3D 0:
> -            raise OSError("Failed to list SELinux modules: %s", output)
> +            raise OSError("Failed to list SELinux modules: %s" % err)
>          return buf
>
>      #
> @@ -140,6 +138,8 @@ class selinux_server(dbus.service.Object):
>      def change_default_policy(self, value, sender):
>          if not self.is_authorized(sender, "org.selinux.change_default_po=
licy"):
>              raise dbus.exceptions.DBusException("Not authorized")
> +        if not re.fullmatch(r'[A-Za-z0-9_.]+', str(value)):
> +            raise ValueError("Invalid policy name: %s" % value)
>          path =3D selinux.selinux_path() + value
>          if os.path.isdir(path):
>              return self.write_selinux_config(policy=3Dvalue)
> --
> 2.54.0
>
