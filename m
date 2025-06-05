Received: from smtpcmd12132.aruba.it (smtpcmd12132.aruba.it [62.149.156.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5341F429C
	for <selinux@vger.kernel.org>; Thu,  5 Jun 2025 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149026; cv=none; b=kBEr7fme3MVxrkqIrEQM0rlksD/pw8hV+7jIVjuzv855TQvKRwm3AYEdZ6R+6yNbF1nefvCDgeVxgYAHC4DMSCPXSVLUiAJao710bt0dl5rwdqAKnqKsAkPa8/Guzhmxf62An87be0KOyv2mWyxeVpk3FE4TAmqkniroiYfJ8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149026; c=relaxed/simple;
	bh=+GTyni0Q9HFFUzugVCl92gBxLvLLH0RVbiAtQJoaMZI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=qUSf0tDc6AlUTsftLEuVAvK1RQXudzgH7oGljL1dpXX57Bc8168KaWWgPOSS6ewxOLDvn2UjaEgdQaS6zN/bogBZsXGNve7OYs9SwrB82mpEJVT1ah1QFDk6yLqYQGPxUvDzfwMd8avmWTC1Vg91V70+BLhXUU3cyyeuKR2DXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com; spf=pass smtp.mailfrom=trentalancia.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=nDB+tUei; arc=none smtp.client-ip=62.149.156.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="nDB+tUei"
Received: from [192.168.43.2] ([109.54.111.125])
	by Aruba SMTP with ESMTPSA
	id NFVvujvpYDWj0NFVvuPXke; Thu, 05 Jun 2025 20:40:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1749148831; bh=+GTyni0Q9HFFUzugVCl92gBxLvLLH0RVbiAtQJoaMZI=;
	h=Subject:From:To:Date:Content-Type:Mime-Version;
	b=nDB+tUeipvawb0HP63NCEbHamsK75mqZc6StKSBd9lCUDUge4j9Q9snPuWasu5MNQ
	 iIEiTYBguk9fciIyK7PKZ7Ux0JNEqAICu5KU4grfQXc2QhNFm1BBEAJEvGeSAuYa8l
	 0vYLajbGPsg52i31Jfhqz1dfQfUkadpExf+bXMG8QCMGG8ePOpo9AsI8CYS3Sm9Wt0
	 hoKFgOvw9aAPQcdGtV9rNNOxW5xgYOswelIvO6/iBJxPImM6E2dt3IglHHjWL5d+D+
	 wFNc0nEL2yoccDzvg9Ytn4R0yRXvWzEzxzRBz1VBdTuQd57k5GFwMJbU4CNEnm4cOK
	 JwMuDHTrfBNiQ==
Message-ID: <1749148831.7370.3.camel@trentalancia.com>
Subject: Re: [PATCH] Only set the initial SID for early-boot userspace tasks
 if the policy supports the new capability
From: Guido Trentalancia <guido@trentalancia.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Date: Thu, 05 Jun 2025 20:40:31 +0200
In-Reply-To: <CAFqZXNufHFEA8304qvTi8znWUmrznqyywWMDJYgBASN+VbvLSA@mail.gmail.com>
References: <1748100564.11369.2.camel@trentalancia.com>
	 <CAFqZXNufHFEA8304qvTi8znWUmrznqyywWMDJYgBASN+VbvLSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJBDWlw2l+EFS9dqgkyE8AxGMRBsI3/OecEWhkaN47Qe3aHcGkmOGS/GPck/IIfUecuvwwd4Ji0agG2fv5HC6OgKSezypfAu18EjrNPf4XVLe7KS+9Vk
 4hNCCReQC9zDkfNaIiCTYW9DuZbt2dKhvYPGNvGziHxZWVdqNQK50uOFxH3T7GW54ghx5lDgUUl9YMMwFWYxNJ6qTdGjGlJzOTt9reXWozTNtJG58Ug7zNJ9

Yes, it obviously breaks something: systems based on sysvinit fail to
boot !

The full bug report is here:

https://github.com/dracut-ng/dracut-ng/issues/377

Another solution was initially proposed as a dracut patch, however it
has not been merged yet.

You are right, the kernel patch proposed here is not acceptable, as the
policy capabilities cannot be checked before the policy is loaded.

Guido

On Thu, 05/06/2025 at 14.45 +0200, Ondrej Mosnacek wrote:
> On Sat, May 24, 2025 at 5:32 PM Guido Trentalancia
> <guido@trentalancia.com> wrote:
> > 
> > Before the policy is loaded, only set the initial SID
> > for early-boot userspace tasks if the policy supports
> > such capability.
> > 
> > Check for POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> > otherwise preserve the old behavior of using the
> > SECINITSID_KERNEL label for early-boot userspace
> > processes.
> > 
> > Fixes: ae254858ce07 ("selinux: introduce an initial SID for early
> > boot processes")
> > Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
> > ---
> >  security/selinux/hooks.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/security/selinux/hooks.c  2025-05-24 14:37:45.499997561 +0200
> > +++ b/security/selinux/hooks.c  2025-05-24 14:36:58.453997848 +0200
> > @@ -2319,7 +2319,7 @@ static int selinux_bprm_creds_for_exec(s
> >          * early boot end up with a label different from
> > SECINITSID_KERNEL
> >          * (if the policy chooses to set SECINITSID_INIT !=
> > SECINITSID_KERNEL).
> >          */
> > -       if (!selinux_initialized()) {
> > +       if (!selinux_initialized() &&
> > selinux_policycap_userspace_initial_context()) {
> >                 new_tsec->sid = SECINITSID_INIT;
> >                 /* also clear the exec_sid just in case */
> >                 new_tsec->exec_sid = 0;
> > 
> 
> This doesn't make sense - obviously you can't check what capabilities
> the policy supports when it's not loaded yet... Does the current
> behavior break something for you?
> 
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
> 
