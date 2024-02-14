Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D860EF9
	for <selinux@vger.kernel.org>; Wed, 14 Feb 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930761; cv=none; b=r4lBoW/lcNMH2AeCR7wNh2U6qVTnk0kQ5gkybsPV0rg1tsv6psYQHiDUB8NE3JKMgFUGd/ecrguLX1jFhJbvJqVMtrek44MjL9KQfmARFCwcyWY8AcWy5aDzcyN7fspJsrlEWFTSC54vml0ZUOZHk5NkXpLw8YHYIs8tNyC/sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930761; c=relaxed/simple;
	bh=Gh7oxSHsP82j/NtR9dieUvefvWia2hcgh7qbSU1EVI4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SG2KXxo9EDpMHoufSwFsBpn8TNRIU7GWTWOlyDBxXkZ4czMyONggjNZ9AaoaibIaNRoPil3X/ZbZlfvaToEe9KFheaIGLGkeibFIxsTe3AtXSzVPkYOzs+zD5cFQNgJXWD7LFeFWenafq6JH3yzwlpO9pYFOgkIZvnOPN8K1u4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cs0zd7GV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cs0zd7GV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707930758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8P/D+2idC4JKjrMNRwK5pEt+Jxif6mDXe9XrUcX20D8=;
	b=Cs0zd7GV0TSo6yLLIl1rjf2sL4F8z0F1lBiMjTPaCTFpHLl+ld07vWWantG9J68LDC2ww9
	x3WZ0FW+I0s/GcQa8ZR44dJK7gSnY4Uh+7Yiuy/kW6c9amAViX17MJSYOhs0Nf+xrsYM8S
	ZYk1CZKKbiiXWKzi/N1OGYc/U+0+8J4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-ZLkwbLugM06GpmEC1wLfOA-1; Wed, 14 Feb 2024 12:12:36 -0500
X-MC-Unique: ZLkwbLugM06GpmEC1wLfOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A24D185A58A
	for <selinux@vger.kernel.org>; Wed, 14 Feb 2024 17:12:36 +0000 (UTC)
