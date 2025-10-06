Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101EB661
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774560; cv=none; b=uWnYe41wOTmvvUIqH2tlxjwUHK7xpNtZinrnNKfFua3U8JTzLNwopzooOu/Qzebm3o7PxfYPNZc70AFMPxIFNoi143evaRfDfViPqf8hYoEGrvSDoXQhLTY1fuXozdfwahfrHheM3IZUuOiGBoduUzV3Et5ALgPiAt4+JEzEpDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774560; c=relaxed/simple;
	bh=D5rG2bmwFmXM4qtT4i7pDtkcx6nRfUwINFS/p2lmR9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvCoHtQCUAtCxALVSn+HyVpdi88UjXNeUtK4ZkkxNsnz+X3vOzEQ9UZLr4JCw7a86hTlosUTYfwZmwcMvbTRgphQjrR/6S1ulmj9or+WhwHHHxwzDdZ+cD/3au5aRxNm0MmiXOiNgSaqQYQkGnB3xmP1Gg/YPFyGFqCDM8Sst6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZxEfgim; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZxEfgim"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so4263850a12.0
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 11:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759774558; x=1760379358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nn6C1bOibkgdcmlvPsNgo458S28oM8kWbQLYIMbf7w=;
        b=OZxEfgimq5KN8QC/Pze74BKxhctaV/4It3SL71cWl7h1aoo5/eJaOHx5pXR/HHlrlX
         TnYBsrX2NaOvAhfB48idXUd2rT4lfzS3rLgEmKIt2xteGFxqNzqNO+oKHoh1KJjm6AHr
         T5+2jrdWmyw51BelQA/By6C97Lj/WN4nJl5sBxkpZwrAq+FG++fD7H75y8zTUZ05EwT6
         7f/Hf14BOWOuAb4hPy7BmwWzTXxcTlduOIjJ2C8bSe2GADVNEQDQF/e2i26NDsLKV811
         seqE8cb+g1fnJOvUeVNBkPcHGxIesna30IpXgcfTVB/NHgh5KzMdVNVU2nJnmGbGnrrz
         YnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759774558; x=1760379358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nn6C1bOibkgdcmlvPsNgo458S28oM8kWbQLYIMbf7w=;
        b=lwYJv7UnKce+H4oh2bZaBnQQVq0LyBKrUjBQqNwiYNkVqDBw8VYjr8MNGF7qI9hgn+
         MZgyiwmZLmaVkqZdbOBf36iyup4gBgJmjYL/oiyOwxmIllt04SyqveuHxW4isO1EWB24
         /nz/GAgEGCrH+EIClpsVsO/9TY5ZZh+wTvjO8Wg9gyO6dm3d08Q9rclav90k3lN6JGuo
         Y7zLcX4LQlNMQXeeWPJnT/4ZZo3D8XrXiB8wn1cgJUCQvl2oZJdGxAzbTmksbLHR4jcw
         367hk5rHzP3r2xYhjIoaL6pETC2A1gk/KHIU16kEQcxfNYWbpdPwAcHjN+8UaZiIohi7
         zAJA==
X-Gm-Message-State: AOJu0YzLEi7jlkpferRVwhEScEnnoioOY4popoIggpJKc46thiUGMjup
	4N3J7FCji7iPym+L1Ih6LAcmcRXi3a/2GwWI9VvYLFNmqYSLKwHKafEFFi+zmb3fycKU/b2HGbr
	lPnu9cJGJsOT7/5Ce83DdxyVQAW9i7Ws=
X-Gm-Gg: ASbGnctZTw9U99pljaJuywk9abZSYjasI0JDY8i8pguEae59dtO3HuwTIKpKZGkz0Kr
	2xnHF0ntsi9fiMNZKCwF8HWvSGD/38aVv8OBHS9LryIleNR/RMCJ8sFxwqpJx1UodVRsfzX1nKG
	CAKImFMD8tLnLdQanxS63jsB26BNQiLVzSVIS34fSlPpqHyojyxd+IwURExclLtD2WhRwAFywlb
	tTRH25OD38Ks86lOUytkX5jFCmbGTLyaYNriXVTAQ==
X-Google-Smtp-Source: AGHT+IEgScP9A6bIbhG9joFx/DPAmF+MtJ9Ou3UhsWHD7dfoN75isSQgMpWU8mzPUAUsuKnUqwIJ9W3Ceeo9iCrdvSY=
X-Received: by 2002:a17:90b:33ce:b0:32e:5d79:64f4 with SMTP id
 98e67ed59e1d1-339c279e24dmr17596315a91.25.1759774557949; Mon, 06 Oct 2025
 11:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001172938.206904-1-plawate@redhat.com>
In-Reply-To: <20251001172938.206904-1-plawate@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 14:15:47 -0400
X-Gm-Features: AS18NWBj5lcasAPFzsp8k-L9ITFCrIi1AgJoVVXW_9uD8BlcaLqeit8cwoxkb-c
Message-ID: <CAEjxPJ7xHLZZMx=8=Vv+kfVXwquNATA2_iaO_Ja+e_J=H31ftQ@mail.gmail.com>
Subject: Re: [PATCH] improve semanage man pages: Add examples for -r RANGE
 flag usage
