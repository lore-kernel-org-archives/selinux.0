Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FE5C433DF
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 17:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56FDB2087C
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 17:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="EXjMvaZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbgGaRpy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387429AbgGaRpx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 13:45:53 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9737C061574
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 10:45:53 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 83F192A0CF2;
        Fri, 31 Jul 2020 19:45:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 83F192A0CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1596217551;
        bh=R2jkKPMJ+d1dcegy4Y9sfo93fHRgRP/jp1tPfysz/T8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=EXjMvaZAmTKpxDjZl2iV6VxZdssWVeAbg/eeTp0Kw7tfJzhAOtbjEMzBc15mHAdJK
         yr0yj+HTSWOa44NU8KMZuRJhdvKwfnw79VCW0fAH7ZrqtHePTn7ogNv2RQVPgutCYM
         9zKFhP/7jsvIpiSn++EDq4PMjQ7PaqZZiPEhg4oU=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Gionatan Danti <g.danti@assyoma.it>, selinux@vger.kernel.org
Subject: Re: lnk_file read permission
References: <9c20af23bf7b70d6e01ca6772cc31f88@assyoma.it>
        <CAJ2a_Dcev_o+NyuwUqh2ANseRniZRMQJ4dhDtrF1BtCmFSLgpg@mail.gmail.com>
Date:   Fri, 31 Jul 2020 19:45:47 +0200
In-Reply-To: <CAJ2a_Dcev_o+NyuwUqh2ANseRniZRMQJ4dhDtrF1BtCmFSLgpg@mail.gmail.com>
        ("Christian \=\?utf-8\?Q\?G\=C3\=B6ttsche\=22's\?\= message of "Fri, 31 Jul 2020
 18:25:55 +0200")
Message-ID: <ypjl5za3mvck.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Am Fr., 31. Juli 2020 um 12:03 Uhr schrieb Gionatan Danti <g.danti@assyom=
a.it>:
>>
>> Dear list,
>> I am writing this email as suggested here:
>> https://lists.fedoraproject.org/archives/list/selinux@lists.fedoraprojec=
t.org/message/GWEWGDUQS6PERAYEJHL2EE4GDO432IAO/
>>
>> To recap: I have issue with selinux permission when relocating specific
>> daemon data directory, and using symlink in the original location. For
>> example, lets consider moving /var/lib/mysql in a new, bigger volume.
>>
>> After moving /var/lib/mysql in /data/lib/mysql and creating a symlink
>> for the new location, I used semanage fcontext to add the relative
>> equivalency rules. Moreover, I changed my.cnf to explicitly point to the
>> new data dir and socket file. So far, so good.
>>
>> When restarting apache, I noticed it can't connect to mysql. ausearch -m
>> avc showed the following:
>> ...
>> type=3DAVC msg=3Daudit(1596055762.070:175569): avc:  denied  { read } for
>> pid=3D72946 comm=3D"httpd" name=3D"mysql" dev=3D"sda2" ino=3D103
>> scontext=3Dsystem_u:system_r:httpd_t:s0
>> tcontext=3Dsystem_u:object_r:mysqld_db_t:s0 tclass=3Dlnk_file permissive=
=3D0
>>
>> The log above clearly states that httpd policy lacks lnk_read permission
>> for mysqld_db_t type. While I solved the issue by leaving the socket
>> file inside the original directory (removing the /var/lib/mysql symlink
>> and recreating the mysql dir), I was wondering why each symlink type is
>> specifically allowed
>> rather than giving any processes a generic access to symlinks.
>>
>> Is this kind of rule not permitted by selinux? Can it open the door to
>> other attacks? If so, why? Generally, what is the least invasive
>> approach to relocate services?
>>
>
> An alternative would be, since these symlinks are trusted and
> permanent, to label them as their parent directory (e.g. var_lib_t
> (use the '-l' file type specifier)) and allow the applications to read
> these lnk types.
> This also prevents e.g. mysqld_t to alter the symlink /var/lib/mysqld
> (since it probably has write permission to mysql_db_t:lnk_file but not
> var_lib_t:lnk_file).

This issue is though that you can't override an existing
"/var/lib/msqld(/.*)?" with an "/var/lib/mysqld -l". The former will
take precendence of the latter AFAIK.

You would have to atleast consistently replace all the
/var/log/bla(/.*)? /var/spool/bla(/.*)? /var/lib/bla(/.*)? with /etc/bla
-d /etc/bla/.* etc for systemd respectively

then add equivalency rules:

/var/log/private /var/log
/var/lib/private /var/lib
/var/spool/private /var/spool

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0xDA7E521F10F64098
Dominick Grift
