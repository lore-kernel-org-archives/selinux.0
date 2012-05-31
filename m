Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4VKxcnt011096
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2012 16:59:39 -0400
Received: by qcsk26 with SMTP id k26so815973qcs.12
        for <selinux@tycho.nsa.gov>; Thu, 31 May 2012 13:59:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120526164404.GA16921@siphos.be>
References: <20120516091736.GA10721@siphos.be>
	<20120523203519.GA13394@siphos.be>
	<20120526164404.GA16921@siphos.be>
Date: Thu, 31 May 2012 16:59:37 -0400
Message-ID: <CACLa4ps4q2om-3A6KY4RJPE7+=gKrpJQMMJxSA6_BnagTz9tgg@mail.gmail.com>
Subject: Re: Trying to support Python 3 but fails on libsemanage
From: Eric Paris <eparis@parisplace.org>
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, May 26, 2012 at 12:44 PM, Sven Vermeulen
<sven.vermeulen@siphos.be> wrote:
> On Wed, May 23, 2012 at 10:35:19PM +0200, Sven Vermeulen wrote:
> diff -ur libsemanage-2.1.6.orig/src/fcontext_record.c libsemanage-2.1.6/src/fcontext_record.c
> --- libsemanage-2.1.6.orig/src/fcontext_record.c        2012-05-22 21:50:23.416071391 +0200
> +++ libsemanage-2.1.6/src/fcontext_record.c     2012-05-26 09:08:22.125114161 +0200
> @@ -45,7 +45,11 @@
>                    "create file context key");
>                return STATUS_ERR;
>        }
> -       tmp_key->expr = expr;
> +       tmp_key->expr = strdup(expr);
> +       if (!tmp_key->expr) {
> +               ERR(handle, "out of memory, could not create file context key.");
> +               return STATUS_ERR;
> +       }
>        tmp_key->type = type;
>
>        *key_ptr = tmp_key;
> @@ -74,6 +79,7 @@
>
>  void semanage_fcontext_key_free(semanage_fcontext_key_t * key)
>  {
> +       free(key->expr);
>        free(key);
>  }

key->expr is a const char * so free() is not 'allowed'.  I changed it
to just a char * (which is what strdup returns) so the code could
build.  Thanks!

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
