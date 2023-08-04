Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA93CC001DF
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 18:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjHDShK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjHDSgl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Aug 2023 14:36:41 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B832A5585
        for <selinux@vger.kernel.org>; Fri,  4 Aug 2023 11:36:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so40108201fa.1
        for <selinux@vger.kernel.org>; Fri, 04 Aug 2023 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691174162; x=1691778962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqosJXcjbNP3ljws6F5RiOBvWxFw2Nfi0lWwf0MdAbw=;
        b=Kir0dpHzxiHTTW5ViOkntWLGPuzUMoRwJ9Oj/oEPKD0OYyO3gWH661S245uYAypTRG
         i7ugbRPy7Ky2RAIYjdlu9EZsMrNbjcxqMhKJTJFY6jKbL7V46LcAR2jVwEeguwVcNyGz
         HzWoNFIBMlYllDdMGTk3/ezryLdKRS699sWuBVfNpMOTvWx4kNcdWBrRtvn3UnueX9J3
         adZxFRTD29veC/XjGrdLISgaaoeOu625mGdBEmni979+lA1kJWIJ0x2Cth7xqPNeSxVe
         cej/npXDkSX0j5RrE9jJOVKc41RNnrI0w7fqU5iouRszSaNMwdQVzm4K41r0SyeVcERY
         qVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691174162; x=1691778962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqosJXcjbNP3ljws6F5RiOBvWxFw2Nfi0lWwf0MdAbw=;
        b=X6gsr2Adrq9loHzItNuzD6Rebmy6J+pCp0Hs9pX96ufChqLNIAlNCjxbZ7Sxw+eLsk
         4o2S0t6HdVdGmkesuPC2BVbzhT3H9fuvKQKtbstexM7hFpx1DYS16gM1ArzCSFVwd3Aj
         Sl5Vm/w6HvmKdzQokjj3Xn4ej9yP2jhpM9HWRMAhP2gZkudL015vVm/PrWSs6HnmuhnA
         SZniBrPL8SCj57+wAik0gGP/z6jC5gA4n4fW350IlP1/uZ8lgLTMjnIriY6bn+YQi2/p
         yzMlKe+qbZ3tVWFi3is7iIZujccWAvHVGxB+0Fgishj+tseO0T1Zv+yU3UfYdqLvOpiK
         F9aw==
X-Gm-Message-State: AOJu0YxZCn/uY1VJFGP2xbpjAhYt14uAsU/JzqvtMt93U6HZderUmF5t
        LQP+sA9dydYmND2EN7QuWxLUgglA1wlcRFktaFd0ncTl
X-Google-Smtp-Source: AGHT+IF4jQz217vJ89PQ4m/KWlppNWKkf6SnGRML6MnbhicFU2LlVlsitqV9tPUL5SfunXY8j8SRIRK4Eo1xw3DpFsg=
X-Received: by 2002:a2e:850b:0:b0:2b9:36d5:729c with SMTP id
 j11-20020a2e850b000000b002b936d5729cmr2035909lji.47.1691174161725; Fri, 04
 Aug 2023 11:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230706142126.59907-1-cgzones@googlemail.com> <CAP+JOzRxWk_O2OF9cRke6=0TV3huLp+xD8aOnOhVyrYj4t=obQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRxWk_O2OF9cRke6=0TV3huLp+xD8aOnOhVyrYj4t=obQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Aug 2023 14:35:50 -0400
Message-ID: <CAP+JOzQtG5o8_RQH3vic=BekzLgg+xNCuw08qrzZsoGE2ZsW=g@mail.gmail.com>
Subject: Re: [PATCH] setsebool: improve bash-completion script
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 2, 2023 at 3:20=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Thu, Jul 6, 2023 at 10:42=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Support the usage format of multiple booleans to change, e.g.:
> >
> >     setsebool bool1=3Don bool2=3Doff
> >
> > Support the options -N and -V.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  .../setsebool/setsebool-bash-completion.sh    | 54 ++++++++++++++-----
> >  1 file changed, 42 insertions(+), 12 deletions(-)
> >
> > diff --git a/policycoreutils/setsebool/setsebool-bash-completion.sh b/p=
olicycoreutils/setsebool/setsebool-bash-completion.sh
> > index d0f3b424..f7fe0c0c 100644
> > --- a/policycoreutils/setsebool/setsebool-bash-completion.sh
> > +++ b/policycoreutils/setsebool/setsebool-bash-completion.sh
> > @@ -15,26 +15,56 @@
> >  # You should have received a copy of the GNU General Public License
> >  # along with systemd; If not, see <http://www.gnu.org/licenses/>.
> >
> > -__contains_word () {
> > -        local word=3D$1; shift
> > -        for w in $*; do [[ $w =3D $word ]] && return 0; done
> > -        return 1
> > -}
> > -
> >  __get_all_booleans () {
> >      getsebool -a | cut -f1 -d' '
> >  }
> >
> >  _setsebool () {
> > -        local command=3D${COMP_WORDS[1]}
> >          local cur=3D${COMP_WORDS[COMP_CWORD]} prev=3D${COMP_WORDS[COMP=
_CWORD-1]}
> > -        local verb comps
> >
> > -       if   [ "$verb" =3D "" -a "$prev" =3D "setsebool" -o "$prev" =3D=
 "-P" ]; then
> > -               COMPREPLY=3D( $(compgen -W "-P $( __get_all_booleans ) =
" -- "$cur") )
> > -               return 0
> > +        if [ "$prev" =3D '=3D' ]; then
> > +                COMPREPLY=3D( $(compgen -W "on off" -- "$cur") )
> > +                return 0
> >          fi
> > -        COMPREPLY=3D( $(compgen -W "0 1 -P" -- "$cur") )
> > +
> > +        case "$cur" in
> > +        '0')
> > +                COMPREPLY=3D( $(compgen -W "0 1" -- "$cur") )
> > +                return 0
> > +        ;;
> > +        '1')
> > +                COMPREPLY=3D( $(compgen -W "0 1" -- "$cur") )
> > +                return 0
> > +        ;;
> > +        =3D)
> > +                COMPREPLY=3D( $(compgen -W "on off" -- "") )
> > +                return 0
> > +        ;;
> > +        -*)
> > +                COMPREPLY=3D( $(compgen -W "-N -P -V" -- "$cur") )
> > +                return 0
> > +        ;;
> > +        '')
> > +                if [ "$prev" =3D '0' ] || [ "$prev" =3D '1' ]; then
> > +                        COMPREPLY=3D( $(compgen -W "-N -P -V" -- "$cur=
") )
> > +                        return 0
> > +                fi
> > +                if getsebool "$prev" > /dev/null 2>&1; then
> > +                        COMPREPLY=3D( $(compgen -W "0 1" -- "$cur") )
> > +                        return 0
> > +                fi
> > +        ;;
> > +        *)
> > +                if getsebool "$cur" > /dev/null 2>&1; then
> > +                        COMPREPLY=3D( $(compgen -W '$( __get_all_boole=
ans ) "$cur=3Don " "$cur=3Doff "' -- "$cur") )
> > +                        compopt -o nospace
> > +                        return 0
> > +                fi
> > +        ;;
> > +        esac
> > +
> > +        COMPREPLY=3D( $(compgen -W '"-N " "-P " "-V " $( __get_all_boo=
leans ) ' -- "$cur") )
> > +        compopt -o nospace
> >          return 0
> >  }
> >
> > --
> > 2.40.1
> >
