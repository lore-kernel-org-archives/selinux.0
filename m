Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAD21F427C;
	Fri, 25 Sep 2026 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344733; cv=none; b=TWaClnEm864eXSaBLYhZVCIUCUefvqHgGmJ4n+ZrrJwgbY0F4CW+bIWuvoDWnyemznQn5gmuavyjkP6XuYQlRg113fM+rT+eBD2MqxH5XXdmWtLQDA3FesCHPyRri9gVtDVHC/JxiuHQniT54J9xzrn25nvNBjxy8qjEJQ0/Lnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344733; c=relaxed/simple;
	bh=cF7kmCYdvSUhXAb6Anp2qNKZ7n9y9dO5D6yXNCCIv8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KO09oDthnIICp+05DzX/xPB95sX/io334nFjPwmpC+jAUbFnU9kEunTUKfBWhnhiXFzrgFNJP2A+0Qxl2UGMAhG1u6pOcFXBd5R8WHSOI+PdgOp2QriSVtUHV/SV1eT0ip9Pn9+Vs618GpXXo/kxhBpIYKGjjPmtVzwm/tk09Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9zGyFeX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9zGyFeX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211EF1F000FF;
	Fri, 25 Sep 2026 13:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790344732;
	bh=VBLaw2VxaSkQ1Ui0iogeAEvRyP976Xo0PLpWfj2E1hQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n9zGyFeXn60gkK/I2elWSZMwV6gVDT2Vw5wM0gm4NL2UV0dL/Aywko6hjDa5rcA5Y
	 QTk5cCaBej2Y7L+8TxfB+UsKxqP26dE+4WfKo1WUW9r7DfmSuctrTIAcmy0sIPhvRg
	 yZ+djyVU06ZnbBReZUMRjmCCj4oZo/2oa8Bronoavx22ZYJOtE8WUAAggvhmfdse7a
	 ScS4bt931UTEyBugh15t94A0A7/To0PvAaqkjKlLnmG3TPS9N7+WhOnN8ocxzbqMNS
	 4DIWSE10DgwTQzmqSzf5aKElkz3FNGbaTOpBE8ov0sNQzDiwe0OVBVHgL7QAkgQpOy
	 Y/XQF8USZCYKA==
Date: Fri, 25 Sep 2026 15:58:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	mic@digikod.net, serge@hallyn.com, jack@suse.cz, jmorris@namei.org, 
	omosnacek@gmail.com, selinux@vger.kernel.org
Subject: Re: [PATCH v3] lsm,nscommon: initialize the security blob for the
 initial namespaces
Message-ID: <20260925-gebaggert-ersehen-serpentinen-a6e61570e1b7@brauner>
References: <20260918143142.19435-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918143142.19435-2-stephen.smalley.work@gmail.com>

On Fri, Sep 18, 2026 at 10:31:43AM -0400, Stephen Smalley wrote:
> Commit f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> added a security blob to struct ns_common and allocates it from
> __ns_common_init(). Most initial namespaces (init_user_ns,
> init_uts_ns, init_pid_ns, init_mnt_ns, and, depending on
> configuration, init_ipc_ns, init_cgroup_ns and init_time_ns) are
> however set up statically via NS_COMMON_INIT() and never pass through
> __ns_common_init(), so their ns_security pointer is left NULL for the
> lifetime of the system. Any LSM that registers an lbs_ns blob and
> dereferences its slice on one of those namespaces (for example from
> the namespace_install hook when a task setns()'s back into an initial
> namespace) will fault.
> 
> Allocate the blob and run the namespace_init hook for each of these
> namespaces at the end of security_init(), after all ordered LSMs have
> registered their hooks, so every LSM sees the initial namespaces the
> same way it sees init_net (which is initialized at runtime via
> ns_common_init(&init_net) from net_ns_init() immediately after
> security_init()) and does not need to special-case them in its own
> ->init() callback.
> 
> Provide a ns_common_init_security() helper in kernel/nscommon.c so
> that the list of statically-defined initial namespaces and their
> Kconfig guards live next to the rest of the ns_common
> infrastructure. init_net is intentionally excluded: pre-initializing
> it here would leak once __ns_common_init() clears ns_security and
> re-allocates.
> 
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---

Seems good to me,
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

I'm waiting for Paul and then I would pick this into namespace-7.4.misc.
