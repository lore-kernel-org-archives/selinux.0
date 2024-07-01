Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17D14B947
	for <selinux@vger.kernel.org>; Mon,  1 Jul 2024 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854344; cv=none; b=QQjSVvhBZb2pm9dGe4H5HYC9jPCxicFE+DUN0+qOKHxKp83Gjdz8Wy7a72oYeNwVZghZPVHzdrlJ/3Y46PkSGLI7tIzFA9fa/rpHLCIFclVfgAArQ92DwF4684yJgdkNW+X9/l5kt7/mcJ4fQYTg4nUXBZnCqJAOBXwAKqQqxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854344; c=relaxed/simple;
	bh=vYH337oh5Ja4sJ66CBMB4rmmaqTJTwE7/DPy9ywLQBM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KEAHY3tgDAed+WdfvW3wD2ecYgUk4smcLfuhADkM/UIH6XKiPXTBbLpfwYMJBWBomjaNePZJztpea0FP/Kg1joUnQxgbcn+4MWmbFnhfdi/h5hgtLZ7WxHKArpq0ZaCh27650NH9CJpGaO7b1Df9BMlYSL5t/Bzj7pd4cvHidpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intellipay.com; spf=pass smtp.mailfrom=intellipay.com; dkim=pass (2048-bit key) header.d=intellipay-com.20230601.gappssmtp.com header.i=@intellipay-com.20230601.gappssmtp.com header.b=fP8+soUM; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intellipay.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intellipay.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intellipay-com.20230601.gappssmtp.com header.i=@intellipay-com.20230601.gappssmtp.com header.b="fP8+soUM"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaea28868dso46346301fa.3
        for <selinux@vger.kernel.org>; Mon, 01 Jul 2024 10:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intellipay-com.20230601.gappssmtp.com; s=20230601; t=1719854339; x=1720459139; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gpv1pLYI2DjtEFy23jnYK926DeN1I0IOXpi8FuvzjHc=;
        b=fP8+soUMXXHFcp+OQQN99MCu30DkjQj6P8D6iN85gH5b2QM332avkDnAIuc0do4Zno
         KwguDt2t3GuxAQOxCYQDs5cCjo3MQv69CqZCgiKb3YnFwHx0mZM9U1ClN8jYAsNooU5a
         K+regbop+XNJk+YnGQ3E1IFz4sCNLgQ/yUKzJzS+Ki3sTpcqw8uOQR/hoFYmvBbuGA3O
         gQxfsos/a424jc8eSXS1a2MXuT28JzDZtI+tYpYr+aGeV33tITRkIa83wyYl1A6TlttS
         D4V4YFCBrh+HVAfkI4+BnQ1T+2Edd/lOe/1aZmM5DUk85fChEPtQDbmtdyiJWhOvPX4U
         xwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719854339; x=1720459139;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gpv1pLYI2DjtEFy23jnYK926DeN1I0IOXpi8FuvzjHc=;
        b=aduRvQAp3Ee1om1EAfVxGWo1AEIPRzLMPl0+iKoXp74P40labUnoDEnzwwHDAKGLqe
         vs9m6/Kh0VWIZebelQUQUZQXFtWAKbnk5mgpf1aFnVXDIjMFAaEg7HskIasDAVsqsiXz
         7DAkhwOT9pDqBqJMcQlcEys+ecuVC71WXB61IvkayKNCpkxguc7g/XXpqN3UO03Fzy2Z
         185WoHv5Qeuu+/oXQyt5PLCIrL/vxvHFY0tC4Ga+LoaIe72hiZ+0fOQodPDKKEwd3Eme
         AL9grCuzlYKlaumdrJ4Rb0mMoJIANIY9j2hmq9fNEIzaLTMsJKcdAvGoi7LcTf2zoui7
         2Gpw==
X-Gm-Message-State: AOJu0Yzx7Cak1ltJtPNCankG+iIUP96/b+BF6SCa2dmSrTfqH5YJFoxW
	sOTL1daZP9/laa0V5VNEoKt+T7EyLLqGE0UX9PzyuNsj99AjV1F3Gwe39gUjNjFkEO0PB0dAxxX
	QkB5KO2+Vf9BjCP0FZQ7raMCXAyf9HGUH2ERJfbrSTMMqGOuIRAoypg==
X-Google-Smtp-Source: AGHT+IFbL9dNy+TiySFOv1VYSrF2fJ9XbmN65yYc7/DmLcsrOtoy3/Y8lDNL1Cw9qETit9Fq16NO2AuzO9z56qTn8pc=
X-Received: by 2002:a2e:90d3:0:b0:2ec:5645:7deb with SMTP id
 38308e7fff4ca-2ee5e380020mr53538091fa.5.1719854339158; Mon, 01 Jul 2024
 10:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Allan Oepping <allan@intellipay.com>
Date: Mon, 1 Jul 2024 11:18:47 -0600
Message-ID: <CAEeCnGzRMiiDZKaDgnX_dqpeK5rM=aO5zBZ6frWJT4WQj5cVEQ@mail.gmail.com>
Subject: UnicodeDecodeError: utf-8 on python semanage -i import
To: selinux@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f44b72061c32caa3"

