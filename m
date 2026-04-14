Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC1391E6D
	for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188256; cv=pass; b=DpV0drwdP14IjxEgj78lWdzswdhqM6MFETxAimq8I/z9TtgcqMKUnU/bTlg0FUX1XIn9DJaQT9jeWfdeat0sUXZg22lnU0UBgSj+I9cYpYW9Ye78NBdPqSMNTQxFBybxS5Qw/oUNIKwmT7A3HRO9li1bqrQ28alZZ0HITmoGIno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188256; c=relaxed/simple;
	bh=L/iLJoUPzXnUKYg3AkJYZUAkAOeAIS5YgReH9pkXzo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxPeijOF0+PmLZhTkCEI0ZB0gMDNiEieY7p/fJJh6jCk0fG9+xPkDiLYfqc9BVEU55nFWUIYYBvUYzJGc/3NyTKZYvqygTBa3jZY/a2MYriHhlXFhWV7ZLWoMnmxqkq1rANEm7Ri3dsEDymI9u8RoR5kWWG0rQvpCuCOppb1utM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4cE9OU6; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4cE9OU6"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f0fc82c76so1840200b3a.0
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 10:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776188254; cv=none;
        d=google.com; s=arc-20240605;
        b=Q9s8pDHVIgNshzmwDhltoes6HEJgWwkZ5IbmeTkFhHvHfqVPjENwgC4/O5d+kD3vtR
         uWxGaC1j9WSO8t2xj3FDAYtRVUVmq4jsQNqRAU/F34hnuKPCINeT8a6ZWGOH5dYp56M+
         SfWh8i/2eWZNLXCyY6Qd22ovJwJOmqtbGOA243uEl+NqoEjBGyvW9LUwcaYTNr72dcP4
         6OySF/dTirp3Fdf02UIgRyrtWWo4ltV1lxsdswfxc+HEExrHRaakapBNxpsEtg6300GD
         QDF1FU4ti0MpfEhrTjsVpU6fZlMLCuycL3xJjJZYVl+UCxeLK7UD64sSOWiK4gXnqLYW
         pQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jedA/J9gQYh6sjiZt3rSQdcFXUKN8ohuuDRGoFPEAAA=;
        fh=U4XhNnaIzdNBbONU0a45k3j8iy8yB6XZryZ6zvP2xgI=;
        b=ChrQxH/pc4OPRBwVeS4DNufKXZ2JKQoZ/oZXmfDJgNfBVmlML0iaHh5scTxeNVT+CD
         DO7Qi/5gN4+7BJ7fVp3jKu7u7cA39wo3LyFQANouJxQvsX1NZCSHlTBmqeidJdZvOz4u
         XSlVRfZzzDSq+/0KxYb20cT5Q5XyyyuytxVshdsCMYZHXnFZzMQNQjXprPfdwPrbMgyk
         yP6qsuHYQnV7I07DsVRVgnBB0VxoUZzVCYsWTSFgbAJJHYuq/Cx3AcoTZErECn3JnZoH
         YeOlzAObsVeD85xE79GETbHJBr99iBtmHRn6IwM9IMmEKSLEYUwyyAgfjh9PgLlx9eDX
         oELA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776188254; x=1776793054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jedA/J9gQYh6sjiZt3rSQdcFXUKN8ohuuDRGoFPEAAA=;
        b=L4cE9OU6ua8fQOKg14lzefLzQM+awvS+xJfhIgfPSQ0TO6tc2iGmH8DwT0ATV4i4w3
         kgG19OndUdqvZ3Xzkjhod0kmxfBxoAJukLRMNyGbfKGQF8Zyr0Q7uTVHIO2FDY6S6g9x
         7jv65NjYR++n0wL2T8CAuhyafTx1fuedD5FBxlSDet89JhSfr2rIXzekd/AGq61wIsJ4
         mRXU5NsJXi2gaRU7gznwZs7OGncZBczSgUWPgIc/kLOfaTRzqZRcC8wFqgBUvKZ7yK1M
         01U5Ir5X9GoAvwInTT+I3Kx/VGRp0Ws40Up1j2A5tcbQDj0c/kqPGk8eVq2t9wOZjF6M
         4QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188254; x=1776793054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jedA/J9gQYh6sjiZt3rSQdcFXUKN8ohuuDRGoFPEAAA=;
        b=mC4NTsZ+PtEi2Gce5bVaiBZpHVxdmSqZVy9PR2g1M2+Mkm4d9S5eGgVIPAgrESaYuu
         teG0Xhh561IoS0lg5b4MmgY3WrziNib4NW8rMPNAlDTgBZ3jUzQgWVUYuoZY4Snd06YY
         9q8bdM8Ze83f843EXPMpLtjdU6hmw9UPExgeuqJA6FnybLjOL1CPmPipHbSfXXEEo7Ql
         QiZNPjiHXBuPaHulSHCMeAIMftrdwkAcCHg67hfHPQJCYEIxRiFQX2C1A26b6SIwOxYG
         AJSHYOSVsBN6hWzSndFu7SWVe/XUk8UekA3N+K2GVxvDZak9EziR5jzrvZHiXP9Ugs/+
         XwrA==
