Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m15HqT5q008097
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 12:52:29 -0500
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m15HqSts017834
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 17:52:29 GMT
Received: by fg-out-1718.google.com with SMTP id 16so2038866fgg.40
        for <selinux@tycho.nsa.gov>; Tue, 05 Feb 2008 09:52:25 -0800 (PST)
Message-ID: <cadfc0e40802050952p519dae9co7ecec84bb67231dd@mail.gmail.com>
Date: Tue, 5 Feb 2008 11:52:25 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: make mls_compute_sid always polyinstantiate
Cc: "SELinux List" <selinux@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
        "James Morris" <jmorris@namei.org>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
In-Reply-To: <4798F57C.8090300@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4798F57C.8090300@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is this in rawhide, if not when will it be?

On Thu, Jan 24, 2008 at 2:30 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> This patch removes the requirement that the new and related object types
>  differ in order to polyinstantiate by MLS level.  This allows MLS
>  polyinstantiation to occur in the absence of explicit type_member rules
>  or when the type has not changed.
>
>  Potential users of this support include pam_namespace.so (directory
>  polyinstantiation) and the SELinux X support (property polyinstantiation).
>
>  Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
>  ---
>
>   mls.c |   11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
>
>
>  diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
>  index fb5d70a..3bbcb53 100644
>  --- a/security/selinux/ss/mls.c
>  +++ b/security/selinux/ss/mls.c
>  @@ -537,15 +537,8 @@ int mls_compute_sid(struct context *scontext,
>                         /* Use the process effective MLS attributes. */
>                         return mls_context_cpy_low(newcontext, scontext);
>         case AVTAB_MEMBER:
>  -               /* Only polyinstantiate the MLS attributes if
>  -                  the type is being polyinstantiated */
>  -               if (newcontext->type != tcontext->type) {
>  -                       /* Use the process effective MLS attributes. */
>  -                       return mls_context_cpy_low(newcontext, scontext);
>  -               } else {
>  -                       /* Use the related object MLS attributes. */
>  -                       return mls_context_cpy(newcontext, tcontext);
>  -               }
>  +               /* Use the process effective MLS attributes. */
>  +               return mls_context_cpy_low(newcontext, scontext);
>         default:
>                 return -EINVAL;
>         }
>
>
>
>  --
>  Eamon Walsh <ewalsh@tycho.nsa.gov>
>  National Security Agency
>
>
>  --
>  This message was distributed to subscribers of the selinux mailing list.
>  If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>  the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
