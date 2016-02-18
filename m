Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1IA8CEb001630
 for <selinux@tycho.nsa.gov>; Thu, 18 Feb 2016 05:08:15 -0500
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
 [209.85.217.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 1C48B5648D7
 for <selinux@tycho.nsa.gov>; Thu, 18 Feb 2016 11:08:10 +0100 (CET)
Received: by mail-lb0-f180.google.com with SMTP id x4so25606810lbm.0
 for <selinux@tycho.nsa.gov>; Thu, 18 Feb 2016 02:08:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56C480FF.4070306@tycho.nsa.gov>
References: <1452874283-6166-1-git-send-email-richard_c_haines@btinternet.com>
 <56C480FF.4070306@tycho.nsa.gov>
Date: Thu, 18 Feb 2016 11:08:09 +0100
Message-ID: <CAJfZ7=mHdpidBhau1WjnvRFqK+Ln0iJo9GkD5pxq4oxP81E=zg@mail.gmail.com>
Subject: Re: RESEND [PATCH V3] libselinux: Add selinux_restorecon function
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux <selinux@tycho.nsa.gov>,
 Richard Haines <richard_c_haines@btinternet.com>
Content-Type: multipart/alternative; boundary=001a11c36e32282633052c088bdb
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c36e32282633052c088bdb
Content-Type: text/plain; charset=UTF-8

On Wed, Feb 17, 2016 at 3:17 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 01/15/2016 11:11 AM, Richard Haines wrote:
>
>> The selinux_restorecon(3) man page details this function.
>>
>
About the man page, it defines "int selinux_restorecon(const char **
pathname, unsigned int restorecon_flags)" but the implementation uses only
one star for pathname. I guess this is a small typo in the man page, as
pathname is considered as a string and not a list of string.

Nicolas

--001a11c36e32282633052c088bdb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Feb 17, 2016 at 3:17 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-le=
ft-style:solid;padding-left:1ex"><span class=3D"">On 01/15/2016 11:11 AM, R=
ichard Haines wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
The selinux_restorecon(3) man page details this function.<br></blockquote><=
/span></blockquote><div><br></div><div>About the man page, it defines &quot=
;int selinux_restorecon(const char ** pathname,=C2=A0unsigned int restoreco=
n_flags)&quot; but the implementation uses only one star for pathname. I gu=
ess this is a small typo in the man page, as pathname is considered as a st=
ring and not a list of string.</div><div><br></div><div>Nicolas</div></div>=
</div></div>

--001a11c36e32282633052c088bdb--
