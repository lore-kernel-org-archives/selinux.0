Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F752D5C8B
	for <selinux@vger.kernel.org>; Wed, 25 Jun 2025 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750873784; cv=none; b=gdnDdM3S4KZduTQMtyUsSkQmrCjxyDqKPrBflFWky+lMRnkI/wDYWMnB+sznyWqig3+cRDHWKEOsB+0w0vfszJLkl2gRqMOBnPK9HTdvPHxY2tp3wMt+De9taDuszi1Ul37NOxvEV3psY/MsnWMO5DLfVXoXon5fwvefm8TDcAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750873784; c=relaxed/simple;
	bh=6VFOAE6N/t96aGlmCJK3p+TMUkJA0aw8XyHcM2NW/8o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UTRfb3tW3HSF55dcwxUETNEU98q4i2GJIzbmXhOebEe7kvxq6Gz30FlqZxscsAsdUbbaa+PTRINdqMAUWMtGTlTXZLG0YJJRt7C393yWfvMiKt3QKKFq1ooXAV3FB2Rm7PXTC62VmOuA0Uq4VVb2xWb3L1vDlnyLxkJpb6rINr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J0nWyU1G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0nWyU1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750873781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jxc30St764kIqmR/5UwCSVVOqQIhnV0g8uL23A4vKi0=;
	b=J0nWyU1G5sk6C0jfF9tq5jAglmMg9vUTlQg2h2npIFtbwUDtosKA6h9mNM9u74S1l3Mv16
	uOztlne5YES+HoZW5Smea+OI7nMS5jtLAx/LpSkotQZPdR6wDUAq6+qF19RD6L8gtvTroG
	5nO3K4YC9GBsLfIJsnoYXwW74b07Dp0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-i_MLFmt0NcqODwtd2lNLvw-1; Wed,
 25 Jun 2025 13:49:39 -0400
X-MC-Unique: i_MLFmt0NcqODwtd2lNLvw-1
X-Mimecast-MFC-AGG-ID: i_MLFmt0NcqODwtd2lNLvw_1750873778
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 965111801210
	for <selinux@vger.kernel.org>; Wed, 25 Jun 2025 17:49:38 +0000 (UTC)
Received: from localhost (unknown [10.45.224.186])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2445230001A1
	for <selinux@vger.kernel.org>; Wed, 25 Jun 2025 17:49:37 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.9-rc2 release
Date: Wed, 25 Jun 2025 19:49:36 +0200
Message-ID: <87wm8ziudr.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello!

The 3.9-rc2 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/releases/tag/3.9-rc2
https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me
know.

User-visible changes
--------------------

* libsepol: Add new 'netif_wildcard' policy capability

* checkpolicy: Add support for wildcard netifcon names

* libsepol: Allow multiple policycap statements

* libsepol: Support genfs_seclabel_wildcard

* Replace all links to selinuxproject.org

* Bug fixes

Shortlog of the changes since 3.9-rc1 release
---------------------------------------------
Christian G=C3=B6ttsche (5):
      libsepol: update sort order for netifcon definitions
      libsepol: add netif_wildcard polcap
      checkpolicy: add support for wildcard netifcon names
      secilc/test: add test for wildcard netifcon statement
      libsepol/cil: reject wildcard only network interface names

Inseob Kim (2):
      libsepol: Allow multiple policycap statements
      libsepol: Support genfs_seclabel_wildcard

James Carter (1):
      libsemanage: Ignore missing field initializers in swig generated code

Petr Lautrbach (1):
      Update VERSIONs to 3.9-rc2 for release.

Stephen Smalley (1):
      userspace: replace all links to selinuxproject.org

