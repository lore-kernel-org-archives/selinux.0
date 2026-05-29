Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1824B33E344;
	Fri, 29 May 2026 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095839; cv=none; b=c/H/wplg1U8Bbxrx2RMHhS572kr3V0A3tA6sOpYMrBTXtFlutbO7h2Y5TMvQSwRfDYtMn2YEgxf6D0lhXUY4n9UWmKcXmtZWYnxSr2Wu92ycuNjGS1fKLTR11aq6XdpL4dz2k4ByjjdWFovAgiEU5Mvt3+37ioE8wUCs/JpNWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095839; c=relaxed/simple;
	bh=PbHDSuSUvH4whdXkcxX5ZH6CF1EnRKy9QZpcEucp1T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpAxg9RdvIzhdoVy4uBRZNk0LgKH+uT9YSeR4xAIkjXwHskaaRvdldBd8S7gcGhp5lfcyliArB06+kFKVdIN5A50WovYeUKhtPKwKdz3gWkU040UbQDr4bxjcu9HGgvzkDQij4cOeFw8pApvvl1ig7luYYE89kK8lLJFpia6txU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=eaUcs0bG; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="eaUcs0bG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1780095511; bh=PbHDSuSUvH4whdXkcxX5ZH6CF1EnRKy9QZpcEucp1T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eaUcs0bGtjCfWXcAelqkIkWJh4idb/KtXJ2rW5/fGKV0XeJQgcMcQPJPJYoRX9PuD
	 ezlL7AsZ7II5wM7PWEaBU7jM+i7Zr8jbmDSBU0FhjPdn5iyplM6g6Wuy2nmHKNLhqn
	 YeWT6IZiSYW7XliipjahsBf1AZTzL9y2GBvSqV9qCDFAjDBxmyAh1FBz/NsCBykJEH
	 Uu6yt8OyGVPg+SFl3gj/u6dhph6wnpnxCOvwIFfoF9wXKLkI0jgv+Mt2mr0v1E4Prf
	 3FvBJFSYNEUN2oxG6sjARcoCU7bybJTPi8QHTVzJ4KxD82XGY3H9tJm+ZlkrL3Yami
	 Yep2RjNtoUydw==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 7430B79; Fri, 29 May 2026 17:58:31 -0500 (CDT)
Date: Fri, 29 May 2026 17:58:31 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
	LSM <linux-security-module@vger.kernel.org>,
	SElinux list <selinux@vger.kernel.org>
Subject: Re: security_task_prctl: why -ENOSYS
Message-ID: <ahoaFz8DMMvWgqL+@mail.hallyn.com>
References: <CAFftDdrzV2xC7HBcgS8EPb-YewJyCK9uos4crXOCh5ONm6SxSg@mail.gmail.com>
 <CAFftDdqp8b5n21hdEP6w0-PK+CoG7mmQxgrnhpBLU7-1GZxniw@mail.gmail.com>
 <090a355d-3680-4113-a542-ff3b1c565f58@schaufler-ca.com>
 <CAFftDdqvvqrbm=+XsDdkJHdm12jxK9799_A=Txz6Q5goYC2ALQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFftDdqvvqrbm=+XsDdkJHdm12jxK9799_A=Txz6Q5goYC2ALQ@mail.gmail.com>

On Wed, May 27, 2026 at 11:05:56AM -0500, William Roberts wrote:
> On Tue, May 26, 2026 at 6:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 5/26/2026 4:21 PM, William Roberts wrote:
> > > On Tue, May 26, 2026 at 5:39 PM William Roberts
> > > <bill.c.roberts@gmail.com> wrote:
> > >> Hello,
> > >>
> > >> I am trying to understand the motivation behind having
> > >> security_task_prctl only continue if the return value is -ENOSYS. This
> > >> seems to be very different from other LSM hooks I have investigated.
> > >> For example, in other hooks, the value from SE Linux avc_has_perms is
> > >> used directly. This essentially means that a 0 will cause the check to
> > >> pass, and anything < 0 usually an error.
> > >>
> > >> In commit:
> > >> ----
> > >> commit d84f4f992cbd76e8f39c488cf0c5d123843923b1 ("CRED: Inaugurate COW
> > >> credentials")
> > >>
> > >> (8) security_task_prctl() and cap_task_prctl().
> > >>
> > >>          security_task_prctl() has been modified to return -ENOSYS if it doesn't
> > >>          want to handle a function, or otherwise return the return
> > >> value directly
> > >>          rather than through an argument.
> > >>
> > >>          Additionally, cap_task_prctl() now prepares a new set of
> > >> credentials, even
> > >>          if it doesn't end up using it.
> > >> ----
> > >>
> > >> The check in kernel/sys.c is currently:
> > >>         error = security_task_prctl(option, arg2, arg3, arg4, arg5);
> > >>         if (error != -ENOSYS)
> > >>                 return error;
> > >>
> > >> Should this be something like, "error && error != -ENOSYS"?
> > >>
> > >> I ask because I am looking to leverage this hook in SE Linux, and it's
> > >> annoying to have to coerce all 0 returns to -ENOSYS.
> > > Of course after hours of banging my head and one email sent, it's more clear to
> > > me now WHY. This hook isn't meant for making yes or no decisions on an operation
> > > but rather to also handle special prctl flags for an LSM in question.
> > >
> > > I guess with the said, do we want this interface to be used for both
> > > a, let the lsm handle
> > > this prctl flag directed to me, as well as a yes/no security decision
> > > or do we want to split
> > > this out into two hooks?
> >
> > The task_prctl hook is used in capability and yama. It is only used to
> > provide a place to process LSM specific prctl options. It is not used to
> > make security decisions outside of processing the LSM's options. If you
> > want to make security decisions on general prctl options you will need
> > a new hook.
> 
> Yeah I finally saw that after I sent the email, as always :-p, but thanks
> Casey for confirming my understanding.
> 
> So now for naming... We have security_task_prctl for handling random
> prctl interface calls into LSMs. So what should this hook be called?
> Perhaps security_task_prctl_check? Should we rename the old hook to

How about security_task_prctl_allowed()?  (Mirroring security_uring_*)

Renaming the existing hook security_task_prctl_handle() also wouldn't
be too bad, but that's probably more churn than it's worth.

> something else?
> 
> For now, I will just pick a name, but suggestions are welcome.
> 
> As an aside, any lore as to why go through generic prctl vs an
> LSM specific filesystem or an lsm specific prctl (we already
> have arch_prctl why not lsm_prctl)?
> 
> 
> 
> 
> 
> >
> > >
> > >> Thanks,
> > >> Bill
