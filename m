Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5BEECAAD5
	for <selinux@archiver.kernel.org>; Wed, 31 Aug 2022 11:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiHaL5I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Aug 2022 07:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiHaL5G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Aug 2022 07:57:06 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23665D25D4
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 04:57:05 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id i77so11658043ioa.7
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 04:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TKTtw39bFO9cQwfdLgMHzUwLU+diPJ+2GaXBiIqjnNs=;
        b=BhopnwSwy457Wz1Y8gjeHVZ6m5QcJuxs0EndelIECfMehvXEGzJn/dwdTFXzDX+pBD
         35OHjTFLhJvNLp9OxZpFR9K/AZ+hcpcs6hddhOaHEcqoFKwPmy11w+uRAC5x4/q/bMQK
         fMtlzz3HDJGAEJjdZ9GVdgGeZFIVsAG7rQtgGk5j3ZcY0OofYmMVafsfLHygmZLZ1jY0
         TQ/8GFuFk/jiX8pH3LAqph7T/Gm9wzx3ZphOY9Ysyqn6+x+Pl0wnE26V7aNZe/eGTKf7
         Kue4EifLG3mwxt3Phn6eUQlNBLdvX9CME8H9ys9jxsDiejkWHNqle/3TBHEDQRQsKzbU
         wdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TKTtw39bFO9cQwfdLgMHzUwLU+diPJ+2GaXBiIqjnNs=;
        b=YoJGCRi0pWGkdWBmjCXRtDaAv0T+pvVLdFuufECCvEL9X9UPtZLPxYlcrm9BkGBCbe
         qQrn4cQ0aQxPDb5qnexNc272OrlcPNeR042LYNgNqdXevO10fB/JXDT/h38tyCntfW/I
         MgBi2nkubm6vGJc+tRKYgmBE0NZf50TQloH6XQhMxUTrrTmV+GOhGBM5L8p68slAjfcd
         pTzMBRi1/Yp977KkzuZJLakPEUdg1B0vw+P02QhB4B14LT6cTYrKRWjuiHko7WIlkKhu
         8gt943H7edSgJBR1XaGGEx+ni8lpfHF0oY9XNCTnmjEKqXbpP9ZAaqI5ByNrc3bcw/RW
         c+Ag==
X-Gm-Message-State: ACgBeo2/w6lhJELekLRjSUYDhVusOoHAFPNzffwFiuJq3C8gk7QtZTmk
        hCLdJHc8mhNCLl33zAd3WzGgqhag1Q1eyfSU2AbwjwaRUKU=
X-Google-Smtp-Source: AA6agR5b8cBqrHHP3coQ1TTXDU8OZ8E78eRHPJXnjzPfFTNAo8/CUYYdV/DAw7FEH+VqO04MBu3JbqaLofFvKx0HO7Q=
X-Received: by 2002:a02:ccb7:0:b0:34b:f19:d9b7 with SMTP id
 t23-20020a02ccb7000000b0034b0f19d9b7mr3307619jap.183.1661947024513; Wed, 31
 Aug 2022 04:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <4ad30dd7-ec19-e88a-848e-98de8af7a16b@gmail.com> <CAP+JOzS82HOzmEKbeofQGgWhf4mk76ywJ-2ogqYBJ4T_k29w_w@mail.gmail.com>
