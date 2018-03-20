Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2KKS39i001495
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 16:28:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 405PdC6Y6sz2VqB4
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 20:27:59 +0000 (UTC)
Received: from UPDC3CPA04.eemsg.mil (unknown [192.168.18.11])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 405PdC5SQ2z2VqB9
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 20:27:59 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id o102-v6so4585528lfg.8
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 13:27:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180319173336.24730-1-richard_c_haines@btinternet.com>
References: <20180319173336.24730-1-richard_c_haines@btinternet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Mar 2018 16:27:51 -0400
Message-ID: <CAHC9VhTLEgtw2KfWOgeoZ-bYQLWO2cDUKnd9Td8UKB_e14k0Sg@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: Update SELinux SCTP documentation
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Mar 19, 2018 at 1:33 PM, Richard Haines via Selinux
<selinux@tycho.nsa.gov> wrote:
> Update SELinux-sctp.rst "SCTP Peer Labeling" section to reflect
> how the association permission is validated.
>
> Reported-by: Dominick Grift <dac.override@gmail.com>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  Documentation/security/SELinux-sctp.rst | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Merged, thanks Richard and Dominick.

> diff --git a/Documentation/security/SELinux-sctp.rst b/Documentation/security/SELinux-sctp.rst
> index 2f66bf3..a332cb1 100644
> --- a/Documentation/security/SELinux-sctp.rst
> +++ b/Documentation/security/SELinux-sctp.rst
> @@ -116,11 +116,12 @@ statement as shown in the following example::
>  SCTP Peer Labeling
>  ===================
>  An SCTP socket will only have one peer label assigned to it. This will be
> -assigned during the establishment of the first association. Once the peer
> -label has been assigned, any new associations will have the ``association``
> -permission validated by checking the socket peer sid against the received
> -packets peer sid to determine whether the association should be allowed or
> -denied.
> +assigned during the establishment of the first association. Any further
> +associations on this socket will have their packet peer label compared to
> +the sockets peer label, and only if they are different will the
> +``association`` permission be validated. This is validated by checking the
> +socket peer sid against the received packets peer sid to determine whether
> +the association should be allowed or denied.
>
>  NOTES:
>     1) If peer labeling is not enabled, then the peer context will always be
> --
> 2.14.3

-- 
paul moore
www.paul-moore.com
