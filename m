Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB131E9900
	for <selinux@vger.kernel.org>; Mon, 20 Jan 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393242; cv=none; b=GE/R5+T3lPwFqoFf03nyZ9G3q6UpTBIjqp51PD1x+u2Ql+DUNYWYs1UNvQGu8XKkk5HDDlDnZq8ejme5iqQQgqfqkUtA1wgN/JLpV5e6939TFljgHdPT/mskozkeXgngXwjRQABYPmTNihFwRPNPAIlvYgtJ4QqacpjLAGYIniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393242; c=relaxed/simple;
	bh=KZbcevn0mYhUcW9stWOLeicf/yoDjmdBZsO6lWv128A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G3CnyegcFsVOFwi8YKnzzJgJEU+z/mJ9IrmISOIr9Yf261PxoeNysQYoyvO7w52BxYODG/PyrEW5TVzoyDFI2ImblzsooaXcr36Xwpbfh8FwFblmZxFo3yJ6G/aFVcx4Tui2ekEWp3zyROX50qwj2/wsB3iuesAA70v/jbq5bpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MURuMsRD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MURuMsRD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737393239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=oi7Eftuno8UNsucBaEbaWzds5maU+RFzuYGIcD90Cps=;
	b=MURuMsRD1230lBRvf/md+SWDWOA7EQtxq+/IfcuXv297CsuDVWoSwta6apS/kbojPVMQJw
	qLoa29QFxeEOXIQI1hVyDLodEt6hsk2qpShcGJ8cFynL2TwYIFAhkOphdLpKHmrfTWGXja
	jExlRM2nmCKIp5CofMMSlvtH0l2lMMo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-8CFcciCTNTudYzmh9trXrA-1; Mon,
 20 Jan 2025 12:13:58 -0500
X-MC-Unique: 8CFcciCTNTudYzmh9trXrA-1
X-Mimecast-MFC-AGG-ID: 8CFcciCTNTudYzmh9trXrA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FB0919560AB
	for <selinux@vger.kernel.org>; Mon, 20 Jan 2025 17:13:57 +0000 (UTC)
Received: from localhost (unknown [10.45.224.62])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F295819560A3
	for <selinux@vger.kernel.org>; Mon, 20 Jan 2025 17:13:56 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: Possible regression by commit d96f27bf7cb9 ("libsemanage: Preserve
 file context and ownership in policy store")
Date: Mon, 20 Jan 2025 18:13:55 +0100
Message-ID: <878qr54dd8.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi,

When `selinux_restorecon()` is called first time, it creates a static
`fc_sehandle`. This semanage store handle is used later in `selabel_` functions and
left initialized to be used on the next call `selinux_restorecon()`. It
probably help with multiple sequential runs of `selinux_restorecon()`.

But since commit d96f27bf7cb9 ("libsemanage: Preserve file context and
ownership in policy store"), `selinux_restorecon` is also run internally
when policy store is changed by libsemanage. It means that if a user
tries to change file contexts and then relabel affected files,
`selinux_restorecon` uses semanage handle created before policy change
and therefore with old data, see the code [1]:


[root@localhost ~]# mkdir -p /data/test/subtest
[root@localhost ~]# gcc libsemanage-add-fcontext.c -lsemanage -lselinux
[root@localhost ~]# ./a.out 
Relabeled /data/test from unconfined_u:object_r:default_t:s0 to system_u:object_r:default_t:s0
Relabeled /data/test/subtest from unconfined_u:object_r:default_t:s0 to system_u:object_r:default_t:s0


Two ideas how to solve it I have:

- destroy fc_sehandle at the end selinux_restorecon() if the handle was
initialized there - could this affect the performance?

- document in man page this issue and suggest users to use

sehandle = selinux_restorecon_default_handle()
selinux_restorecon_set_sehandle(sehandle)

before any libsemanage store operation


I'm looking for any reasonable solution or ideas.


[1]
#include <selinux/restorecon.h>
#include <semanage/context_record.h>
#include <semanage/fcontext_record.h>
#include <semanage/fcontexts_local.h>
#include <semanage/handle.h>
#include <semanage/semanage.h>
#include <stdio.h>

int main(const int argc, const char **argv) {
  semanage_handle_t *sh = NULL;
  semanage_fcontext_t *fcontext;
  semanage_context_t *con;
  semanage_fcontext_key_t *k;

  int exist = 0;
  sh = semanage_handle_create();
  if (sh == NULL) {
    perror("Can't create semanage handle\n");
    return -1;
  }
  semanage_select_store(sh, "targeted", SEMANAGE_CON_DIRECT);
  if (semanage_is_managed(sh) < 0) {
    perror("Semanage store can't be accessed\n");
    return -1;
  }
    
  if (semanage_access_check(sh) < 0) {
    perror("Semanage access check failed\n");
    return -1;
  }
  if (semanage_connect(sh) < 0) {
    perror("Semanage connect failed\n");
    return -1;
  }
  if (semanage_begin_transaction(sh) < 0) {
    return -1;
  }

  semanage_fcontext_key_t *key_ptr;
  semanage_fcontext_key_create(sh, "/data/test(/.*)?", 0, &key_ptr);

  semanage_fcontext_t *fcontext_ptr;
  semanage_fcontext_create(sh, &fcontext_ptr);

  semanage_context_t *con_ptr;
  semanage_context_from_string(sh, "system_u:object_r:tmp_t:s0", &con_ptr);
  semanage_fcontext_set_expr(sh, fcontext_ptr, "/data/test(/.*)?");
  semanage_fcontext_set_type(fcontext_ptr, 0);
  semanage_fcontext_set_con(sh, fcontext_ptr, con_ptr);

  semanage_fcontext_modify_local(sh, key_ptr, fcontext_ptr);
  if (semanage_commit(sh) < 0) {
    perror("Semanage commit failed\n");
    return -1;
  }
  if (semanage_disconnect(sh) < 0) {
    perror("Semanage disconnect failed\n");
    return -1;
  }

  selinux_restorecon("/data/test", SELINUX_RESTORECON_RECURSE | SELINUX_RESTORECON_VERBOSE | SELINUX_RESTORECON_SET_SPECFILE_CTX);
}

