Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4UKcPIW014599
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 16:38:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC03.oob.disa.mil (Postfix) with SMTP id 40x2V76t7dzJmsJ
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 20:38:07 +0000 (UTC)
Received: from UPDC3CPA12_EEMSG_MP28.eemsg.mil (unknown [192.168.18.23])
 by UPDCF3IC03.oob.disa.mil (Postfix) with ESMTP id 40x2V66Zs1zJms8
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 20:38:06 +0000 (UTC)
Received: from mail-ot0-f181.google.com (mail-ot0-f181.google.com
 [74.125.82.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 4040A5649AD
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 22:38:05 +0200 (CEST)
Received: by mail-ot0-f181.google.com with SMTP id q17-v6so12160744otg.2
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 13:38:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180528214633.19374-2-bigon@debian.org>
References: <20180528214633.19374-1-bigon@debian.org>
 <20180528214633.19374-2-bigon@debian.org>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 30 May 2018 22:38:03 +0200
Message-ID: <CAJfZ7==_iUgUXeLQcNM2HMW=2QFA85wXWDHGBAnpeqQG=FLW7w@mail.gmail.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/3] libselinux: Fix line wrapping in
 selabel_file.5
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, May 28, 2018 at 11:46 PM, Laurent Bigonville <bigon@debian.org> wrote:
> From: Laurent Bigonville <bigon@bigon.be>
>
> Fix line wrapping with limited to 80 columns
>
> Fix lintian error:
> W: selinux-utils: manpage-has-errors-from-man usr/share/man/man5/selabel_file.5.gz 104: warning [p 2, 10.0i]: cannot adjust line
>
> Signed-off-by: Laurent Bigonville <bigon@bigon.be>
> ---
>  libselinux/man/man5/selabel_file.5 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/man/man5/selabel_file.5 b/libselinux/man/man5/selabel_file.5
> index e7388242..e97bd826 100644
> --- a/libselinux/man/man5/selabel_file.5
> +++ b/libselinux/man/man5/selabel_file.5
> @@ -92,7 +92,7 @@ The optional local and distribution substitution files that perform any path ali
>  .RE
>  .sp
>  The default file context series of files are:
> -.RS
> +.RS 6
>  .I /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts
>  .br
>  .I  /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts.local
> --
> 2.17.0

All the manpage patches look good to me (and I give them an ack).

For information, I didn't know what the default indent value of ".RS"
[1] is and it seems to be 8. I tested running "man ./selabel_file.5"
in a 80-char-wide terminal and the line
"/etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts.subs_dist" is
no longer cut after this patch.

Thanks,
Nicolas

[1] For those who are unfamiliar with manpage code, this instruction
increases the indent by moving the left margin to the right.
