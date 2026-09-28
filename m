Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2994B95C3;
	Mon, 28 Sep 2026 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604806; cv=none; b=e4TUfgr56rdX8EBxtUEvJeVS+5+Sq0iectfgvW1d4hyITSPsCoEm9Oc450xx2JxDE5xcCuIpr46xP6zDgGaEh84GU0QFE7FpIRyuc1TpUI4eglgR5rVdYiCGTQo6MAlM+Tmwr3xX9dNsmfZ/6ztsakNRR0RpuRuFbtx3bK54AUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604806; c=relaxed/simple;
	bh=NNorNlapZ31fj0LIocgeU4KjCJmrUEG+KYfTQXaREKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MELxQM1td23AEJynj0WVaDo9ueSjEhVv4MKIh2aQESXDSSeTEsO2idW1DL50LahnbCZ3q89D/M37jJGl+r74W9vVIJ8bEHq+IG7RBFrK9f7kvFaS2rIchV8k1dVSweadx/chNh/1wlu40brswA89lz0ke6qKsMf+YQ7giOhgbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF4xVeoX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF4xVeoX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455E91F000FF;
	Mon, 28 Sep 2026 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790604804;
	bh=AxZ1QzgjL/c/8KlDjDx2/cpckS6+XaeDEq5HJYzUGwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DF4xVeoXxdA7nYLDRDKuhlyazMwiiGjpTvxOE7SxDCH/1G17WOB08r0asruLrq1p4
	 uxyefZbEz/3idGgN5V0IKohCVJoYQdRKu2EnouyCXpiU6tYqHApa7ClijAncTdZxpt
	 LgKSCeUJGV0TnZOqll8Em1QE+zumu+10u4r+bZJog+GUp6o9rwoWedBRF7wuCHY9aL
	 7DGHGLCZJc3ZlGh1FiwuCvDJZvTdwqiXi2iNfbzQxHKh9iGicD5M5OBhS7zaP3Glke
	 DxfPLHrjkcJ2OySqEYkNcX6RAeDOd3Xk4tiIS0QlqZvh+ciyW+oZlSbl72koGQUIF9
	 oQ5sCCbSiDyQg==
Date: Mon, 28 Sep 2026 16:13:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	mic@digikod.net, gnoack@google.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, herton@canonical.com, kernel-team@meta.com
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular
 mount hooks
Message-ID: <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner>
References: <20260706235053.4104951-1-song@kernel.org>
 <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>

On Thu, Jul 23, 2026 at 11:19:30AM -0700, Song Liu wrote:
> Hi Christian and folks,
> 
> Could you please help review this set? Does this set address
> concerns from earlier versions?

I just realized something while looking at this. This doesn't cover the
new mount api at all fsopen, fsconfig, fsmount, fspick, open_tree,
open_tree_attr and mount_setattr. Without this the series is not very
useful imho.
