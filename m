Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8MKjJJk001205
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 16:45:26 -0400
Received: from mail-ww0-f49.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8MKjP1f011614
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 20:45:26 GMT
Received: by wwp14 with SMTP id 14so2104772wwp.30
        for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 13:45:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1316723205.2259.63.camel@vortex>
References: <1316723205.2259.63.camel@vortex>
Date: Thu, 22 Sep 2011 16:45:25 -0400
Message-ID: <CACLa4pv-+Fj1jiwf=+WrbXNZ2=NUmrejkhV2FAqETQTF1Lv-Xw@mail.gmail.com>
Subject: Re: [PATCH] Indentation error for Python module seobject (fix typo)
From: Eric Paris <eparis@parisplace.org>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It's fixed in a patch on the queue branch titled:

    policycoreutils: semanage: FIXME whitespace changes in seobject

Since I believe that is the only line of that patch which actually
fixes a bug, I'll look at applying your patch to head soon.

-Eric

On Thu, Sep 22, 2011 at 4:26 PM, Guido Trentalancia
<guido@trentalancia.com> wrote:
> Hello.
>
> I get an IndentationError from Python when running code which imports
> seobject.py (line 182).
>
> The following simple patch fixes the problem for current git:
>
> --- selinux-22092011/policycoreutils/semanage/seobject.py       2011-09-17 07:03:41.147162393 +0200
> +++ selinux-22092011-fix-indentation-error-in-seobject-python/policycoreutils/semanage/seobject.py      2011-09-22 22:19:19.036640459 +0200
> @@ -182,7 +182,7 @@ class semanageRecords:
>
>                if not semanageRecords.transaction and store != "":
>                       semanage_select_store(handle, store, SEMANAGE_CON_DIRECT);
> -                     semanageRecords.store = store
> +                      semanageRecords.store = store
>
>                if not semanage_is_managed(handle):
>                       semanage_handle_destroy(handle)
>
> Thanks.
>
> Guido
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
