Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F33249EB
	for <selinux@vger.kernel.org>; Fri, 21 Aug 2026 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320343; cv=pass; b=UWGEnxNj0vCsqf1SsMghZs/rKEHgq5aobPBzPNJ/VZuSokteirMgWSYLqxR60g1IfuWraw/WHaN0QgMCocxMJE2PoeuUEFtK+AR/ona2rIW08hVfn+Ur4UdoAvDeojKbJTDnxV8IzEHrE5YIXDvNAN/dJICq5E8TB/Jl0ckRw9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320343; c=relaxed/simple;
	bh=sMCXD58Ck7XMjqxi99CPuHjkI5MeTfpATIu7xweU010=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFRi4LS/1z9pBquhv6JHsqjrTva9NBmjXjBFBu04LSAh2Uf0C6zcYdBGUHgdie+c53SgHAg7BAOjGyqYqrgtPoSXeZ6P724u9qw0UEkaqiTp4Wef3MrEWs+gk6mC1MEEOBiuNnGqgjVSSrTAWS2jB1rC7xwO3dE3dH14MMQ1n3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOkW+V22; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOkW+V22"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f3ece23165so1027161a34.0
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2026 06:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787320340; cv=none;
        d=google.com; s=arc-20260327;
        b=aQoVvvzL2tqpU6U/N+ZREbmoUhzMVkMLR+p5PmdQlTW5NREvi44V//geKPvo3BmSGv
         4QsWNsh0K24mOn4amT/V8wt47FTdaANwxca0oEzzxA50W/NBMVp9SThYsiEny40LsIfu
         dzTckNo7t8o1Nzwcb+hGcq+tSYGjTurO98JMoNXWjk4uQIrjsrOfHA20ysupsYM2u7Cf
         +MvcaLoR19Q5GQestIBTAXn1rLacFVHbIl2qQzJm8ojwqLxbpBX+bHxzIsWn+yj1lwhZ
         EK+3sYWZ9u7fZ0VIF960DLXhQ3sK5xv5NAmFTUr30niC2JLZYIW/f2Z3f3qEHDZnVwIl
         Mlag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0MQng+9xXyTKknMt+t9Rj4wyf14y6xu9aKeDOtOOdJk=;
        fh=cOwRRTEE+6NfxzwFNFaTm3aObzsY0eDsMfpSh3GchDk=;
        b=KHpKZ+5SoCvyA4ZsJCNKy/zelnE6OQNgF000XhCVgNmJtnpivJHtUNKJbYIFS+Kwfz
         He+pBCILmTtMd1/a5u2d4QpBPN9SFxFac5AbnWRP1HJOHlIp42CSnae/VgILAnL0pGRx
         jQDW+tUIEB+FqPM2R91lSPXf7aZswM36FwlTXbJdvrexSxbUhLuxvutNQlcvOu8uoQUE
         SF4j3U22VeSZqf7eUKP7s0YDqlSHLkWdUljNgPgAL/IC+o8GrEBFt2E2A7+DK1T3Cnqi
         yzmd2di26L7LJBq75twV7Zpj8p6TFe2qjJqVl7siJFmC3zinjCwKnPY1Uoi1AaYWarEQ
         wRGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320340; x=1787925140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0MQng+9xXyTKknMt+t9Rj4wyf14y6xu9aKeDOtOOdJk=;
        b=AOkW+V22rhrAxcDrepdr3WEBsSoDX46UNW13oEtBAtR86Zl+J5D9pmddAY7Bk0995M
         QuotVn4oehPG+vCPdruMMX5U4gu8EZ+yy2gw7vaEU7vUfqAs7W4uvZAshk9+a24YGt1V
         hE0y9L7jgoUSzx6YXi9cqEVIleBrHRIctPZ70NwPdGmB36PovDhg/W1EwlBaMinmXMVv
         E7Bvs3AtK2x6BJeUad3NremEA8nwU3nHssME2Xb5WOKNMZyRHRlhluK3JZwXDkD2/oSL
         BxNctSj79dDb32MfOHET0LHHkDLRVhjufn6uuN60QOwQNIrvxdZPfzC/N7NGwXuZjD5i
         ukyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320340; x=1787925140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MQng+9xXyTKknMt+t9Rj4wyf14y6xu9aKeDOtOOdJk=;
        b=mwExgkGnNSY3+DbA+4YjWyCePtHhI7etDQkuOfgmi0wIdTC93H07jXGTvx1ikbTxAH
         38fjpNUxn+tt5ivgV8b+qrHA5ar2A58dSyH06/gxcQt3HWBw/cmQESca1/5w7NOnW7gc
         74UsHugE35kQCM9L2Optb+dvDdFyQXoXwVqU/2841QuMs6PC8lWVGFCaECG91FyOhyBA
         VkZZ71BF/4EFWmHDDqWqWN94OsX9aL1niKxfZASu747XOm5F/jBEhTVN2ctMXIWoqDjA
         0ZnV2XzkUzkOYddr9HtbRa/mOKYGRD2w+gkoaMc94Sdc2O6AChHJ4BJL1ZCmLOOtj5Cl
         IwCw==
