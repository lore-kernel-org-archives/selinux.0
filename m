Return-Path: <SRS0=OyWE=Q3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6D7C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 19:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5420621841
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 19:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3BJ77re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbfBTTZa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:25:30 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50873 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTTZ3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Feb 2019 14:25:29 -0500
Received: by mail-it1-f194.google.com with SMTP id m137so18116733ita.0
        for <selinux@vger.kernel.org>; Wed, 20 Feb 2019 11:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZf5rj9eStz6iV5jmk7K2CN/A5EFp0Nrs73v/G26Wng=;
        b=m3BJ77reU2qUm8rFrHA4W52XtF/C9gRBIGYcrjIzcVKyC9yJ23yOm4Mb/LOZHdAj5/
         ytxDph1IiiDOaWL/6B/kuLmz/5c5HKc9/q8BQLFacL0lhPSXY/G81WjhPkoOFoawMYa1
         +TvKmewdBkl+jxTPh2VaV5+Zlj0WKXrE6V16wSXYu6nk2NiIC8qq45jTk7XVVwwdsPtu
         ylhGOMIVeXf/BBzbpIMgQdQPpYZExPWw5hiuJETe629vznYyKDQTIdWVAhMKdkJXOw/b
         GsncV5zodwxiCzJB+hMg0EoDzf/PoKXOF9Lzh76Zksr7Qo01NlXCXxPyUSPkUFANSBiw
         AXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZf5rj9eStz6iV5jmk7K2CN/A5EFp0Nrs73v/G26Wng=;
        b=nEATjpyNxyZpyYzJSRL1pMTYy0wD3oeF8e2V5eKU/1xyu0bJcUOjRF8JHDUkjVutuA
         3IHKcOWOfIKC/sVWgCrk9o47SDXspK8R3Qq5Kxjj/JpamIpAjUrzDTdsMWRsVpwQfUc1
         qoMpcS9lvIozB44Fnd6BGOZdg+vVVjc5FUg/WgteFDnWGDe7fOI1ZyEbkhBHWTig6NNA
         +JFZQpqg4Tgzt14Nswbvb82xjyDwSXxHoKooUXeVE5smmxjRS6pk5I0P6B+RWI1HvXDv
         qvMx8K7dyAVZiKS4kEODqJ7bYl32AvzpJhtZgv9GXYhWL7CkzjBrAjBlVHEq7r7e61Dm
         foNw==
X-Gm-Message-State: AHQUAuYQJNohCGr9+0TzS666ap9w0wrqtrksfSH9JkcYST4xXUhLTz5U
        lbGYOFZRkmM8ZrQyw5tbbEWtyrOWx3eLLscObcxveA==
X-Google-Smtp-Source: AHgI3IYnLnpnay4rlQKJOquXy36gK8w3BgbNfS5Mb7oEL7c1PcdUQiIEWXYTxletWT/gBCCbA5CtKO7L0AF51ZbjWxM=
X-Received: by 2002:a5e:8701:: with SMTP id y1mr16166786ioj.78.1550690728805;
 Wed, 20 Feb 2019 11:25:28 -0800 (PST)
MIME-Version: 1.0
References: <20190220123354.1589-1-dominick.grift@defensec.nl>
 <20190220140922.GA10412@brutus.lan> <20190220144742.GB10412@brutus.lan> <CAB9W1A3dbYOQzLh8_+VA9CZp4ccw-FaO=zVDsD2JSbcByYAB+Q@mail.gmail.com>