In-Reply-To: <CAP+JOzS82HOzmEKbeofQGgWhf4mk76ywJ-2ogqYBJ4T_k29w_w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 31 Aug 2022 07:56:53 -0400
Message-ID: <CAP+JOzQdPcAftPtqQ7+1Kma2d1P1MGy7bHo2xxh2jpaD3CD0aw@mail.gmail.com>
Subject: Re: [PATCH 1/3] secilc/docs: selinuxuser actually takes a string not identifier
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000008a76e05e7883266"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--00000000000008a76e05e7883266
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 30, 2022 at 4:45 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Sun, Aug 28, 2022 at 8:18 AM bauen1 <j2468h@googlemail.com> wrote:
> >
> > Update parameter table and add note to example.
> > This can very easily lead to confusion, because secilc does not reject
> > e.g. (selinuxuser "admin_1" admin low_low).
> >
> > Signed-off-by: Jonathan Hettwer (bauen1) <j2468h@gmail.com>
> > ---
> >   secilc/docs/cil_user_statements.md | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/secilc/docs/cil_user_statements.md b/secilc/docs/cil_user_statements.md
> > index d5674f12..45a52140 100644
> > --- a/secilc/docs/cil_user_statements.md
> > +++ b/secilc/docs/cil_user_statements.md
> > @@ -429,7 +429,7 @@ Associates a GNU/Linux user to a previously declared [`user`](cil_user_statement
> >   </tr>
> >   <tr class="odd">
> >   <td align="left"><p><code>user_id</code></p></td>
> > -<td align="left"><p>A previously declared SELinux <code>user</code> identifier.</p></td>
> > +<td align="left"><p>A <b>string</b> referencing a previously declared SELinux <code>user</code> identifier.</p></td>
> >   </tr>
> >   <tr class="even">
> >   <td align="left"><p><code>userrange_id</code></p></td>
> > @@ -445,7 +445,8 @@ This example will associate `unconfined.admin` user with a GNU / Linux user "`ad
> >   ```secil
> >       (block unconfined
> >           (user admin)
> > -        (selinuxuser admin_1 admin low_low)
> > +        ; XXX: Because the user_id is a string, the fully qualified identifier needs to be used here:
> > +        (selinuxuser "admin_1" "unconfined.admin" low_low)
>
> I don't see this behavior.
>
> The following:
> (block b2
>   (user user2_u)
>   (userrole user2_u ROLE)
>   (userlevel user2_u (SENS))
>   (userrange user2_u ((SENS) (SENS (CAT))))
>   (userprefix user2_u user2)
>   (selinuxuser name2 user2_u ((SENS) (SENS (CAT))))
> )
> Gives me:
> name2:b2.user2_u:SENS-SENS:CAT
>
> It works with quotes as well, but it doesn't require them.
>
> The following:
> (block b3
>   (user user3_u)
>   (userrole user3_u ROLE)
>   (userlevel user3_u (SENS))
>   (userrange user3_u ((SENS) (SENS (CAT))))
>   (userprefix user3_u user3)
>   (selinuxuser "name3" "user3_u" ((SENS) (SENS (CAT))))
> )
> Gives me:
> name3:b3.user3_u:SENS-SENS:CAT
>
> Thanks,
> Jim

Attached is the policy I used to test and a program that calls
cil_selinuxusers_to_string().
Jim

--00000000000008a76e05e7883266
Content-Type: application/vnd.ms-artgalry; name="test_user_rules.cil"
Content-Disposition: attachment; filename="test_user_rules.cil"
Content-Transfer-Encoding: base64
Content-ID: <f_l7hkc0ls0>
X-Attachment-Id: f_l7hkc0ls0

OzsgVGVzdCBzZWxpbnV4dXNlciBydWxlCgooY2xhc3MgQ0xBU1MgKFBFUk0pKQooY2xhc3NvcmRl
ciAoQ0xBU1MpKQooc2lkIFNJRCkKKHNpZG9yZGVyIChTSUQpKQoodXNlciBVU0VSKQoocm9sZSBS
T0xFKQoodHlwZSBUWVBFKQooY2F0ZWdvcnkgQ0FUKQooY2F0ZWdvcnlvcmRlciAoQ0FUKSkKKHNl
bnNpdGl2aXR5IFNFTlMpCihzZW5zaXRpdml0eW9yZGVyIChTRU5TKSkKKHNlbnNpdGl2aXR5Y2F0
ZWdvcnkgU0VOUyAoQ0FUKSkKKGFsbG93IFRZUEUgc2VsZiAoQ0xBU1MgKFBFUk0pKSkKKHJvbGV0
eXBlIFJPTEUgVFlQRSkKKHVzZXJyb2xlIFVTRVIgUk9MRSkKKHVzZXJsZXZlbCBVU0VSIChTRU5T
KSkKKHVzZXJyYW5nZSBVU0VSICgoU0VOUykoU0VOUyAoQ0FUKSkpKQooc2lkY29udGV4dCBTSUQg
KFVTRVIgUk9MRSBUWVBFICgoU0VOUykoU0VOUykpKSkKCih1c2VyIHVzZXIxX3UpCih1c2Vycm9s
ZSB1c2VyMV91IFJPTEUpCih1c2VybGV2ZWwgdXNlcjFfdSAoU0VOUykpCih1c2VycmFuZ2UgdXNl
cjFfdSAoKFNFTlMpIChTRU5TIChDQVQpKSkpCih1c2VycHJlZml4IHVzZXIxX3UgdXNlcjEpCihz
ZWxpbnV4dXNlciBuYW1lMSB1c2VyMV91ICgoU0VOUykgKFNFTlMgKENBVCkpKSkKCihibG9jayBi
MgogICh1c2VyIHVzZXIyX3UpCiAgKHVzZXJyb2xlIHVzZXIyX3UgUk9MRSkKICAodXNlcmxldmVs
IHVzZXIyX3UgKFNFTlMpKQogICh1c2VycmFuZ2UgdXNlcjJfdSAoKFNFTlMpIChTRU5TIChDQVQp
KSkpCiAgKHVzZXJwcmVmaXggdXNlcjJfdSB1c2VyMikKICAoc2VsaW51eHVzZXIgbmFtZTIgdXNl
cjJfdSAoKFNFTlMpIChTRU5TIChDQVQpKSkpCikKCihibG9jayBiMwogICh1c2VyIHVzZXIzX3Up
CiAgKHVzZXJyb2xlIHVzZXIzX3UgUk9MRSkKICAodXNlcmxldmVsIHVzZXIzX3UgKFNFTlMpKQog
ICh1c2VycmFuZ2UgdXNlcjNfdSAoKFNFTlMpIChTRU5TIChDQVQpKSkpCiAgKHVzZXJwcmVmaXgg
dXNlcjNfdSB1c2VyMykKICAoc2VsaW51eHVzZXIgIm5hbWUzIiAidXNlcjNfdSIgKChTRU5TKSAo
U0VOUyAoQ0FUKSkpKQopCgooYmxvY2sgYjQKICAodXNlciB1c2VyNF91KQogICh1c2Vycm9sZSB1
c2VyNF91IFJPTEUpCiAgKHVzZXJsZXZlbCB1c2VyNF91IChTRU5TKSkKICAodXNlcnJhbmdlIHVz
ZXI0X3UgKChTRU5TKSAoU0VOUyAoQ0FUKSkpKQogICh1c2VycHJlZml4IHVzZXI0X3UgdXNlcjQp
CiAgKHNlbGludXh1c2VyIG5hbWU0ICJiNC51c2VyNF91IiAoKFNFTlMpIChTRU5TIChDQVQpKSkp
CikKCihibG9jayBiNQogICh1c2VyIHVzZXI1X3UpCiAgKHVzZXJyb2xlIHVzZXI1X3UgUk9MRSkK
ICAodXNlcmxldmVsIHVzZXI1X3UgKFNFTlMpKQogICh1c2VycmFuZ2UgdXNlcjVfdSAoKFNFTlMp
IChTRU5TIChDQVQpKSkpCiAgKHVzZXJwcmVmaXggdXNlcjVfdSB1c2VyNSkKICAoc2VsaW51eHVz
ZXIgIm5hbWU1IiAiYjUudXNlcjVfdSIgKChTRU5TKSAoU0VOUyAoQ0FUKSkpKQopCgooYmxvY2sg
YjYKICAodXNlciB1c2VyNl91KQogICh1c2Vycm9sZSB1c2VyNl91IFJPTEUpCiAgKHVzZXJsZXZl
bCB1c2VyNl91IChTRU5TKSkKICAodXNlcnJhbmdlIHVzZXI2X3UgKChTRU5TKSAoU0VOUyAoQ0FU
KSkpKQogICh1c2VycHJlZml4IHVzZXI2X3UgdXNlcjYpCiAgKHNlbGludXh1c2VyZGVmYXVsdCB1
c2VyNl91ICgoU0VOUykgKFNFTlMgKENBVCkpKSkKKQo=
--00000000000008a76e05e7883266
Content-Type: text/x-csrc; charset="US-ASCII"; name="get_selinuxusers.c"
Content-Disposition: attachment; filename="get_selinuxusers.c"
Content-Transfer-Encoding: base64
Content-ID: <f_l7hkc6cg1>
X-Attachment-Id: f_l7hkc6cg1

CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRpbnQu
aD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KCiNpbmNsdWRlIDxz
ZXBvbC9jaWwvY2lsLmg+CiNpbmNsdWRlIDxzZXBvbC9wb2xpY3lkYi5oPgoKc3RhdGljIGludCB3
cml0ZV9vdXRfc2VsaW51eHVzZXJzKHN0cnVjdCBjaWxfZGIgKmRiKQp7CglpbnQgcmM7CgljaGFy
ICpkYXRhOwoJc2l6ZV90IHNpemUsIGk7CgoJcmMgPSBjaWxfc2VsaW51eHVzZXJzX3RvX3N0cmlu
ZyhkYiwgJmRhdGEsICZzaXplKTsKCWlmIChyYyAhPSBTRVBPTF9PSykgewoJCXJldHVybiByYzsK
CX0KCglpZiAoc2l6ZSA+IDApIHsKCQlwcmludGYoIiMjIyMjIyMjIyMjIyMjIyMjIyMjXG4iKTsK
CQlmb3IgKGk9MDsgaTxzaXplOyBpKyspIHsKCQkJcHJpbnRmKCIlYyIsIGRhdGFbaV0pOwoJCX0K
CQlwcmludGYoIiMjIyMjIyMjIyMjIyMjIyMjIyMjXG4iKTsKCX0KCglyZXR1cm4gMDsKfQoKLyoK
Z2NjIC1JL2hvbWUvamltL2xvY2FsL3Vzci9pbmNsdWRlIC1ML2hvbWUvamltL2xvY2FsL3Vzci9s
aWIgLWxzZXBvbCAtbyBnZXRfc2VsaW51eHVzZXJzIGdldF9zZWxpbnV4dXNlcnMuYwoqLwppbnQg
bWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQp7CglzdHJ1Y3QgY2lsX2RiICpkYiA9IE5VTEw7
CglGSUxFICpmaWxlID0gTlVMTDsKCWNoYXIgKmJ1ZmZlciA9IE5VTEw7CglzdHJ1Y3Qgc3RhdCBm
aWxlZGF0YTsKCXVpbnQzMl90IGZpbGVfc2l6ZTsKCWludCBpOwoJaW50IHJjID0gU0VQT0xfRVJS
OwoKCWlmIChhcmdjIDwgMikgewoJCWZwcmludGYoc3RkZXJyLCAiTm8gY2lsIGZpbGVzIHNwZWNp
ZmllZFxuIik7CgkJcmMgPSBTRVBPTF9FUlI7CgkJZ290byBleGl0OwoJfQoKCWNpbF9zZXRfbG9n
X2xldmVsKENJTF9FUlIpOwoKCWNpbF9kYl9pbml0KCZkYik7CgljaWxfc2V0X21scyhkYiwgMSk7
CgljaWxfc2V0X3ByZXNlcnZlX3R1bmFibGVzKGRiLCAwKTsKCWNpbF9zZXRfcXVhbGlmaWVkX25h
bWVzKGRiLCAwKTsKCWNpbF9zZXRfYXR0cnNfZXhwYW5kX2dlbmVyYXRlZChkYiwgMCk7CgljaWxf
c2V0X2F0dHJzX2V4cGFuZF9zaXplKGRiLCAwKTsKCglmb3IgKGkgPSAxOyBpIDwgYXJnYzsgaSsr
KSB7CgkJZmlsZSA9IGZvcGVuKGFyZ3ZbaV0sICJyIik7CgkJaWYgKCFmaWxlKSB7CgkJCWZwcmlu
dGYoc3RkZXJyLCAiQ291bGQgbm90IG9wZW4gZmlsZTogJXNcbiIsIGFyZ3ZbaV0pOwoJCQlyYyA9
IFNFUE9MX0VSUjsKCQkJZ290byBleGl0OwoJCX0KCQlyYyA9IHN0YXQoYXJndltpXSwgJmZpbGVk
YXRhKTsKCQlpZiAocmMgPT0gLTEpIHsKCQkJZnByaW50ZihzdGRlcnIsICJDb3VsZCBub3Qgc3Rh
dCBmaWxlOiAlc1xuIiwgYXJndltpXSk7CgkJCWdvdG8gZXhpdDsKCQl9CgkJZmlsZV9zaXplID0g
ZmlsZWRhdGEuc3Rfc2l6ZTsKCgkJYnVmZmVyID0gbWFsbG9jKGZpbGVfc2l6ZSk7CgkJcmMgPSBm
cmVhZChidWZmZXIsIGZpbGVfc2l6ZSwgMSwgZmlsZSk7CgkJaWYgKHJjICE9IDEpIHsKCQkJZnBy
aW50ZihzdGRlcnIsICJGYWlsdXJlIHJlYWRpbmcgZmlsZTogJXNcbiIsIGFyZ3ZbaV0pOwoJCQln
b3RvIGV4aXQ7CgkJfQoJCWZjbG9zZShmaWxlKTsKCQlmaWxlID0gTlVMTDsKCgkJcmMgPSBjaWxf
YWRkX2ZpbGUoZGIsIGFyZ3ZbaV0sIGJ1ZmZlciwgZmlsZV9zaXplKTsKCQlpZiAocmMgIT0gU0VQ
T0xfT0spIHsKCQkJZnByaW50ZihzdGRlcnIsICJGYWlsdXJlIGFkZGluZyAlc1xuIiwgYXJndltp
XSk7CgkJCWdvdG8gZXhpdDsKCQl9CgoJCWZyZWUoYnVmZmVyKTsKCQlidWZmZXIgPSBOVUxMOwoJ
fQoKCXJjID0gY2lsX2NvbXBpbGUoZGIpOwoJaWYgKHJjICE9IFNFUE9MX09LKSB7CgkJZnByaW50
ZihzdGRlcnIsICJGYWlsZWQgdG8gY29tcGlsZSBDSUwgcG9saWN5XG4iKTsKCQlnb3RvIGV4aXQ7
Cgl9CgoJcmMgPSB3cml0ZV9vdXRfc2VsaW51eHVzZXJzKGRiKTsKCWlmIChyYyAhPSBTRVBPTF9P
SykgewoJCWZwcmludGYoc3RkZXJyLCAiRmFpbGVkIHRvIHdyaXRlIHNlbGludXggdXNlcnNcbiIp
OwoJCWdvdG8gZXhpdDsKCX0KCgkKZXhpdDoKCWZyZWUoYnVmZmVyKTsKCWNpbF9kYl9kZXN0cm95
KCZkYik7CglyZXR1cm4gcmM7Cn0K
--00000000000008a76e05e7883266--
