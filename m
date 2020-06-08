Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47588C433DF
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 16:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F78A20774
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 16:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re5A2jlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgFHQSi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgFHQSi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 12:18:38 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66313C08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 09:18:38 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id d67so15821294oig.6
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxgX8XRTZ/HnkW28Jox/7DYc5hEQI3C4tGBMR0OOhRA=;
        b=Re5A2jlZovoEN+Ylll7kgPwdCF81cneXLrrmjJFqAtDCEolVl5NU/OwU86FXZdJtgd
         cxDlewN53oumqmZJR4Lyp2xqkezh/ZzWsdFC8FVvImLg4ruxqdn03shBYOai3zpMWFd6
         Z7K935t8UwY97iftQ8fKuHMzMxdnXIiObUzScA8zqJI04Q0ryMZvFfFiWfkijfrX6O2q
         ufJJqb950UaqvDe4WEvMC/8juIXTHKy6knxs6l7uw60yE6u1cP8JW7PDcR9WPTh+RMhf
         IBHQ2SCA8XOwGpYuaFDBcuIvJtKfcPh/e/u0zh28vhKeWGGK7PiIM6qm5/2jiN6ipyaE
         iuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxgX8XRTZ/HnkW28Jox/7DYc5hEQI3C4tGBMR0OOhRA=;
        b=gmqKMebx0XX9dEsS5RPYoCzo/mJM8VOHUGbP7FBeCwUQ0J6B7Iw2ZL7kB/WmiknszU
         q9m27y9LHTK87OzkgiLpAzW2CEhsy4f1w7EfBLcQAWmcbQsLdvwQ1HkDyngkWxDG7IAy
         UylN5ByrcIQ9jE2F3xFBjDNrj3XdDyX0HWVBJJjQEoFMFNMOrQlVHYdR6pFZyJTrkfGs
         JH5Y5UPXTVCCfNJW5RsuZY4lgXeq8FBzXpGUq+wkBT28Nrgj3f2pfRRapL8oRHbVpNZA
         ijq2tmRNJPuGGrtwVCuCZtito2Uejvx7eTtwWJ2U9AeGmBdEj0YSuwhjv09EtFT6Rrqh
         CEKA==
X-Gm-Message-State: AOAM532rNNrYh5oFYLKqZIrHnBUOUBuanCFqsNC6lEb3kCTvuiZK0AWR
        eTOY9Qk2ivBRLlV6s1rR1ih7T9vUoKD6zf+a2/g=
X-Google-Smtp-Source: ABdhPJwi3GfjWvAJDETIoOvqTUhdh+D3Wy4eqgzWPyGixX9AnhTdi7QjiaEMHRys1SQ3tSNW1otAY0mRJB1Kryven7k=
X-Received: by 2002:aca:ec97:: with SMTP id k145mr121248oih.92.1591633117782;
 Mon, 08 Jun 2020 09:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200605081952.16278-1-toiwoton@gmail.com>
In-Reply-To: <20200605081952.16278-1-toiwoton@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 8 Jun 2020 12:18:26 -0400
Message-ID: <CAEjxPJ50YNJViUUA=7jaLwzPDMJUE0xzegAes4YF=TwpAo88YQ@mail.gmail.com>
Subject: Re: [PATCH v2] semanage: handle getprotobyname() failure case
To:     Topi Miettinen <toiwoton@gmail.com>, linux-audit@redhat.com
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 5, 2020 at 4:24 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> At least on Debian, /etc/protocols, which is used by
> socket.getprotobyname() to resolve protocols to names, does not
> contain an entry for "ipv4". In that case, set the protocol number
> used by audit logs for "ipv4" to a fixed value. To ensure audit log
> compatibility, let's use the same numeric value as Fedora: 4, which is
> actually understood by kernel as IP over IP.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

This looks fine to me but adding linux-audit mailing list to see if
they have any concerns.  It appears to make no change to the audit
messages on Fedora.

> ---
> v2: don't change audit log format
> ---
>  python/semanage/seobject.py | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 6e0b87f2..6a14f7b4 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1870,10 +1870,22 @@ class nodeRecords(semanageRecords):
>          except:
>              raise ValueError(_("Unknown or missing protocol"))
>
> -        return newaddr, newmask, newprotocol
> +        try:
> +            audit_protocol = socket.getprotobyname(protocol)
> +        except:
> +            # Entry for "ipv4" not found in /etc/protocols on (at
> +            # least) Debian? To ensure audit log compatibility, let's
> +            # use the same numeric value as Fedora: 4, which is
> +            # actually understood by kernel as IP over IP.
> +            if (protocol == "ipv4"):
> +                audit_protocol = socket.IPPROTO_IPIP
> +            else:
> +                raise ValueError(_("Unknown or missing protocol"))
> +
> +        return newaddr, newmask, newprotocol, audit_protocol
>
>      def __add(self, addr, mask, proto, serange, ctype):
> -        addr, mask, proto = self.validate(addr, mask, proto)
> +        addr, mask, proto, audit_proto = self.validate(addr, mask, proto)
>
>          if is_mls_enabled == 1:
>              if serange == "":
> @@ -1942,7 +1954,7 @@ class nodeRecords(semanageRecords):
>          semanage_node_key_free(k)
>          semanage_node_free(node)
>
> -        self.mylog.log_change("resrc=node op=add laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, socket.getprotobyname(self.protocol[proto]), "system_u", "object_r", ctype, serange))
> +        self.mylog.log_change("resrc=node op=add laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, audit_proto, "system_u", "object_r", ctype, serange))
>
>      def add(self, addr, mask, proto, serange, ctype):
>          self.begin()
> @@ -1950,7 +1962,7 @@ class nodeRecords(semanageRecords):
>          self.commit()
>
>      def __modify(self, addr, mask, proto, serange, setype):
> -        addr, mask, proto = self.validate(addr, mask, proto)
> +        addr, mask, proto, audit_proto = self.validate(addr, mask, proto)
>
>          if serange == "" and setype == "":
>              raise ValueError(_("Requires setype or serange"))
> @@ -1987,7 +1999,7 @@ class nodeRecords(semanageRecords):
>          semanage_node_key_free(k)
>          semanage_node_free(node)
>
> -        self.mylog.log_change("resrc=node op=modify laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, socket.getprotobyname(self.protocol[proto]), "system_u", "object_r", setype, serange))
> +        self.mylog.log_change("resrc=node op=modify laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, audit_proto, "system_u", "object_r", setype, serange))
>
>      def modify(self, addr, mask, proto, serange, setype):
>          self.begin()
> @@ -1995,8 +2007,7 @@ class nodeRecords(semanageRecords):
>          self.commit()
>
>      def __delete(self, addr, mask, proto):
> -
> -        addr, mask, proto = self.validate(addr, mask, proto)
> +        addr, mask, proto, audit_proto = self.validate(addr, mask, proto)
>
>          (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
>          if rc < 0:
> @@ -2020,7 +2031,7 @@ class nodeRecords(semanageRecords):
>
>          semanage_node_key_free(k)
>
> -        self.mylog.log_change("resrc=node op=delete laddr=%s netmask=%s proto=%s" % (addr, mask, socket.getprotobyname(self.protocol[proto])))
> +        self.mylog.log_change("resrc=node op=delete laddr=%s netmask=%s proto=%s" % (addr, mask, audit_proto))
>
>      def delete(self, addr, mask, proto):
>          self.begin()
> --
> 2.26.2
>
