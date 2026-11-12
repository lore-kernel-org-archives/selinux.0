Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495932;
	b=vCBPKH/gd+q31NOObjZOupog0qLpOv4BQhgNoJQxv7oa+3PR9XFfsudvdhTlP47r+ewh
	 8W5AsQLmhk6NRfX6wr04hrE7RJo0SIveZDGjgL62S9dedLF7Eq6MxVsW6pZms7Ym4dx83
	 MRdBCvQUBPCmOLPGGbEwqlLUUmeKOLZ+vOh5/bpfw/2RaM67B2iV7Mk+f9zD4BU35x18T
	 T6wfOdAIjXvOl+o/JLZtgjO5/NlM65ke3LHmBbmM/sF613FXGqejQfw//WiUI6WOEPVpl
	 yUEke42vjwEcQ4CkXh3mncNVSuolyyHOjTWUUu0S5TlovS+D+Y0ps7Em5JdLgUpCP3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495932;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=JyOGHjCYrABQdLyFqu/FrN2pVLcM+hfpKrY0rWa29uQ=;
	b=X/U+BLSqUkvZtaQLy3IEpy2xrNoJjQ3K0H1ZojHEp+eW9BuVzePulrs89QNtrbBg4g71
	 bpC4uXrK4Tn7ozEShUDnEQMnqrrOu1BfyeOBcrObJ7CAZ45hKb8TLqduOEnT49eJss6MP
	 Yn5MQAsbu1uRQ5IpUkp/WA3bnZwrCX0Yudxtj1e0L5YWYZ7wBxOCw39duSS+UfR/i5gYU
	 CNKeMMiGYjpgGx98U3IiD2xd7F6Ez+yOns5gfYJQDJLq8OHsXr2ttV90bPsN+ZwD+FOth
	 1m2S72yBqZGiAKKovL36p0CVVdXxFKTkDlId+oXMkH00bXhqtYmiZMrP8U6BtuUHeTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U7QbdJ3f;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C3606A31C
	for <selinux@vger.kernel.org>; Thu, 12 Nov 2026 15:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B1C3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U7QbdJ3f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794495931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JyOGHjCYrABQdLyFqu/FrN2pVLcM+hfpKrY0rWa29uQ=;
	b=U7QbdJ3fpLC6upkE0QQ9xTiraaHBFVTkk8XPXcoduvcnNz7fX34KAXmhjbWj1/303t1uMx
	Y+XEFzZ00rfTYMoZnKaQ7yeUT8JjQBvy1yOK0dNL9RetGXGNAWjHpWwCHFBcrYC4JibNE1
	1Eo0VQYC50WsNvQFv7E0eorp6ZrY+is=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-bHf3ziSoOs-QrIWc0iapSw-1; Thu,
 12 Nov 2026 10:05:26 -0500
X-MC-Unique: bHf3ziSoOs-QrIWc0iapSw-1
X-Mimecast-MFC-AGG-ID: bHf3ziSoOs-QrIWc0iapSw_1794495926
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E103B1800627
	for <selinux@vger.kernel.org>; Thu, 12 Nov 2026 15:05:25 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1365E1956089
	for <selinux@vger.kernel.org>; Thu, 12 Nov 2026 15:05:24 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.12-rc2 release
Date: Thu, 12 Nov 2026 16:05:21 +0100
Message-ID: <pjdo6bu9jke.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello!

The 3.12-rc2 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/releases/tag/3.12-rc2
https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me
know and I'll update the release notes.

RELEASE 3.12-rc2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

User-visible changes since 3.12-rc1
-----------------------------------

- Bug fixes

Shortlog of the changes since 3.12-rc1 pre-release
--------------------------------------------------

Asif Nadaf (2):
      libsepol: fix permission value collision when linking an undeclared c=
lass
      semanage: raise a clean error on unterminated quote in import data

Christian G=C3=B6ttsche (26):
      libselinux/audit2why: free boolean names returned by check_booleans()
      libselinux/audit2why: check CPython allocations in analyze()
      libselinux/audit2why: do not return a value with a pending exception
      libselinux/audit2why: use public PyUnicode_AsUTF8 and Py_ssize_t list=
 size
      libselinux/audit2why: free reason_buf on a TE denial in audit2why ana=
lyze()
      libselinux: correct realpath_not_final() buffer size documentation
      libsepol: expand every class of a type rule after a duplicate
      checkpolicy: reject self as a type alias name
      libsepol: skip MLS alias slots when writing kernel policies as CIL
      checkpolicy: order IPv4 node contexts by network-order mask
      libsepol: reject conflicting type aliases when linking
      libsepol/cil: reject over-long ibendportcon device names
      checkpolicy: accept a class listed twice in a constraint
      libsepol: declare the cil_gen_require user attribute in converted bas=
es
      libsepol/cil: verify the contexts of sidcontext statements
      libsepol/cil: name anonymous ranges in context verification errors
      libsepol/cil: reject ibpkeycon subnet prefixes with low-order bits
      policycoreutils/hll/pp: report output write failures
      policycoreutils/hll/pp: open the output after reading the input
      libsepol: convert user statements in optional blocks with their roles
      libsepol/cil: name the members of expanded attributes in constraints
      python/semanage: fix permissive add with bytes module bindings
      libsepol: keep the uncompressed filename transition format for Xen
      libselinux: link the Python bindings with -fPIC
      libsemanage: make the migration import diagnostic distribution-neutral
      libsepol: avoid quadratic removal of redundant conditional rules

Petr Lautrbach (1):
      Update VERSIONs to 3.12-rc2 for release.

Stephen Smalley (9):
      python/semanage: fix test-permissive-store.py when run by CI
      python/semanage: replace removed unittest.makeSuite in test driver
      python/semanage: use a temporary file in test_input_output
      libsemanage: reject missing scalar configuration arguments
      libsemanage: initialize Python module buffers before argument convers=
ion
      libsepol: validate cached boolean IDs without limiting expression size
      libselinux: apply requested level to failsafe contexts
      libsemanage: canonicalize NSS homes before deriving their parent
      libsepol: check all declaring blocks when enabling types

