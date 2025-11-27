Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2091264FB5
	for <selinux@vger.kernel.org>; Thu, 27 Nov 2025 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764248111; cv=none; b=hAKjWJrS1k+fJfwWXGqCm1zltghfYa2LFVEMvP6VIC5BASiqHbtRobd/TAEII3xOpn6uqPIqFMsTmajAuOAo0/niZs10A76FnbozTz4qzzlThQZFQPno13/ZT2KX8JqnBuAewKzBSzgWpuPDp4lPAL2U4oC/ExfCkfNnv35nw/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764248111; c=relaxed/simple;
	bh=zbmfSpFgRw2gM8+xB+rL8zx6dxucISc4kqDXFSvPP90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek96U4xWireEc1cZQHhj1tMGp3JE9f/YcLACEtBNAZeKPRujZffDSLS1TI4E6YLXeKWxyqQXMKh1kzXAyZ68/Ibfx0WY3jxvSEX3noft0CpLoKqlGHC/ZK/KNZSSAt/twzU2cJWkhJJdpiPYNsogQ1LC1TYvJdhCQBZHEDPAr3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04FAE336A2;
	Thu, 27 Nov 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C06963EA63;
	Thu, 27 Nov 2025 12:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J+vdLStKKGlyLgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 27 Nov 2025 12:55:07 +0000
Date: Thu, 27 Nov 2025 13:55:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it, Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>, Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH v3 1/4] shell: Add tst_sudo.c helper
Message-ID: <20251127125506.GA244936@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251127082638.224110-1-pvorel@suse.cz>
 <20251127082638.224110-2-pvorel@suse.cz>
 <CAEemH2cUYekSphFW_uj2w1FzYt3RWXDDnhmQ5TFAyr0T3HFxow@mail.gmail.com>
 <CAEemH2e6ivP0rzfTBp5LnZ8n-oe7moqfHszgs2QyYVMUTUQ_wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEemH2e6ivP0rzfTBp5LnZ8n-oe7moqfHszgs2QyYVMUTUQ_wQ@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 04FAE336A2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

> On Thu, Nov 27, 2025 at 7:57 PM Li Wang <liwang@redhat.com> wrote:

> > Hi Petr,

> > I feel that the filename tst_sudo.c is a bit misleading. The helper
> > doesn’t
> > replicate sudo behavior (authentication, privilege escalation), it simply
> > drops from root to a fixed UID/GID before executing a command.

> > So readers may expect a “sudo-like” elevation wrapper when, however
> > it’s a privilege-dropping trampoline.

Thanks, makes sense.

> > What about renaming it to:
> >   tst_runas.c,
> >   tst_runas_nobody.c, or
> >   tst_drop_privs.c?

> Personally, I prefer the tst_runas_nody.c because it reflects the
> default privilege,
> but due it supports the more env so contains "su" maybe better:
>   tst_su_switch.c, tst_su_cmd.c

I'd be ok with tst_su.c, but sure tst_su_cmd.c is ok as well.
I'll wait little longer for feedback from others.

Kind regards,
Petr