X-Gm-Message-State: AOJu0YwTCXIhsuNSdOt7mUly3iAus/W8wjHyGPydqXiK8rSn3jf1rfN1
	If+7r9A1ztMqj8KuXo3SyjzIWqZZXmbLRzw40MbHMA4RmE3d0yf6k0bXVKA0rZJlRG3HRvAKBso
	20XvAPm1PsXupnA0Wy/l24KLUR5JvsfT9T+c5
X-Gm-Gg: AeBDievVlVoQ1qDUtNjJZLAKP8XR9Fi+n9VriYFnhmbkoDa6N6WKp12oJVTbkPH//vj
	30kRoenpR3wvkpWMdWp/ks6T7xzuew006z5+G/8R9C54QvdmqaE5GqekWgxvAvB1XF4Aa3Kmbu2
	NSC0N/rKICU/26LoNOLkXsDNOgKbdNiuVd2GUC81RMHTH9S9zAU5ECj07uTZeOeJq6iPpUE6ux2
	yEQPgr47EiWvgVIztocw7r6JLACUzpKK4ypaql7PMaVeTl+u33XcCmkrpl/jO2+4IOX9nZPK0Zt
	r1TyjJI=
X-Received: by 2002:a05:6a00:2d11:b0:82f:4ddb:7602 with SMTP id
 d2e1a72fcca58-82f4ddba712mr5802955b3a.54.1776188254272; Tue, 14 Apr 2026
 10:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330193757.5702-1-danieldurning.work@gmail.com>
In-Reply-To: <20260330193757.5702-1-danieldurning.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 14 Apr 2026 13:37:23 -0400
X-Gm-Features: AQROBzCGFCanwpO4nvvQ_oZ70gU4BSODkPZhFuD9jzS0a_5JMsS3jhiiCHejInY
Message-ID: <CAEjxPJ4dXYtUSfX5v4MBywT7XZS33Ar-C4X5nGvnTkLss_ncXQ@mail.gmail.com>
Subject: Re: [RFC PATCH testsuite] Add tests for namespaces
To: danieldurning.work@gmail.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:38=E2=80=AFPM <danieldurning.work@gmail.com> wrot=
e:
>
> From: Daniel Durning <danieldurning.work@gmail.com>
>
> Add tests for namespaces, exercising the namespace
> create and setns permissions. Requires the correspending
> kernel patch, and the addition of a new set of classes
> and permissions to the policy.
>
> The base policy can be updated to support the new class
> as follows:
>
> Namespace classes: cgroup_namespace, ipc_namespace,
> mnt_namespace, net_namespace, pid_namespace,
> time_namespace, user_namespace, uts_namespace
>
> Permissions: create, setns
>
> - sudo semodule -c -E base
> - sudo vi base.cil
>
> Add a common class "namespace" with all listed perms.
> Add each class to the classorder list.
> Add each class with empty permissions. Below each add
> a class common declaration using "namespace".
> Add allow rules for the unconfined_domain_type and
> init_t with the listed permissions for
> each class to prevent anything from breaking.

It would be better to show the actual policy lines that need to be
added or modified in base.cil even if you don't provide a script for
doing so, e.g:
Replace the existing line:
(class user_namespace (create)) with the following new lines:
(common namespace (create setns))
(classcommon cgroup_namespace namespace)
(classcommon ipc_namespace namespace)
(classcommon mnt_namespace namespace)
(classcommon net_namespace namespace)
(classcommon pid_namespace namespace)
(classcommon time_namespace namespace)
(classcommon user_namespace namespace)
(classcommon uts_namespace namespace)
(class cgroup_namespace ())
(class ipc_namespace ())
(class mnt_namespace ())
(class net_namespace ())
(class pid_namespace ())
(class time_namespace ())
(class user_namespace ())
(class uts_namespace ())