In-Reply-To: <CAB9W1A3dbYOQzLh8_+VA9CZp4ccw-FaO=zVDsD2JSbcByYAB+Q@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Wed, 20 Feb 2019 14:25:16 -0500
Message-ID: <CAB9W1A0642u1T=7iwQpOqDEqjvGq=wV9042e6P1C6=_-2OFnVw@mail.gmail.com>
Subject: Re: [PATCH] scripts/selinux: modernize mdp
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 20, 2019 at 2:21 PM Stephen Smalley
<stephen.smalley@gmail.com> wrote:
>
> On Wed, Feb 20, 2019 at 9:48 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > On Wed, Feb 20, 2019 at 03:09:22PM +0100, Dominick Grift wrote:
> > > On Wed, Feb 20, 2019 at 01:33:54PM +0100, Dominick Grift wrote:
> > > > The MDP example no longer works on modern systems.
> > > >
> > > > Add support for devtmpfs. This is required by login programs to relabel terminals.
> > > > Compile the policy with deny_unknown allow status to anticipate user space object managers in core components such as systemd.
> > > > Add default seusers mapping and failsafe context for the SELinux PAM module.
> > >
> > > There are a couple more possible improvements that i have identified:
> > >
> > > Fail gracefully if checkpolicy does not exist
> > > Run setfiles with -F. There *might* be one scenario where this might be a good idea. Where the filesystem is labeled with invalid contexts but where SELinux is disabled.
> > > In that case setfiles will reset, but only types (I suppose)
> >
> > This also does not make sense to me:
> >
> >         if [ -f /sbin/setfiles ]; then
> >            SF="/usr/setfiles"
> >
> > I think "-f /usr/setfiles" was meant here? I suppose `which setfiles` only searches "PATH", and so it wouldnt find /usr/setfiles.
> > But then, who uses /usr/setfiles?
>
> No one AFAIK. So I agree that this does not make sense.  Might have
> been a broken attempt to support either /sbin/setfiles or
> /usr/sbin/setfiles as the install location of setfiles, since that did
> change at some point.

Or if as you say it was just an attempt to deal with a PATH that omits
/sbin, then maybe they should both be /sbin/setfiles.

>
> >
> > >
> > > >
> > > > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> > > > ---
> > > >  scripts/selinux/install_policy.sh | 6 +++++-
> > > >  scripts/selinux/mdp/mdp.c         | 1 +
> > > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
> > > > index 0b86c47baf7d..334fcf8903d5 100755
> > > > --- a/scripts/selinux/install_policy.sh
> > > > +++ b/scripts/selinux/install_policy.sh
> > > > @@ -20,14 +20,18 @@ CP=`which checkpolicy`
> > > >  VERS=`$CP -V | awk '{print $1}'`
> > > >
> > > >  ./mdp policy.conf file_contexts
> > > > -$CP -o policy.$VERS policy.conf
> > > > +$CP -U allow -o policy.$VERS policy.conf
> > > >
> > > >  mkdir -p /etc/selinux/dummy/policy
> > > >  mkdir -p /etc/selinux/dummy/contexts/files
> > > >
> > > > +echo "__default__:user_u" > /etc/selinux/dummy/seusers
> > > > +echo "base_r:base_t" > /etc/selinux/dummy/contexts/failsafe_context
> > > > +
> > > >  cp file_contexts /etc/selinux/dummy/contexts/files
> > > >  cp dbus_contexts /etc/selinux/dummy/contexts
> > > >  cp policy.$VERS /etc/selinux/dummy/policy
> > > > +
> > > >  FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
> > > >
> > > >  if [ ! -d /etc/selinux ]; then
> > > > diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
> > > > index 073fe7537f6c..cf06d5694cbc 100644
> > > > --- a/scripts/selinux/mdp/mdp.c
> > > > +++ b/scripts/selinux/mdp/mdp.c
> > > > @@ -131,6 +131,7 @@ int main(int argc, char *argv[])
> > > >
> > > >     fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
> > > >     fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
> > > > +   fprintf(fout, "fs_use_trans devtmpfs user_u:base_r:base_t;\n");
> > > >     fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
> > > >     fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
> > > >     fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
> > > > --
> > > > 2.21.0.rc1
> > > >
> > >
> > > --
> > > Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> > > https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> > > Dominick Grift
> >
> > --
> > Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> > https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> > Dominick Grift