Received: from localhost (unknown [10.45.226.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 619188CED;
	Wed, 14 Feb 2024 17:12:36 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] python/semanage: Do not sort local fcontext definitions
In-Reply-To: <20240207150003.174701-1-vmojzis@redhat.com>
References: <20240207150003.174701-1-vmojzis@redhat.com>
Date: Wed, 14 Feb 2024 18:12:35 +0100
Message-ID: <87zfw3dl6k.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Vit Mojzis <vmojzis@redhat.com> writes:

> Entries in file_contexts.local are processed from the most recent one to
> the oldest, with first match being used. Therefore it is important to
> preserve their order when listing (semanage fcontext -lC) and exporting
> (semanage export).
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>

I think it's good approach. I just hit the following ui issue:


[root@localhost ~]# semanage fcontext -a -t httpd_sys_content_t '/opt/selinux_testing(/.*)?'
[root@localhost ~]# semanage fcontext -a -t httpd_sys_content_rw_t '/opt/selinux_testing/webroot(/.*)?'
[root@localhost ~]# semanage fcontext -a -t httpd_log_t '/opt/selinux_testing/logs(/.*)?'
[root@localhost ~]# semanage fcontext -l -C
SELinux fcontext                                   type               Context

/opt/selinux_testing(/.*)?                         all files          system_u:object_r:httpd_sys_content_t:s0 
/opt/selinux_testing/webroot(/.*)?                 all files          system_u:object_r:httpd_sys_rw_content_t:s0 
/opt/selinux_testing/logs(/.*)?                    all files          system_u:object_r:httpd_log_t:s0

[root@localhost ~]# matchpathcon /opt/selinux_testing/logs /opt/selinux_testing/webroot/
/opt/selinux_testing/logs       system_u:object_r:httpd_log_t:s0
/opt/selinux_testing/webroot    system_u:object_r:httpd_sys_rw_content_t:s0


If it's first match, I'd expect that both would be matched with
'/opt/selinux_testing(/.*)?' -> httpd_sys_content_t



[root@localhost ~]# semanage fcontext -d '/opt/selinux_testing(/.*)?'
[root@localhost ~]# semanage fcontext -a -t httpd_sys_content_t '/opt/selinux_testing(/.*)?'
[root@localhost ~]# semanage fcontext -l -C
SELinux fcontext                                   type               Context

/opt/selinux_testing/webroot(/.*)?                 all files          system_u:object_r:httpd_sys_rw_content_t:s0 
/opt/selinux_testing/logs(/.*)?                    all files          system_u:object_r:httpd_log_t:s0 
/opt/selinux_testing(/.*)?                         all files          system_u:object_r:httpd_sys_content_t:s0

[root@localhost ~]# matchpathcon /opt/selinux_testing/logs /opt/selinux_testing/webroot/
/opt/selinux_testing/logs       system_u:object_r:httpd_sys_content_t:s0
/opt/selinux_testing/webroot    system_u:object_r:httpd_sys_content_t:s0

And here it looks like it should match webroot, resp logs.


So it's first match but from bottom to top. It kind of make sense as the
last added item is at bottom. OTOH people generally reads from top to
bottom.

What do you think?





> ---
> Not sure if this is the best solution since the local file context
> customizations are still sorted in the output of "semanage fcontext -l".
> Adding a new section for "Local file context changes" would make it
> clear that such changes are treated differently, but it would make it
> harder to find context definitions affecting specific path.
> The most important part of this patch is the change to "customized"
> since that stops "semanage export | semanage import" from reordering the
> local customizations.
>
> Note: The order of dictionary.keys() is only guaranteed in python 3.6+.
>
> Note2: The change to fcontextPage can only be seen when the user
> disables ordering by "File specification" column, which is enabled by
> defalut.
>
>  gui/fcontextPage.py         | 6 +++++-
>  python/semanage/seobject.py | 9 +++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
> index 767664f2..c88df580 100644
> --- a/gui/fcontextPage.py
> +++ b/gui/fcontextPage.py
> @@ -133,7 +133,11 @@ class fcontextPage(semanagePage):
>          self.fcontext = seobject.fcontextRecords()
>          self.store.clear()
>          fcon_dict = self.fcontext.get_all(self.local)
> -        for k in sorted(fcon_dict.keys()):
> +        if self.local:
> +            fkeys = fcon_dict.keys()
> +        else:
> +            fkeys = sorted(fcon_dict.keys())
> +        for k in fkeys:
>              if not self.match(fcon_dict, k, filter):
>                  continue
>              iter = self.store.append()
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index dfb15b1d..25ec4315 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -2735,7 +2735,7 @@ class fcontextRecords(semanageRecords):
>      def customized(self):
>          l = []
>          fcon_dict = self.get_all(True)
> -        for k in sorted(fcon_dict.keys()):
> +        for k in fcon_dict.keys():
>              if fcon_dict[k]:
>                  if fcon_dict[k][3]:
>                      l.append("-a -f %s -t %s -r '%s' '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], fcon_dict[k][3], k[0]))
> @@ -2752,7 +2752,12 @@ class fcontextRecords(semanageRecords):
>          if len(fcon_dict) != 0:
>              if heading:
>                  print("%-50s %-18s %s\n" % (_("SELinux fcontext"), _("type"), _("Context")))
> -            for k in sorted(fcon_dict.keys()):
> +            # do not sort local customizations since they are evaluated based on the order they where added in
> +            if locallist:
> +                fkeys = fcon_dict.keys()
> +            else:
> +                fkeys = sorted(fcon_dict.keys())
> +            for k in fkeys:
>                  if fcon_dict[k]:
>                      if is_mls_enabled:
>                          print("%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], fcon_dict[k][0], fcon_dict[k][1], fcon_dict[k][2], translate(fcon_dict[k][3], False)))
> -- 
> 2.43.0

