Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m15MCito019920
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 17:12:44 -0500
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m15MCgZ4021444
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 22:12:42 GMT
Received: by wa-out-1112.google.com with SMTP id k22so3177934waf.0
        for <selinux@tycho.nsa.gov>; Tue, 05 Feb 2008 14:12:41 -0800 (PST)
Message-ID: <cadfc0e40802051412p393dd42ei3632bee0b9842b73@mail.gmail.com>
Date: Tue, 5 Feb 2008 16:12:41 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: add "poly_property" type to X contexts backend
Cc: "SELinux List" <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
In-Reply-To: <47A8D586.7080202@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47A8D586.7080202@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm curious as to why you chose the route of specifying which
properties are polyinstantiated instead of which are not bearing in
mind what Glenn said in a previous post?

On Feb 5, 2008 3:30 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> This patch adds a poly_property type to the X contexts backend, so that
> the X Flask module can be informed which properties to polyinstantiate.
>
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
>
>  include/selinux/label.h |    1 +
>  src/label_x.c           |    2 ++
>  2 files changed, 3 insertions(+)
>
>
> Index: libselinux/include/selinux/label.h
> ===================================================================
> --- libselinux/include/selinux/label.h  (revision 2789)
> +++ libselinux/include/selinux/label.h  (working copy)
> @@ -113,6 +113,7 @@
>  #define SELABEL_X_CLIENT       3
>  #define SELABEL_X_EVENT                4
>  #define SELABEL_X_SELN         5
> +#define SELABEL_X_POLYPROP     6
>
>
>  #ifdef __cplusplus
> Index: libselinux/src/label_x.c
> ===================================================================
> --- libselinux/src/label_x.c    (revision 2789)
> +++ libselinux/src/label_x.c    (working copy)
> @@ -69,6 +69,8 @@
>                         data->spec_arr[data->nspec].type = SELABEL_X_EVENT;
>                 else if (!strcmp(type, "selection"))
>                         data->spec_arr[data->nspec].type = SELABEL_X_SELN;
> +               else if (!strcmp(type, "poly_property"))
> +                       data->spec_arr[data->nspec].type = SELABEL_X_POLYPROP;
>                 else {
>                         selinux_log(SELINUX_WARNING,
>                                     "%s:  line %d has invalid object type %s\n",
>
> --
> Eamon Walsh <ewalsh@tycho.nsa.gov>
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
