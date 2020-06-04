Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB82C433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 17:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1EA2100A
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 17:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTxZ9urC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgFDRUW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:20:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26721 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730068AbgFDRUV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 13:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591291220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=QBOHRJ+4Lc/Ud9BvOHvoAa44TwYJiaTY50ZFRw5YC98=;
        b=KTxZ9urCz3YrieK9/1HwOlSEuCULNjf9i7BKnvNaGnX0LKUxKfsSu/oClNK3nSYob0qyGk
        689zNCXewdbp1JXLH3bbI1GetOEx8Q8W8zQQ2uSgUhEJ9TeXa2mr8QeokemZ2UCpnziJtM
        Cc9KHu13xW6fkekPZHTDxgyAHVbWD/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-MBWNCdcAO0OdTiF5oseO3g-1; Thu, 04 Jun 2020 13:20:10 -0400
X-MC-Unique: MBWNCdcAO0OdTiF5oseO3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76777800C78
        for <selinux@vger.kernel.org>; Thu,  4 Jun 2020 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.191])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73FE05D9CD
        for <selinux@vger.kernel.org>; Thu,  4 Jun 2020 17:20:08 +0000 (UTC)
Date:   Thu, 4 Jun 2020 19:20:05 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: sepolicy test fails with Python-3.9
Message-ID: <20200604172005.GA128963@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

https://jenkins-continuous-infra.apps.ci.centos.org/job/fedora-rawhide-pr-pipeline/3747/artifact/package-tests/logs/FAIL-upstream-err.log

Verify sepolicy interface -c -i works ... Traceback (most recent call last):
  File "/usr/bin/sepolicy", line 691, in <module>
    args = parser.parse_args(args=parser_args)
  File "/usr/lib64/python3.9/argparse.py", line 1819, in parse_args
    args, argv = self.parse_known_args(args, namespace)
  File "/usr/lib64/python3.9/argparse.py", line 1852, in parse_known_args
    namespace, args = self._parse_known_args(args, namespace)
  File "/usr/lib64/python3.9/argparse.py", line 2043, in _parse_known_args
    positionals_end_index = consume_positionals(start_index)
  File "/usr/lib64/python3.9/argparse.py", line 2020, in consume_positionals
    take_action(action, args)
  File "/usr/lib64/python3.9/argparse.py", line 1929, in take_action
    action(self, namespace, argument_values, option_string)
  File "/usr/lib64/python3.9/argparse.py", line 1208, in __call__
    subnamespace, arg_strings = parser.parse_known_args(arg_strings, None)
  File "/usr/lib64/python3.9/argparse.py", line 1852, in parse_known_args
    namespace, args = self._parse_known_args(args, namespace)
  File "/usr/lib64/python3.9/argparse.py", line 2061, in _parse_known_args
    start_index = consume_optional(start_index)
  File "/usr/lib64/python3.9/argparse.py", line 2001, in consume_optional
    take_action(action, args, option_string)
  File "/usr/lib64/python3.9/argparse.py", line 1929, in take_action
    action(self, namespace, argument_values, option_string)
  File "/usr/bin/sepolicy", line 216, in __call__
    interface_dict = get_interface_dict()
  File "/usr/lib/python3.9/site-packages/sepolicy/interface.py", line 149, in get_interface_dict
    for i in m.getiterator('interface'):
AttributeError: 'xml.etree.ElementTree.Element' object has no attribute 'getiterator'

According to
https://docs.python.org/3.8/library/xml.etree.elementtree.html#xml.etree.ElementTree.Element
xml.etree.ElementTree.Element.getiterator is "deprecated since version 3.2, will
be removed in version 3.9"

I'll prepare a patch with fix.

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7ZLSYACgkQviIJHj72
InVsfg//YHgz3Fe2J9gP28z4+M7p+Se/V61wUZ30Ss/aA4qFl6Xd3XgAHpSS5vI3
P4TIo2wdN7sujF5INwu2Etf1/nSOluQ/h/85E+l/ZxSqIMc2p/FrPiOTUjxrUq90
MAkLRPKrrh7ma7R70JQERHLq2mMqyCjdqxddVgVBcZrH2Qpyyfgmwp++RJGBBCCJ
Of1UcpKNq6M1T2mDV9FHBdztDzs43apdsUYmHwstAh6PXm6BrTrQBJgiuIc3pDv+
hb9aBdIT5fdIL6M/pInHgthWICrMeLZJDQRoPjQWn6K4Aswr6gWXxVA79VfWddp7
HQjbBopWKX3hTezz6RbwLpUVAl97bpxnDfXUsFZDU9A7lDh566bmFsbFJdzvRXRB
7DJWz5Ieg85eh97q/tUktoidB5DWXD7e+v1lLIsZaja/2DTe8LG45pagkceFPS0x
xClOELDXCnDm2m/ibh/US/MMGOV+LP6RgZyEs9gb6m5mgxEofmj+w5+Xs9BorExH
HJnfduy8fw2mpPH+3/GNwSkzH9tPDRO6aO+9pRATPs3aB4tYLJcQSR44UWPjHPwt
m6nYD7I3XeBw7F+P16d8oNyiWdVuqiYUHgrfYH03ArqJcS1FSEpj9UJFVl785iTm
GBx/isHwYLZy4qbba+L47OFZaWKNev+p0VdLHL/2FML7HFsdXLM=
=LbqA
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

