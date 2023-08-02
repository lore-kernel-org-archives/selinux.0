Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1625C04A94
	for <selinux@archiver.kernel.org>; Wed,  2 Aug 2023 19:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjHBTVJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Aug 2023 15:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjHBTVI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Aug 2023 15:21:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A9DA
        for <selinux@vger.kernel.org>; Wed,  2 Aug 2023 12:21:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so2503171fa.0
        for <selinux@vger.kernel.org>; Wed, 02 Aug 2023 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691004064; x=1691608864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l/xoxiz18JZxl6gbvx5Wutezs55u7wJCbU+r+1U9cE=;
        b=dITyX3Rd3l02TxzwTfXSR1ZsdHbRnR8F5pSEBHK3DgdbCvzXHrGuP/aOozzXqQ3xpJ
         0qmL5davy3i6Q0rMOF7CIuAMbRVaEuNJc+tTG1pKCl6cnC3nxSnqk9UdOenoChODuH3g
         siOsiXASmNLY+u/o9NMOEB66LdeWbU/OQJVA0xW8zha8ckjxb7O6T4hGAcB+8WOfUCXI
         b0B8gBs3JLZq1M7QDr8QkjcBlYYAkRwvWdsofcPOedL2YFBDAXqtT5fm2Urjw4dOjdU6
         NkosDdhLI1P14kfL+w+sUW2Jg0IA+78l1YMHWwQebiBqIoITJecHV9Dgr95WwiV3RoEy
         hOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691004064; x=1691608864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5l/xoxiz18JZxl6gbvx5Wutezs55u7wJCbU+r+1U9cE=;
        b=dnTeMHl7VbE3sCi4spjofci6yPM4GijWJ67tCgcuaxS85Prz2QAvMZvNTtd2rwOVPV
         XcnD3ZoM8nb79vhEJ/pCMHJ5fdc7VfK7ecyErjDr0fJ07l/qt+WJHxgNB4gmK3L7ULqW
         GbvhFggENQkjiw9vkloRSET4mfJWqX+NSA6XsDbyz35vFyJXjuLoofeJX2Um26lY0liQ
         jXXW80j1cL/FMHV+kYLgQXG6dovZIRJJcwUK4n6N7HNcGzIocez8HJbgvH0VRc1glkqu
         JyMLHwqi93TdX0b8Hyh96PtoK52yzCnR5j5YsUk18ldQJhkkp/YZmNOALyxGXzvD50OA
         Aj9A==
X-Gm-Message-State: ABy/qLbBUbhrOGBOOPQo+xC75r6B7L0jOuDn9brtAjSmNOzmN0GBeo16
        X3bsvVSgVFU8mewq/c0W0k5NTEfp1MC03WIzLU25FKOYr/c=
X-Google-Smtp-Source: APBJJlGDhoA58s+i/9Qh+YIL4a/iQjVSIWvGrJZlL7BGMgzsdOA25jCTTbBfL60jn3AJs09rL04qjyb70qb3DAKWyHI=
X-Received: by 2002:a2e:998f:0:b0:2b9:45ad:88b1 with SMTP id
 w15-20020a2e998f000000b002b945ad88b1mr6074563lji.2.1691004064102; Wed, 02 Aug
 2023 12:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230706142126.59907-1-cgzones@googlemail.com>
In-Reply-To: <20230706142126.59907-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 2 Aug 2023 15:20:52 -0400
Message-ID: <CAP+JOzRxWk_O2OF9cRke6=0TV3huLp+xD8aOnOhVyrYj4t=obQ@mail.gmail.com>
Subject: Re: [PATCH] setsebool: improve bash-completion script
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 6, 2023 at 10:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Support the usage format of multiple booleans to change, e.g.:
>
>     setsebool bool1=3Don bool2=3Doff
>
> Support the options -N and -V.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  .../setsebool/setsebool-bash-completion.sh    | 54 ++++++++++++++-----
>  1 file changed, 42 insertions(+), 12 deletions(-)
>
> diff --git a/policycoreutils/setsebool/setsebool-bash-completion.sh b/pol=
icycoreutils/setsebool/setsebool-bash-completion.sh
> index d0f3b424..f7fe0c0c 100644
> --- a/policycoreutils/setsebool/setsebool-bash-completion.sh
> +++ b/policycoreutils/setsebool/setsebool-bash-completion.sh
> @@ -15,26 +15,56 @@
>  # You should have received a copy of the GNU General Public License
>  # along with systemd; If not, see <http://www.gnu.org/licenses/>.
>
> -__contains_word () {
> -        local word=3D$1; shift
> -        for w in $*; do [[ $w =3D $word ]] && return 0; done
> -        return 1
> -}
> -
>  __get_all_booleans () {
>      getsebool -a | cut -f1 -d' '
>  }
>
>  _setsebool () {
> -        local command=3D${COMP_WORDS[1]}
>          local cur=3D${COMP_WORDS[COMP_CWORD]} prev=3D${COMP_WORDS[COMP_C=
WORD-1]}
> -        local verb comps
>
> -       if   [ "$verb" =3D "" -a "$prev" =3D "setsebool" -o "$prev" =3D "=
-P" ]; then
> -               COMPREPLY=3D( $(compgen -W "-P $( __get_all_booleans ) " =
-- "$cur") )
> -               return 0
> +        if [ "$prev" =3D '=3D' ]; then
> +                COMPREPLY=3D( $(compgen -W "on off" -- "$cur") )
> +                return 0
>          fi
> -        COMPREPLY=3D( $(compgen -W "0 1 -P" -- "$cur") )
> +
> +        case "$cur" in
> +        '0')
> +                COMPREPLY=3D( $(compgen -W "0 1" -- "$cur") )
> +                return 0
> +        ;;
> +        '1')
> +                COMPREPLY=3D( $(compgen -W "0 1" -- "$cur") )
> +                return 0
> +        ;;
> +        =3D)
> +                COMPREPLY=3D( $(compgen -W "on off" -- "") )
> +                return 0
> +        ;;
> +        -*)
> +                COMPREPLY=3D( $(compgen -W "-N -P -V" -- "$cur") )
> +                return 0
> +        ;;
> +        '')
> +                if [ "$prev" =3D '0' ] || [ "$prev" =3D '1' ]; then
> +                        COMPREPLY=3D( $(compgen -W "-N -P -V" -- "$cur")=
 )
> +                        return 0
> +                fi
> +                if getsebool "$prev" > /dev/null 2>&1; then
> +                        COMPREPLY=3D( $(compgen -W "0 1" -- "$cur") )
> +                        return 0
> +                fi
> +        ;;
> +        *)
> +                if getsebool "$cur" > /dev/null 2>&1; then
> +                        COMPREPLY=3D( $(compgen -W '$( __get_all_boolean=
s ) "$cur=3Don " "$cur=3Doff "' -- "$cur") )
> +                        compopt -o nospace
> +                        return 0
> +                fi
> +        ;;
> +        esac
> +
> +        COMPREPLY=3D( $(compgen -W '"-N " "-P " "-V " $( __get_all_boole=
ans ) ' -- "$cur") )
> +        compopt -o nospace
>          return 0
>  }
>
> --
> 2.40.1
>
