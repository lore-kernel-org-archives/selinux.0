Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEA5C64E90
	for <selinux@archiver.kernel.org>; Mon, 30 Nov 2020 12:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02AE9206D8
	for <selinux@archiver.kernel.org>; Mon, 30 Nov 2020 12:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ife.onl header.i=@ife.onl header.b="nsCZQQ1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgK3MFR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Nov 2020 07:05:17 -0500
Received: from pub2.ife.onl ([108.61.167.28]:32780 "EHLO mail.ife.onl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgK3MES (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 30 Nov 2020 07:04:18 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Nov 2020 07:04:16 EST
Received: from home.home.ife.onl (unknown [IPv6:2a0a:e5c1:18c:2::2])
        by mail.ife.onl (Postfix) with ESMTPSA id 1E03E41C13
        for <selinux@vger.kernel.org>; Mon, 30 Nov 2020 11:56:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ife.onl 1E03E41C13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ife.onl; s=default;
        t=1606737389; bh=aNovztkb1OuHXzXyTcQn3DrYAOBznxIQZ4Ti4sq3JXE=;
        h=Subject:From:To:Date:From;
        b=nsCZQQ1pCVxe99AOX+VvgWVIVjyLzkjqhwRX6fki6FCdlye7v87qFN+G65UsYIMKM
         HuyWBfEJxLlBz6T10le5PPh83blSb8fkpQJvrKxK+s+IoNmfEttk9HlbXMumSS5tic
         4Lal7I23IdFCGJIRs4xBN4AWEOzuRv1wbkRjXaxs=
Message-ID: <30bf5dca94595b9807b2c79be3f2ea9db4feb0cd.camel@ife.onl>
Subject: Fix Checkmodule when Writing down to older Module Versions
From:   Matthew Ife <matthew@ife.onl>
To:     selinux@vger.kernel.org
Date:   Mon, 30 Nov 2020 11:56:27 +0000
Content-Type: multipart/mixed; boundary="=-nkiwSNCgRY+NCssqE+xT"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--=-nkiwSNCgRY+NCssqE+xT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Stumbled over this one when writing a module from F33 to EL6.

Steps to reproduce:

Try to build the following module then make a module from an older
release:

module test 1.0.0;

require {
  type default_t;
}
attribute_role new_atrole;

Build

$ checkmodule -M -m -c 12 -o test.mod test.te
$ semodule_package -o test.pp -m test.mod
$ semodule_package:  Error while reading policy module from test.mod

With fix:

$ checkmodule -o test.mod -M -m -c12 test.te 
libsepol.policydb_write: Discarding role attribute rules
$ semodule_package -o test.pp -m test.mod

Failure occurs when the current module gets written out as the scope
declaration remains intact.
semodule_package files correctly at policydb.c:3913 doing a hash table
search on a scope key that is not
in the symbol table.

This patch fixes the problem by removing the hashtable entries and
scope declarations properly prior to module write and emits a warning
to the user of the unsupported statements.

Also altered hashtab_map slightly to allow it to be used for
hashtab_remove calls in order to support the patch.

I submitted a pull request for this (there is some spacing/tabbing
issues actually so I can resent a new pull request if necessary).

https://github.com/SELinuxProject/selinux/pull/273

--=-nkiwSNCgRY+NCssqE+xT
Content-Disposition: attachment; filename="fix_downwriting_module.patch"
Content-Type: text/x-patch; name="fix_downwriting_module.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3NyYy9oYXNodGFiLmMgYi9saWJzZXBvbC9zcmMvaGFzaHRh
Yi5jCmluZGV4IDc2Yjk3N2E5Li5mZjdlZjYzZiAxMDA2NDQKLS0tIGEvbGlic2Vwb2wvc3JjL2hh
c2h0YWIuYworKysgYi9saWJzZXBvbC9zcmMvaGFzaHRhYi5jCkBAIC0yMzAsNyArMjMwLDcgQEAg
aW50IGhhc2h0YWJfbWFwKGhhc2h0YWJfdCBoLAogCiAJZm9yIChpID0gMDsgaSA8IGgtPnNpemU7
IGkrKykgewogCQljdXIgPSBoLT5odGFibGVbaV07Ci0JCXdoaWxlIChjdXJpICE9IE5VTEwpIHsK
KwkJd2hpbGUgKGN1ciAhPSBOVUxMKSB7CiAJCQluZXh0ID0gY3VyLT5uZXh0OwogCQkJcmV0ID0g
YXBwbHkoY3VyLT5rZXksIGN1ci0+ZGF0dW0sIGFyZ3MpOwogCQkJaWYgKHJldCkKZGlmZiAtLWdp
dCBhL2xpYnNlcG9sL3NyYy93cml0ZS5jIGIvbGlic2Vwb2wvc3JjL3dyaXRlLmMKaW5kZXggZGQ0
MTgzMTcuLjZhNTlhMGMzIDEwMDY0NAotLS0gYS9saWJzZXBvbC9zcmMvd3JpdGUuYworKysgYi9s
aWJzZXBvbC9zcmMvd3JpdGUuYwpAQCAtMjE3MCw3ICsyMTcwLDcgQEAgc3RhdGljIHZvaWQgc2Nv
cGVfd3JpdGVfZGVzdHJveShoYXNodGFiX2tleV90IGtleSBfX2F0dHJpYnV0ZV9fICgodW51c2Vk
KSksCiAgICAgZnJlZShjdXIpOwogfQogCi1zdGF0aWMgdm9pZCB0eXBlX2F0dHJfZmlsdGVyKGhh
c2h0YWJfa2V5X3Qga2V5LAorc3RhdGljIGludCB0eXBlX2F0dHJfZmlsdGVyKGhhc2h0YWJfa2V5
X3Qga2V5LAogICAgICAgICAgICAgICAgICBoYXNodGFiX2RhdHVtX3QgZGF0dW0sIHZvaWQgKmFy
Z3MpCiB7CiAgICAgdHlwZV9kYXR1bV90ICp0eXBkYXR1bSA9IGRhdHVtOwpAQCAtMjE4Niw5ICsy
MTg2LDExIEBAIHN0YXRpYyB2b2lkIHR5cGVfYXR0cl9maWx0ZXIoaGFzaHRhYl9rZXlfdCBrZXks
CiAgICAgICAgIGlmIChzY29wZSkgCiAgICAgICAgICAgICBoYXNodGFiX3JlbW92ZShzY29wZXRi
bCwga2V5LCBzY29wZV93cml0ZV9kZXN0cm95LCBzY29wZSk7CiAgICAgfQorCisJcmV0dXJuIDA7
CiB9CiAKLXN0YXRpYyB2b2lkIHJvbGVfYXR0cl9maWx0ZXIoaGFzaHRhYl9rZXlfdCBrZXksCitz
dGF0aWMgaW50IHJvbGVfYXR0cl9maWx0ZXIoaGFzaHRhYl9rZXlfdCBrZXksCiAgICAgICAgICAg
ICAgICAgIGhhc2h0YWJfZGF0dW1fdCBkYXR1bSwgdm9pZCAqYXJncykKIHsKICAgICByb2xlX2Rh
dHVtX3QgKnJvbGUgPSBkYXR1bTsKQEAgLTIyMDQsNiArMjIwNiw4IEBAIHN0YXRpYyB2b2lkIHJv
bGVfYXR0cl9maWx0ZXIoaGFzaHRhYl9rZXlfdCBrZXksCiAgICAgICAgIGlmIChzY29wZSkgCiAg
ICAgICAgICAgICBoYXNodGFiX3JlbW92ZShzY29wZXRibCwga2V5LCBzY29wZV93cml0ZV9kZXN0
cm95LCBzY29wZSk7CiAgICAgfQorCisJcmV0dXJuIDA7CiB9CiAKIC8qCkBAIC0yMzM3LDM2ICsy
MzQxLDM2IEBAIGludCBwb2xpY3lkYl93cml0ZShwb2xpY3lkYl90ICogcCwgc3RydWN0IHBvbGlj
eV9maWxlICpmcCkKIAkJYnVmWzBdID0gY3B1X3RvX2xlMzIocC0+c3ltdGFiW2ldLm5wcmltKTsK
IAkJYnVmWzFdID0gcC0+c3ltdGFiW2ldLnRhYmxlLT5uZWw7CiAKLSAgICAgICAgLyoKLSAgICAg
ICAgICogQSBzcGVjaWFsIGNhc2Ugd2hlbiB3cml0aW5nIHR5cGUvYXR0cmlidXRlIHN5bWJvbCB0
YWJsZS4KLSAgICAgICAgICogVGhlIGtlcm5lbCBwb2xpY3kgdmVyc2lvbiBsZXNzIHRoYW4gMjQg
ZG9lcyBub3Qgc3VwcG9ydAotICAgICAgICAgKiB0byBsb2FkIGVudHJpZXMgb2YgYXR0cmlidXRl
LCBzbyB3ZSBmaWx0ZXIgdGhlIGVudHJpZXMKLSAgICAgICAgICogZnJvbSB0aGUgdGFibGUuCi0g
ICAgICAgICAqLwotICAgICAgICBpZiAoaSA9PSBTWU1fVFlQRVMgJiYKLSAgICAgICAgICAgIHAt
PnBvbGljeXZlcnMgPCBQT0xJQ1lEQl9WRVJTSU9OX0JPVU5EQVJZICYmCi0gICAgICAgICAgICBw
LT5wb2xpY3lfdHlwZSA9PSBQT0xJQ1lfS0VSTikgewotICAgICAgICAgICAgKHZvaWQpaGFzaHRh
Yl9tYXAocC0+c3ltdGFiW2ldLnRhYmxlLCB0eXBlX2F0dHJfZmlsdGVyLCBwKTsKLSAgICAgICAg
ICAgIGlmIChidWZbMV0gIT0gcC0+c3ltdGFiW2ldLnRhYmxlLT5uZWwpCisJCS8qCisJCSogQSBz
cGVjaWFsIGNhc2Ugd2hlbiB3cml0aW5nIHR5cGUvYXR0cmlidXRlIHN5bWJvbCB0YWJsZS4KKwkJ
KiBUaGUga2VybmVsIHBvbGljeSB2ZXJzaW9uIGxlc3MgdGhhbiAyNCBkb2VzIG5vdCBzdXBwb3J0
CisJCSogdG8gbG9hZCBlbnRyaWVzIG9mIGF0dHJpYnV0ZSwgc28gd2UgZmlsdGVyIHRoZSBlbnRy
aWVzCisJCSogZnJvbSB0aGUgdGFibGUuCisJCSovCisJCWlmIChpID09IFNZTV9UWVBFUyAmJgor
CQkJcC0+cG9saWN5dmVycyA8IFBPTElDWURCX1ZFUlNJT05fQk9VTkRBUlkgJiYKKwkJCXAtPnBv
bGljeV90eXBlID09IFBPTElDWV9LRVJOKSB7CisJCQkodm9pZCloYXNodGFiX21hcChwLT5zeW10
YWJbaV0udGFibGUsIHR5cGVfYXR0cl9maWx0ZXIsIHApOworCQkJaWYgKGJ1ZlsxXSAhPSBwLT5z
eW10YWJbaV0udGFibGUtPm5lbCkKICAgICAgICAgICAgICAgICBXQVJOKGZwLT5oYW5kbGUsICJE
aXNjYXJkaW5nIHR5cGUgYXR0cmlidXRlIHJ1bGVzIik7Ci0gICAgICAgICAgICBidWZbMV0gPSBw
LT5zeW10YWJbaV0udGFibGUtPm5lbDsKLSAgICAgICAgfQotCi0gICAgICAgIC8qCi0gICAgICAg
ICAqIEFub3RoZXIgc3BlY2lhbCBjYXNlIHdoZW4gd3JpdGluZyByb2xlL2F0dHJpYnV0ZSBzeW1i
b2wKLSAgICAgICAgICogdGFibGUsIHJvbGUgYXR0cmlidXRlcyBhcmUgcmVkdW5kYW50IGZvciBw
b2xpY3kuWCwgb3IKLSAgICAgICAgICogd2hlbiB0aGUgcHAncyB2ZXJzaW9uIGlzIG5vdCBiaWcg
ZW5vdWdoLiBTbyBmaWx0ZXIgdGhlIGVudHJpZXMKLSAgICAgICAgICogZnJvbSB0aGUgdGFibGUu
Ci0gICAgICAgICAqLwotICAgICAgICBpZiAoKGkgPT0gU1lNX1JPTEVTKSAmJgotICAgICAgICAg
ICAgKChwLT5wb2xpY3lfdHlwZSA9PSBQT0xJQ1lfS0VSTikgfHwKLSAgICAgICAgICAgICAocC0+
cG9saWN5X3R5cGUgIT0gUE9MSUNZX0tFUk4gJiYKLSAgICAgICAgICAgICAgcC0+cG9saWN5dmVy
cyA8IE1PRF9QT0xJQ1lEQl9WRVJTSU9OX1JPTEVBVFRSSUIpKSkgewotICAgICAgICAgICAgKHZv
aWQpaGFzaHRhYl9tYXAocC0+c3ltdGFiW2ldLnRhYmxlLCByb2xlX2F0dHJfZmlsdGVyLCBwKTsK
KwkJCWJ1ZlsxXSA9IHAtPnN5bXRhYltpXS50YWJsZS0+bmVsOworCQl9CisKKwkvKgorCQkqIEFu
b3RoZXIgc3BlY2lhbCBjYXNlIHdoZW4gd3JpdGluZyByb2xlL2F0dHJpYnV0ZSBzeW1ib2wKKwkJ
KiB0YWJsZSwgcm9sZSBhdHRyaWJ1dGVzIGFyZSByZWR1bmRhbnQgZm9yIHBvbGljeS5YLCBvcgor
CQkqIHdoZW4gdGhlIHBwJ3MgdmVyc2lvbiBpcyBub3QgYmlnIGVub3VnaC4gU28gZmlsdGVyIHRo
ZSBlbnRyaWVzCisJCSogZnJvbSB0aGUgdGFibGUuCisJCSovCisJCWlmICgoaSA9PSBTWU1fUk9M
RVMpICYmCisJCQkoKHAtPnBvbGljeV90eXBlID09IFBPTElDWV9LRVJOKSB8fAorCQkJKHAtPnBv
bGljeV90eXBlICE9IFBPTElDWV9LRVJOICYmCisJCQlwLT5wb2xpY3l2ZXJzIDwgTU9EX1BPTElD
WURCX1ZFUlNJT05fUk9MRUFUVFJJQikpKSB7CisJCQkodm9pZCloYXNodGFiX21hcChwLT5zeW10
YWJbaV0udGFibGUsIHJvbGVfYXR0cl9maWx0ZXIsIHApOwogCQkJaWYgKGJ1ZlsxXSAhPSBwLT5z
eW10YWJbaV0udGFibGUtPm5lbCkKIAkJCQlXQVJOKGZwLT5oYW5kbGUsICJEaXNjYXJkaW5nIHJv
bGUgYXR0cmlidXRlIHJ1bGVzIik7Ci0gICAgICAgICAgICBidWZbMV0gPSBwLT5zeW10YWJbaV0u
dGFibGUtPm5lbDsKLSAgICAgICAgfQorCQkJYnVmWzFdID0gcC0+c3ltdGFiW2ldLnRhYmxlLT5u
ZWw7CisJCX0KIAogCQlidWZbMV0gPSBjcHVfdG9fbGUzMihidWZbMV0pOwogCQlpdGVtcyA9IHB1
dF9lbnRyeShidWYsIHNpemVvZih1aW50MzJfdCksIDIsIGZwKTsK


--=-nkiwSNCgRY+NCssqE+xT--