--000000000000f44b72061c32caa3
Content-Type: multipart/alternative; boundary="000000000000f44b71061c32caa1"

--000000000000f44b71061c32caa1
Content-Type: text/plain; charset="UTF-8"

Importing a .pp file with the python semanage -i option generates a
"UnicodeDecodeError: utf-8" on an up to date Rocky 9 distribution.

packages:

policycoreutils-python-utils-3.6-2.1.el9.noarch
python-unversioned-command-3.9.18-3.el9.noarch

The open() in SetImportFile needs the binary "b" option to open the file in
binary mode, as the .pp file is not in utf-8 format:

--- /semanage~ 2024-07-01 10:29:20.000000000 -0600
+++ /semanage 2024-07-01 10:54:30.520312298 -0600
@@ -122,11 +122,11 @@
 class SetImportFile(argparse.Action):

     def __call__(self, parser, namespace, values, option_string=None):
         if values and values != "-":
             try:
-                sys.stdin = open(values, 'r')
+                sys.stdin = open(values, 'rb')
             except IOError as e:
                 sys.stderr.write("%s: %s\n" % (e.__class__.__name__,
str(e)))
                 sys.exit(1)
         setattr(namespace, self.dest, values)

patch also attached.

Thanks,

Allan Oepping

--000000000000f44b71061c32caa1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Importing a .pp file with the python semanage -i option ge=
nerates a &quot;UnicodeDecodeError: utf-8&quot; on an up to date Rocky 9 di=
stribution.<div><br></div><div>packages:<br><br>policycoreutils-python-util=
s-3.6-2.1.el9.noarch<br>python-unversioned-command-3.9.18-3.el9.noarch<br><=
/div><div><br></div><div>The open() in SetImportFile needs the binary &quot=
;b&quot; option to open the file in binary mode, as the .pp file is not in =
utf-8 format:</div><div><br></div><div>--- /semanage~	2024-07-01 10:29:20.0=
00000000 -0600<br>+++ /semanage	2024-07-01 10:54:30.520312298 -0600<br>@@ -=
122,11 +122,11 @@<br>=C2=A0class SetImportFile(argparse.Action):<br>=C2=A0<=
br>=C2=A0 =C2=A0 =C2=A0def __call__(self, parser, namespace, values, option=
_string=3DNone):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if values and values =
!=3D &quot;-&quot;:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:=
<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.stdin =3D =
open(values, &#39;r&#39;)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0sys.stdin =3D open(values, &#39;rb&#39;)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except IOError as e:<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.stderr.write(&quot;%s: %s\n&q=
uot; % (e.__class__.__name__, str(e)))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0setattr(namespace, self.dest, values)<br></div><div><br></div><div>pa=
tch also attached.</div><div><br></div><div>Thanks,</div><div><br></div><di=
v>Allan Oepping</div></div>

--000000000000f44b71061c32caa1--
--000000000000f44b72061c32caa3
Content-Type: text/x-patch; charset="US-ASCII"; name="selinux.patch"
Content-Disposition: attachment; filename="selinux.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ly38shts0>
X-Attachment-Id: f_ly38shts0

LS0tIC9zZW1hbmFnZX4JMjAyNC0wNy0wMSAxMDoyOToyMC4wMDAwMDAwMDAgLTA2MDAKKysrIC9z
ZW1hbmFnZQkyMDI0LTA3LTAxIDEwOjU0OjMwLjUyMDMxMjI5OCAtMDYwMApAQCAtMTIyLDExICsx
MjIsMTEgQEAKIGNsYXNzIFNldEltcG9ydEZpbGUoYXJncGFyc2UuQWN0aW9uKToKIAogICAgIGRl
ZiBfX2NhbGxfXyhzZWxmLCBwYXJzZXIsIG5hbWVzcGFjZSwgdmFsdWVzLCBvcHRpb25fc3RyaW5n
PU5vbmUpOgogICAgICAgICBpZiB2YWx1ZXMgYW5kIHZhbHVlcyAhPSAiLSI6CiAgICAgICAgICAg
ICB0cnk6Ci0gICAgICAgICAgICAgICAgc3lzLnN0ZGluID0gb3Blbih2YWx1ZXMsICdyJykKKyAg
ICAgICAgICAgICAgICBzeXMuc3RkaW4gPSBvcGVuKHZhbHVlcywgJ3JiJykKICAgICAgICAgICAg
IGV4Y2VwdCBJT0Vycm9yIGFzIGU6CiAgICAgICAgICAgICAgICAgc3lzLnN0ZGVyci53cml0ZSgi
JXM6ICVzXG4iICUgKGUuX19jbGFzc19fLl9fbmFtZV9fLCBzdHIoZSkpKQogICAgICAgICAgICAg
ICAgIHN5cy5leGl0KDEpCiAgICAgICAgIHNldGF0dHIobmFtZXNwYWNlLCBzZWxmLmRlc3QsIHZh
bHVlcykKIAo=
--000000000000f44b72061c32caa3--