X-Forwarded-Encrypted: i=1; AHgh+RqQ6HutIp4MVhgjB2AcZ8Jr/PdlL3RIvnDKHM7AUPh9l6W0oA+czpiS+PvJKjuUf9I/XXsWL1d7@vger.kernel.org
X-Gm-Message-State: AOJu0YwrzEjJ79E8yx8OwvCMYao6fyie084abQXjYT3YtMh5jEqubBda
	Ig4ndlijo9p1dDVT82oFZ89EvmQF55B3m8eHNb+779OZPRjtSoQTVpgzWUqglNtwdgPOyS9xId1
	fkSyjQc8XkwBzT/MVTs0PM1XeivdzQJw=
X-Gm-Gg: AR+sD13UxL6LvFHOls5yTxzLiUKXk3ot6IO8vPrHtXn7pbrZajCUW4I63tjipH7oVk6
	+ZTvoId4lLZKvx8stS8xaKlWZGKJ1eJ0zz4+8AKyxQUjhcFA1gVSL8fpf5dOex71A7nCN6laM2+
	Rp2FgZJP/WR6hoAUrZsPIwPipJeGTDRc7CvmzMMqN+VITsTqoti8PCZh7l/DLQwySVY8To1pNW8
	JuRj4CucmFc0D0nI6XJE1lYk8/blcsF39iE2fC4Kvb/c/B5Zo0ulU9d3B5SNxFDrPr9ynph/GgS
	cn/B3FxrnkEjBazzrYAdY+V9oT0KRWwUZeiF433/YuiR
X-Received: by 2002:a05:6820:341a:20b0:6aa:e176:bcb5 with SMTP id
 006d021491bc7-6b15925da2fmr5108790eaf.14.1787320340365; Fri, 21 Aug 2026
 06:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com> <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
 <CAG48ez3h2Gft4onQ8AgBmf8gHrF26YqTinajuBysNPkUKaTBoA@mail.gmail.com>
In-Reply-To: <CAG48ez3h2Gft4onQ8AgBmf8gHrF26YqTinajuBysNPkUKaTBoA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Aug 2026 09:52:09 -0400
X-Gm-Features: AcwNN1XIMQRcAUBNk7fjxozSpQ8JckvqGIQ5KHe6kYNDH33rw4pKhCm-h8pgeiw
Message-ID: <CAEjxPJ5cUDBekWe7fC1JYnw6CfT8GVa9fqrFwLPPAOqSP6jn3g@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE introspection
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 11:23=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> On Wed, Aug 19, 2026 at 4:54=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Aug 18, 2026 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a proce=
ss can
> > > only create anonymous executable memory via /proc/self/mem if it has =
one
> > > of:
> > >
> > >  - EXECMEM (like for other methods of creating anonymous executable p=
ages)
> > >  - PTRACE (like when using /proc/$pid/mem of another process)
> >
> > Allowing it if _either_ permission is allowed is unusual in SELinux
> > and seems prone to errors.
> > Is there a reason to not just require PTRACE always?
>
> Hmm, that might work.
>
> My two concerns about that approach are:
>
> 1. This is an operation where a process acts on itself, while PTRACE
> is normally for acting on another process. It feels to me like those
> are different types of privilege.
> 2. I feel like blocking this operation even for a process with EXECMEM
> privilege increases the risk of breaking existing configurations.
>
> I think if we want to gate it on PTRACE, we might need to put this
> behind a policy capability and let policy authors figure this out?
> But I'm no expert on how new security hooks are normally added, or
> what SELinux policies outside Android look like, so if you think it
> would be fine to just check for PTRACE, I'd be happy to go with that.

I don't think a new policy capability is necessary here. Is there any legit=
imate
user of this capability that wouldn't already have ptrace permission?
The other alternative is to introduce a new permission for this, but that w=
ill
deny-by-default on existing Android and allow-by-default on Fedora based
on handle-unknown until it is defined in the policy. In the case of Android=
, my
understanding was that kernel updates can always be coordinated with policy
updates so there is no need to worry about a new kernel breaking userspace
with old policies i.e. if and when Android ships a kernel that
includes these patches
they can also ship an updated policy that allows the new permission
where necessary
but I could be wrong.

> (I've caused stable regressions several times at this point and am
> trying to avoid causing more...)
