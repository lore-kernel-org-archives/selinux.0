Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9KFATJA014089
 for <selinux@tycho.nsa.gov>; Fri, 20 Oct 2017 11:10:30 -0400
Received: by mail-qt0-f195.google.com with SMTP id z19so18743580qtg.11
 for <selinux@tycho.nsa.gov>; Fri, 20 Oct 2017 07:54:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019234915.21820-1-jaekyun@google.com>
References: <20171019234915.21820-1-jaekyun@google.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Fri, 20 Oct 2017 07:54:02 -0700
Message-ID: <CABXk95D88yx3PV4XRkKTtr_u3SscQGsEVde=a5miX0KoAag4Ww@mail.gmail.com>
To: Jaekyun Seok <jaekyun@google.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] libselinux: android: support exact match for a
 property key
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Please hold off on submission. We're discussing if this is really necessary.

On Thu, Oct 19, 2017 at 4:49 PM, Jaekyun Seok via Selinux
<selinux@tycho.nsa.gov> wrote:
> Performs exact match if a property key of property contexts ends with '$'
> instead of prefix match.
>
> This will enable to define an exact rule which can avoid unexpected
> context assignment.
>
> Signed-off-by: Jaekyun Seok <jaekyun@google.com>
> ---
>  libselinux/src/label_backends_android.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
> index cb8aae26..4611d396 100644
> --- a/libselinux/src/label_backends_android.c
> +++ b/libselinux/src/label_backends_android.c
> @@ -258,8 +258,13 @@ static struct selabel_lookup_rec *property_lookup(struct selabel_handle *rec,
>         }
>
>         for (i = 0; i < data->nspec; i++) {
> -               if (strncmp(spec_arr[i].property_key, key,
> -                           strlen(spec_arr[i].property_key)) == 0) {
> +               size_t property_key_len = strlen(spec_arr[i].property_key);
> +               if (spec_arr[i].property_key[property_key_len - 1] == '$' &&
> +                   strlen(key) == property_key_len - 1 &&
> +                   strncmp(spec_arr[i].property_key, key, property_key_len - 1) == 0) {
> +                       break;
> +               }
> +               if (strncmp(spec_arr[i].property_key, key, property_key_len) == 0) {
>                         break;
>                 }
>                 if (strncmp(spec_arr[i].property_key, "*", 1) == 0)
> --
> 2.15.0.rc0.271.g36b669edcc-goog
>
>
