Return-Path: <SRS0=eoah=N2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65B3C43441
	for <selinux@archiver.kernel.org>; Thu, 15 Nov 2018 19:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888D521582
	for <selinux@archiver.kernel.org>; Thu, 15 Nov 2018 19:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888D521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725742AbeKPFKJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:10:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbeKPFKI (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 16 Nov 2018 00:10:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B564CBDCD
        for <selinux@vger.kernel.org>; Thu, 15 Nov 2018 19:01:09 +0000 (UTC)
Received: from [10.40.204.121] (ovpn-204-121.brq.redhat.com [10.40.204.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85C07600CD;
        Thu, 15 Nov 2018 19:01:06 +0000 (UTC)
To:     selinux@vger.kernel.org
Cc:     Daniel J Walsh <dwalsh@redhat.com>
From:   Lukas Vrabec <lvrabec@redhat.com>
Subject: Container SELinux Customization tool - udica
Openpgp: preference=signencrypt
Autocrypt: addr=lvrabec@redhat.com; keydata=
 xsFNBFqX9fsBEACvMZuLfMn8Fj1XFIir6sXAec5zg1ND0GqmcQM6CnvIPPtD9CDS8W4ppywB
 w/QoFHLH9XrrqNONXu/MfxerGvRu1SRtxDkQGphtR1saTZ+0WFn6b8JwrQRzn1zL3bEB55AB
 5APHcxJ+0MLJSCczbWnZ4DymuPBiEigI5yogYx7XTnbCqgsiECEWId4epatX8fyIEfensCjq
 Gc613QCppKkCABzjvR0ivu5csHvN3ZZB56h4EXiZupqzJXric4NnyqO2kDnErKzzzpB1ILiR
 UWbOogO0prR9jgeITWA3baACcjg/+byTCClp19PE5eu6e9LSlJAC0qsTFJC+XbMhDLuieCmB
 kso3uLV8Icka3IOspTp/jXwJY+jZ4vLvVWbBmNM6vBZ8sZIOXBT9L4SieYyvPb/fy5SukV/0
 LzXIKoCNC757AG51TiBLFML87qbys7+5ug5J6lAvYVbmCxSmTPTcB20MJWwUsRlXMG9l55mW
 kDs5VlPm7brq28FCebh+l5K+IKt+D3PkQlrQKa3YYgL/2QPnd65nUHBL4UfX+1vO3yBqUE7O
 hz5RZ7e5MlxirTPea9GMTfv6/QWyLF+szlFgbdqF5yICa0sn0kjHFjD5NQlmIEdmXD44RACP
 VMTnQhJ4trZ7cCiFnDtliAa9Glqedn8nmWQzS+AiMYLnrJ91fQARAQABzSFMdWthcyBWcmFi
 ZWMgPGx2cmFiZWNAcmVkaGF0LmNvbT7CwY4EEwEIADgWIQTHh3QCUBS0Ag7mUIaM2mOtYz9p
 VQUCWpf1+wIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCM2mOtYz9pVclWD/9ijfua
 XSv8CndLbMJWzmOvfjkQPBM9txIK81KgP7pj3bCQg+toQndmsNRp6KSr4hSBz33qqMZ2i7IV
 20FWxxSgvNatjs+YGSRBEmrsTmWc2fJkU8tYSL6ksEaFt0Te7N2QhpflSp72oVXM4v05vuGQ
 P2rMFibDXaP7bUk61+vUkD1N3Rwc/Kmhubk3smYXuA0PEJqs9XFEn4nF4ps4FKmsdGcSrbjJ
 RO/QMjYGQcWjynnBlneOugTY7dPkxti8yVKVE5O7zd69E6yQoqc1ydEuX78HqtbhiJGZRV1Z
 sEVBhJQX6mAVPMNyEAW56Tc3TH4w9WPcOyWUpYDfGyzcCcxeh/kcL5qDlf9nIjzeuzM9x75m
 mZ8Cp2LmN6IFEgeetnoHWmozg6+juZIIxs18fkLqWcnSUO/Eh9Yfk9U5wfQuUy4nb7aLu5f0
 vfllo7ViPXxXu6mMHhda4xKAlVbQtZU1tP/mS4H/pNXSzW5stpQzb2Ohw5G+0rslH6hSbm85
 WKWYLahSq1kETfAgsv/z+QqrDNEHXa0OSKtS4JGS1A/D4+nAComd2SwlfR34TqcyAPaB/21c
 zpeE/JoN5jGdA6UHHHXGPk495ke25rjokAK8LvEz00fpNpuaQf8W7YAjc1AJUiZ6EJBOqgpq
 F/K8WQ+G2So7c6E9J4xO8ZpfDMh+RM7ATQRal/cLAQgAyDMJ8r1By10fgkXAlvd//MzK7UUT
 cUVcjLjFVq5gRAK0rp97AMPpaZjfBSkpJqQ/EjtkmHRNI4gFOOzie5hy+ANWAKl4dxDo3/hm
 gpXI4nuOlW+tZEeDe7QsppPcFS8TZazw29nMUPcZvLdfOs/3vUblH2h/0SAYVlFAQFsXX07s
 Kl+UW36DpfPtiOavgtOq+elb4E/38wt7TbZf3wePvAnNIil4vaURikxEDn24cU0qIG5uBg+K
 z7PauL9wkE93M40soay+Lm6GBlH/NlI0Nmnvly3JQ52lJ2H46Va63oLFtdnOSjzdLrnNxXqb
 59BuHkHzYcKqhgPc2aglSTJA4wARAQABwsF2BBgBCAAgFiEEx4d0AlAUtAIO5lCGjNpjrWM/
 aVUFAlqX9wsCGwwACgkQjNpjrWM/aVWHqA/7B/vnWfECzG9yTUIluphCCqBJmR+Razj+7e1F
 rlJqQJU3FCfO59dttaS3Ha/+erhQUSHb6adGAuawfQAmqg+oMaIjUJkdDJC8zduRlkng/Pm7
 NrYTtkmXnDtK/v3QL8IJ1N67Pi3Vai3FBj3xcHm0R/eGUIj44GPwoui5FegjQz/64PaHbX2E
 Jy+RB7PclmXYuX/5C3sHa2DgHp/ouUsNKGTojOrUjTk7efcndyz4ujSg2961Z7pe1FPSpL1e
 zcWcpL7PocmJlG8J0uVALxcguNAf3YCvbmKJ4D5c1W+DEJmgdK4pkpRzDLB0QTJz8Ta/xfZK
 RZGJ2yKkMAGCH9xaENELsAp92JY0xCWHWzDN4r5ecKHJVSOjNScrcKRRqulV97EYXLZPl3ty
 TpPEcbenL4ynqEpmmsYPpFbeGudC2MrIdJ91aBE4PHdRqvTZ1n4RBbSdKzctNWmSztvIMg8u
 LEiYrnZEhaNe1LWm64XD/4b+aHL2hks031xMmGsOErttwNEQvLJGtcALZWaU2JmejLpsNrwJ
 HOmznoe56XKwH3blkml7R61MY7scurFQpefCDqNvtgDCWhXTKpLZ3uVNYvC667fK+dO8OLAW
 rE0XkFy+YvwIajpx7fhZIaVU+SdbBO/VTOYMLMz9wLwajkRHEn4Qphmsvl/ZR1d14RhPBlg=
Organization: Red Hat, Inc.
Message-ID: <583686cd-d3e1-d7b6-fbe8-8ab4c26fa65d@redhat.com>
Date:   Thu, 15 Nov 2018 14:01:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p7arCuoLaFbV2LiS8QH64PVdSkKREtfwx"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 15 Nov 2018 19:01:09 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p7arCuoLaFbV2LiS8QH64PVdSkKREtfwx
Content-Type: multipart/mixed; boundary="Ct7EtKGGRG8FYFECvkHTsPIcv8BoQtNTg";
 protected-headers="v1"
From: Lukas Vrabec <lvrabec@redhat.com>
To: selinux@vger.kernel.org
Cc: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <583686cd-d3e1-d7b6-fbe8-8ab4c26fa65d@redhat.com>
Subject: Container SELinux Customization tool - udica

--Ct7EtKGGRG8FYFECvkHTsPIcv8BoQtNTg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi all,

Back in April, I announced that we work on POC how we could
automatically create SELinux security policies for different kind of
containers.

The original concept is described here:
https://github.com/fedora-selinux/container-selinux-customization

Long story short, using pre-defined policy blocks, system administrators
would be able to simply create customized SELinux policies for containers=
=2E

The goal is to create a standalone tool which would be able to do it.
It's called "udica" and you can find it here:

https://github.com/containers/udica

In this repo you can find sources and examples how to create SELinux
policy for your containers.

Udica is also available in Fedora repositories for Fedora Rawhide,
Fedora 29 and Fedora 28.

Feedback is welcome.

--=20
Lukas Vrabec
Software Engineer, Security Technologies
Red Hat, Inc.


--Ct7EtKGGRG8FYFECvkHTsPIcv8BoQtNTg--

--p7arCuoLaFbV2LiS8QH64PVdSkKREtfwx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE3wrP3ArXoyYgAS7LRyAaxC8pzgYFAlvtwnEACgkQRyAaxC8p
zgZSkAf9FZoeO+gs3TcrS9fjJoDWtUMd3FulaCCltYDY3L+v4jI7fQwNrtbSmNjQ
IEYoUnmG1Q56JdOxJHGeN7ikKWDyEEeolBwzd3Qjsmqb2yvIgcq4OhT4+pft7dZK
ygPhuDuO04NkVSeuaEcQ8y9OdnxWm6km5nD2IFFRUSdzMXek5Yl5c9SKF+Kd/naD
CIcvWBORwnKDyJklXZJ/3vXNIxVgCJrW5F7KFjclb9p0PCtLPPmwTMq9W+PN+g2X
3Fd28Ly8n7M2DqTvC6ox6yRQd94zAeDVOnT/n15NcDj0PjLi0wuARRD49rApZdq6
nkcae8+bLshMeOLnsgls+Jpifzza9Q==
=9nKg
-----END PGP SIGNATURE-----

--p7arCuoLaFbV2LiS8QH64PVdSkKREtfwx--
