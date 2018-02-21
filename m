Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1LMN2PA031027
 for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2018 17:23:02 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 3zmsSN2VqPz4BPFZ
 for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2018 22:23:00 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 3zmsSN175pz4BPFX
 for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2018 22:23:00 +0000 (UTC)
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com
 [209.85.215.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 7A405560697
 for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2018 23:13:43 +0100 (CET)
Received: by mail-lf0-f47.google.com with SMTP id 37so4570511lfs.7
 for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2018 14:13:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215173437.14632-1-dac.override@gmail.com>
References: <20180215173437.14632-1-dac.override@gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 21 Feb 2018 23:13:42 +0100
Message-ID: <CAJfZ7=nKU1C5Ng+awF9bL74VYG1LTxwZ35gPCAWhQ6Wtod-jKA@mail.gmail.com>
To: Dominick Grift <dac.override@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] Describe multiple-decls in secilc.8.xml
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Feb 15, 2018 at 6:34 PM, Dominick Grift <dac.override@gmail.com> wrote:
> Signed-off-by: Dominick Grift <dac.override@gmail.com>
> ---
>  secilc/secilc.8.xml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/secilc/secilc.8.xml b/secilc/secilc.8.xml
> index 4c779b64..e08a9624 100644
> --- a/secilc/secilc.8.xml
> +++ b/secilc/secilc.8.xml
> @@ -75,6 +75,11 @@
>              <listitem><para>Treat tunables as booleans.</para></listitem>
>           </varlistentry>
>
> +         <varlistentry>
> +            <term><option>-m, --multiple-decls</option></term>
> +            <listitem><para>Allow some statements to be re-declared.</para></listitem>
> +         </varlistentry>
> +
>           <varlistentry>
>              <term><option>-N, --disable-neverallow</option></term>
>              <listitem><para>Do not check <emphasis role="bold">neverallow</emphasis> rules.</para></listitem>
> --
> 2.16.1

Hi,
As this patch looks good to me, I have merged it.
Thanks!
Nicolas