To: Pranav Lawate <plawate@redhat.com>
Cc: selinux@vger.kernel.org, pran.lawate@gmail.com, vmojzis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 1:30=E2=80=AFPM Pranav Lawate <plawate@redhat.com> w=
rote:
>
> From: Pranav Lawate <pran.lawate@gmail.com>
>
> Hello,
>  I tried to send an email on Sept 12 and waited for 20 days. Today I got
> to know it didn't really reach properly. So now retrying with 'git
> send-email' instead of using gmail with plain text.

Remove the above from your message so that it doesn't get included in
the actual commit message.

>
>  This patch adds missing examples to the semanage-port and
> semanage-fcontext man pages showing the correct usage of the -r RANGE
> flag for MLS/MCS systems. Currently, users who try to use the -r flag
> without proper examples often encounter unclear error messages when
> they provide invalid range formats.
>
> For example, Here is a command with wrong range string value:
> ~~~
> # semanage fcontext -a -t admin_home_t -r s0.c0 /root/test
> libsepol.mls_from_string: invalid MLS context s0.c0 (No such file or dire=
ctory).
> libsepol.mls_from_string: could not construct mls context structure
> (No such file or directory).
> libsepol.context_from_record: could not create context structure
> (Invalid argument).
> libsemanage.validate_handler: invalid context
> system_u:object_r:admin_home_t:s0.c0 specified for /root/test [all
> files] (Invalid argument).
> libsemanage.dbase_llist_iterate: could not iterate over records
> (Invalid argument).
> OSError: Invalid argument
> ~~~
> Similarly for port
> ~~~
> # semanage port -a -t http_port_t -p tcp -r s0.c0 8888
> libsepol.mls_from_string: invalid MLS context s0.c0 (No such file or dire=
ctory).
> libsepol.mls_from_string: could not construct mls context structure
> (No such file or directory).
> libsepol.context_from_record: could not create context structure
> (Invalid argument).
> libsepol.port_from_record: could not create port structure for range
> 8888:8888 (tcp) (Invalid argument).
> libsepol.sepol_port_modify: could not load port range 8888 - 8888
> (tcp) (Invalid argument).
> libsemanage.dbase_policydb_modify: could not modify record value
> (Invalid argument).
> libsemanage.semanage_base_merge_components: could not merge local
> modifications into policy (Invalid argument).
> OSError: Invalid argument
> ~~~
>
> My main motive is to come up with a logic to handle this error better
> but before undertaking that big of a change I wanted to push a small
> improvement to the code and so I have added correct example strings of
> MLS range into man pages for semanage-fcontext and semanage-port which
> I have tested to work properly on my RHEL 9.5 VM.
>
> This is my first contribution to the SELinux project.
>
>   The added examples demonstrate:
>   - Correct MLS range format: s0:c0.c255
>   - Complete command syntax with the -r flag for both port and
> fcontext operations
>   - Clear indication that this is for MLS/MCS systems only
>   - Practical use cases (HTTPS port and secure directory)
>
>   This should help users avoid common mistakes with range formatting
> and reduce support requests related to unclear error messages.
> * Here is my Patch:

Remove the "Here is my Patch above".

>
> Signed-off-by: Pranav Lawate <pran.lawate@gmail.com>
> ---
>  python/semanage/semanage-fcontext.8 | 4 ++++
>  python/semanage/semanage-port.8     | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semana=
ge-fcontext.8
> index 3a96c62f..3e7a1d8b 100644
> --- a/python/semanage/semanage-fcontext.8
> +++ b/python/semanage/semanage-fcontext.8
> @@ -100,6 +100,10 @@ execute the following commands.
>  # semanage fcontext \-a \-e /home /disk6/home
>  # restorecon \-R \-v /disk6
>
> +Add file-context with MLS range s0:c0.c255 for /secure directory (MLS/MC=
S systems only)
> +# semanage fcontext \-a \-t admin_home_t \-r s0:c0.c255 "/secure(/.*)?"
> +# restorecon \-R \-v /secure

This didn't appear to relabel /secure when I tried it; seemed to
require adding the -F flag to force it.

> +
>  .SH "SEE ALSO"
>  .BR selinux (8),
>  .BR semanage (8),
> diff --git a/python/semanage/semanage-port.8 b/python/semanage/semanage-p=
ort.8
> index c6048660..217fa398 100644
> --- a/python/semanage/semanage-port.8
> +++ b/python/semanage/semanage-port.8
> @@ -61,6 +61,8 @@ Allow Apache to listen on tcp port 81 (i.e. assign tcp =
port 81 label http_port_t
>  # semanage port \-a \-t http_port_t \-p tcp 81
>  Allow sshd to listen on tcp port 8991 (i.e. assign tcp port 8991 label s=
sh_port_t, which sshd is allowed to listen on)
>  # semanage port \-a \-t ssh_port_t \-p tcp 8991
> +Allow Apache to listen on tcp port 443 with MLS range s0:c0.c255 (MLS/MC=
S systems only)
> +# semanage port \-a \-t http_port_t \-p tcp \-r s0:c0.c255 443

Not fond of this example since we wouldn't want anyone to do that in
reality, but also how did you confirm that it actually worked?
semanage port -l only appears to show the type information.

>
>  .SH "SEE ALSO"
>  .BR selinux (8),
> --
> 2.51.0
>
>