Replace the existing (classorder (...) line with one that adds the new
classes at the end:
(classorder (... user_namespace cgroup_namespace ipc_namespace
mnt_namespace net_namespace pid_namespace time_namespace uts_namespace
))

NB I did not add any allow rules to base.cil itself because I wanted
to see exactly which permissions were triggered by the testsuite, see
below.

> - sudo vi /usr/share/selinux/devel/include/support/all_perms.spt
>
> Define "all_namespace_perms" with the listed permissions.
> Add each class to the all_kernel_class_perms list with
> all_namespace_perms for each.

Similarly, I would include the actual lines you added or changed, e.g.:
Add the following line at the top:
define(`all_namespace_perms', `{ create setns }')

Replace the 'class user_namespace all_user_namespace_perms;' line with
the following lines within the all_kernel_class_perms definition:
        class cgroup_namespace all_namespace_perms;
        class ipc_namespace all_namespace_perms;
        class mnt_namespace all_namespace_perms;
        class net_namespace all_namespace_perms;
        class pid_namespace all_namespace_perms;
        class time_namespace all_namespace_perms;
        class user_namespace all_namespace_perms;
        class uts_namespace all_namespace_perms;

> diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> index f60b0c8..a1c9701 100644
> --- a/policy/test_filesystem.te
> +++ b/policy/test_filesystem.te
> @@ -397,3 +397,26 @@ allow test_filesystem_no_mount_t dosfs_t:filesystem =
{ associate };
>  allow test_filesystem_no_remount_t dosfs_t:filesystem { associate };
>  allow test_filesystem_no_unmount_t dosfs_t:filesystem { associate };
>  allow test_move_mount_no_mounton_t dosfs_t:filesystem { associate };
> +
> +#
> +####### Allow mount namespace creation #################
> +#
> +allow_mntns_create(test_filesystem_fscontext_t)
> +allow_mntns_create(test_filesystem_no_quotaget_t)
> +allow_mntns_create(test_filesystem_no_quotamod_t)
> +allow_mntns_create(test_move_mount_no_mounton_t)
> +allow_mntns_create(test_filesystem_context_t)
> +allow_mntns_create(test_filesystem_inode_relabel_no_associate_t)
> +allow_mntns_create(test_filesystem_inode_setxattr_no_associate_t)
> +allow_mntns_create(test_filesystem_may_create_no_associate_t)
> +allow_mntns_create(test_filesystem_no_getattr_t)
> +allow_mntns_create(test_filesystem_no_inode_no_relabelfrom_t)
> +allow_mntns_create(test_filesystem_no_mount_t)
> +allow_mntns_create(test_filesystem_no_remount_t)
> +allow_mntns_create(test_filesystem_no_unmount_t)
> +allow_mntns_create(test_filesystem_no_watch_mount_t)
> +allow_mntns_create(test_filesystem_no_watch_sb_t)
> +allow_mntns_create(test_filesystem_no_watch_t)
> +allow_mntns_create(test_filesystem_sb_relabel_no_relabelfrom_t)
> +allow_mntns_create(test_filesystem_sb_relabel_no_relabelto_t)
> +allow_mntns_create(test_filesystem_t)

I needed this rule as well to silence an avc: denied message:
+allow_mntns_create(test_file_no_quotaon_t)

> diff --git a/policy/test_global.te b/policy/test_global.te
> index cb7d9c2..1978664 100644
> --- a/policy/test_global.te
> +++ b/policy/test_global.te
> @@ -192,3 +192,11 @@ ifdef(`lockdown_defined', `allow $1 self:lockdown co=
nfidentiality;')
>  define(`allow_userns_create',
>  ifdef(`user_namespace_defined', `allow $1 self:user_namespace create;')
>  )
> +
> +define(`allow_mntns_create',
> +ifdef(`mnt_namespace_defined', `allow $1 self:mnt_namespace create;')
> +)
> +
> +define(`allow_pidns_create',
> +ifdef(`pid_namespace_defined', `allow $1 self:pid_namespace create;')
> +)

Since I didn't add any allow rules to base.cil, I needed the following
rules added here:
+allow_mntns_create(testsuite_caller_domain)
+allow_pidns_create(testsuite_caller_domain)

testsuite_caller_domain expands to the calling domain for the test
scripts, typically unconfined_t or sysadm_t.

> diff --git a/tests/namespace/setns_test.c b/tests/namespace/setns_test.c
> new file mode 100644
> index 0000000..8c61b28
> --- /dev/null
> +++ b/tests/namespace/setns_test.c
> +int change_ctx(char* type)
> +{
> +       const char *context_s;
> +       char *context_tmp;
> +       context_t context;
> +       int ret;
> +
> +       ret =3D getcon(&context_tmp);
> +       if (ret < 0) {
> +               perror("getcon");
> +               return ret;
> +       }
> +
> +       context =3D context_new(context_tmp);
> +       if (!context) {
> +               ret =3D -1;
> +               perror("context_new");
> +               return ret;
> +       }
> +
> +       ret =3D context_type_set(context, type);
> +       if (ret) {
> +               perror("context_type_set");
> +               return ret;
> +       }
> +
> +       freecon(context_tmp);
> +       context_s =3D context_str(context);
> +       if (!context_s) {
> +               ret =3D -1;
> +               perror("context_type_set");
> +               return ret;
> +       }
> +
> +       ret =3D setcon(context_s);
> +       if (ret < 0) {
> +               perror("setcon");
> +               return ret;
> +       }

Missing return 0; here.
