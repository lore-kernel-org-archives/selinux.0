Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF27E360EC9
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533371; cv=none; b=HSZ+31KcVBZnZiPiiRhqbxbUUJa8O/TXAF0xRBigcSciywPp84AorJRWl3d5OPwjetL9JSZezJF8m3G+jk3SQkNNlbamRkEqZU47gJku1QAunERjTk5g9I6irwf5zCiMS6gsKomou0P9doas75EgWFOejPQe+5RYEbTLI1OYWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533371; c=relaxed/simple;
	bh=xgDHCJSJUP076VEAIU5jDFMiES5x72agvJm+Htj+ukQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LzLWN59FjdjG1sLzQVfanA+FLZDra/RE0M4rCtTKhJwCBF6GJ6h8UdS8fvP6hLX9M0rhH8ljm/vTFHeir2ShUAhzzNYDxyPKybaYEpvbeJMgLaGs2SCB/Ib0vqItqv8o6f4y77/wq1pcE6mZpNooMRQVbWPBs6e/wJzlUgqKiHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy2yeANA; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy2yeANA"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso475530f8f.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785533368; x=1786138168; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JL8gvuzkxn4fskzyW+z6arqOmzMuXIEuoBq0ytXlQVI=;
        b=Oy2yeANAjNHNcCOCrKh10I6DYfVZ/M+NgqFtZUitKVzVsH37XgLgYcyimDXfIaFIhh
         R4ZrYl6oBtYxYE4Vuf+XEAP0y2CY+yNZEzM+nt2W2+oIFvSR8hyAkotTLNQpYy/07dui
         p/tseISd9LW4fWR260FFW4v/e7eoBGbdHcdzrvPSBy/rSMRMfR/EirRkE0FUGP2MaQFf
         moQYlCm0x+DUaBDwIgs7ke1S4FtemMmr/t4DK4JlrtJ6muLOIdWzZ01b+h9CORbkkYfG
         LjP3aL2E+AbWkimzZMJWRrSglRpjfZB+LBtUZwffRw8RlztKh043JX3qAhm8CZK5CRi/
         I5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785533368; x=1786138168;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JL8gvuzkxn4fskzyW+z6arqOmzMuXIEuoBq0ytXlQVI=;
        b=Ucx6qCcCibgiKIJHk3brNUMs40dgYS+bDeUA6goxDX8ucBv8QtsJVomXA/77GD+Rd3
         EK+Ivgf9GRtXN2B5lonLevuUq/DmQ0RAhD6DYe0JsE5m5lAFFIDLa40Qw4rFFX9e3kZb
         V0aaeXSXhtj26bJb3SDXyh34QSKtV8bQqam4I0zUOXg2piKvdS8uKLiEqN7rgbbyrE5h
         WQqyyVqnwK34CO6dn5+plF7u+vahskvDj3KunNuHIQN0kalupeKR37C7gg2/ZZuOZsRw
         BlxMteSSIVwaC6lqZHM+Ty2OrwUI8INZdkcbb41vCUqcCxs5fKVKoIjMvHPjsUz+aufA
         S5XQ==
X-Forwarded-Encrypted: i=1; AHgh+RqRKrh1L56Ci/xMJR9YNHyJ6YV4NYalSlOLCUsgCHLMk2qoEjm8EkKmbPUKFQTjGqyWzerialUb@vger.kernel.org
X-Gm-Message-State: AOJu0YyWE2C9xsq7k08SZOxfQsyYdaSshLRYE34uh1jBgaSpcabI+vw7
	E9Lf2vobkg7jSCTAKm3Jx5+sjz+c/z9ppz+Cf2KWneR+KdARLTTn3qsB
X-Gm-Gg: AR+sD10pvIEw9HYv3ExvJYYLAX2ThcnjaELXxct1yMvWUmP+TJC1ZOFsmcR4QrCGeq0
	2yYVPhTRmU0rrKZ2w+UcclF3IRP+k/Ge6XCFyNyFxLnNkhVFDLz/h1HDSSel5VqK/hnyLSxL8Hq
	PfsffDBQz17F9ScVnxIWK8O5g3pZht+bZYmsNgjjRI+lqyonpImXjGdSIlq6twh5auBRzTHLQ/k
	J/5/2FM+Kh853HW6utASnjjO6p8VaWlvkrE8zITkYqFSIdvg7B/9vP5KubTBTwrJ5nWgTVOKhHV
	lecD8uOatDvcG04kmHls9AWG9tmjOn5CP/MytFFhtRdVd8jxh3EYrOm/KXWXc4xP1lIxHrB7BvZ
	uWZuAGro+GlrH8VjNZM9SzkNzYBSj2/txNQxOhL5coyoeZnSSUR335eUDaUhy4bYBQzp0ENic3Y
	Jl53R90Qgo3VsuMEj/wzQQEkmQRw09jvVRkSEC0Wq9jgWuBdRzK7TCiWJUah+atkESkKpw1WiuS
	8aQxiKY8ZBY+R/Zq9WEJF1NYjupM11imihxhUTHNBZjCZwZXqR+HELcVmK36Nx3mGo9EXq07b4H
	BMs2KjIsoAUdafy8puy8bcPS8gRY
X-Received: by 2002:a5d:64e3:0:b0:47f:8e50:93de with SMTP id ffacd0b85a97d-47fd732f9c7mr2389247f8f.54.1785533367982;
        Fri, 31 Jul 2026 14:29:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a6cbsm9121148f8f.23.2026.07.31.14.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 14:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 23:29:27 +0200
Message-Id: <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com>
Cc: "David Windsor" <dwindsor@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "James
 Morris" <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, "Stephen Smalley"
 <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>
X-Mailer: aerc 0.21.0
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
 <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
 <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
 <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
 <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com>
 <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
 <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>

On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
> On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
>> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
>> > <memxor@gmail.com> wrote:
>> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
>> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
>> >> > <memxor@gmail.com> wrote:
>> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
>> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
>> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwiv=
edi
>> >> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
>> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya D=
wivedi
>> >> >> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
>> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <pa=
ul@paul-moore.com> wrote:
>> >> >> >
>> >> >> > ...
>> >> >> >
>> >> >> >> Yes, I understand you feel it should be placed under security/.=
 You are entitled
>> >> >> >> to your opinion.
>> >> >> >>
>> >> >> >> No, I do not think the newly added kfunc is a big enough layeri=
ng violation such
>> >> >> >> that we need to do it ASAP, disregarding everything else outlin=
ed above. I am
>> >> >> >> sure you see that too. There are several other instances of sim=
ilar kfuncs.
>> >> >> >>
>> >> >> >> Therefore, please attempt to meet me halfway here.
>> >> >> >
>> >> >> > I'm happy to work with you, and/or anyone else, who wants to wor=
k on
>> >> >> > finding a way to test kfuncs that live in security/bpf_lsm_kfunc=
s.c.
>> >> >>
>> >> >> Right, and for that file to exist, you need to get everyone (FS, B=
PF folks) to
>> >> >> agree on whether placing all such kfuncs there makes sense. It is =
not for both
>> >> >> of us to decide on our own. So let's revisit this whole topic once=
 you've done
>> >> >> that exercise.
>> >> >
>> >> > The kfunc that David has proposed must be located in
>> >> > security/bpf_lsm_kfuncs.c, similar to the VFS kfuncs and
>> >> > fs/bpf_fs_kfuncs.c.  If you read David's bpf_init_inode_xattr() kfu=
nc
>> >>
>> >> Sigh.
>> >>
>> >> I now went and read the archives, and Christian already told you no b=
efore [0],
>> >> which I missed in my first read. So two people whom this code affects=
 already
>> >> objected to your proposal.
>> >
>> > As mentioned previously, David's kfunc has nothing to do with the VFS.
>> > Look at the code if you haven't already and you'll see what I mean.
>> > The only relevance to the VFS is the fact that "inode" and "xattr" are
>> > used in the name; David's currently proposed kfunc is an LSM kfunc,
>> > not a VFS kfunc.
>>
>> I am sorry, I read it and I don't see why it is an LSM kfunc. It is abso=
lutely a
>> VFS kfunc, that is using LSM APIs to some end. The LSM specific bits are=
 already
>> in security/.
>
> [...]
>
>> > If you find yourself required to abide by Christian's comment, despite
>> > this not being a VFS kfunc, that's fine, but this puts us at a
>> > stalemate and David will need to find another approach for his work.
>>
>> Paul, let me remind you of another email you sent [0], in which you cont=
radict
>> yourself. I don't know what caused you to get confused over the month.
>>
>> In it, you tell David to move *LSM* bits into security_lsmxattr_add(), w=
hich has
>> been done in patch 2. Thus, by your own characterization, it means the r=
est is
>> *not LSM* code.
>>
>> Quoting you verbatim:
>> > As I said previously, if you absolutely insist on the kfunc being in
>> > the VFS kfunc file, the LSM specific bits need to be abstracted out
>>                         ^^^^^^^^^^^^^^^
>> > into an LSM function.
>>
>> You yourself made the point in that same email that the kfunc can stay i=
n the
>> current file once LSM bits were moved out, and your request was honored.
>>
>> At this point, anybody reading this thread will only see your position a=
s a way
>> to undermine David's work and waste everyone's time, such that you can g=
rind an
>> axe against BPF folks. It's a repeating pattern.
>
> It seems foolish to speculate on what *everyone* reading this thread
> might be thinking, but since the discussion has decayed to the point
> where we are spelunking archives for quotes, let me provide my comment
> from David's v5 patchset where I explain myself:
>
> "I'm sorry David, now that I'm seeing this function again, especially
> with the LSM specific bits extracted into a LSM function, this absolutely
> belongs somewhere under security/.  It's only callable from within a
> BPF LSM callback and all it does outside of some BPF pointer boilerplate
> is call right back into a LSM helper function."

I think you keep forgetting that you cannot unilaterally decide this. Both =
VFS
and BPF people have told you that it does not make sense. What was clearly =
LSM
specific code has been moved under security/ already.

It's all BPF code otherwise, and topical for the VFS subsystem, hence it sh=
ould
stay there. That is why it's a VFS kfunc. The rest of the kernel calls LSM =
APIs
and hooks, but it does not make them LSM code.

It needs to be reviewed by VFS and BPF maintainers. Yes, it's only called f=
rom
BPF LSM callbacks, but plenty of kfuncs for those are already outside secur=
ity/.

The right way to do address that is to get people who added and maintain th=
at
code to agree with you, not take the work of unsuspecting contributors host=
age
to meet your goals, and threatening to block their work.

And to set expectations, it is clear people do not agree with your stated m=
ove.
When everyone tells you that you are wrong about something, sometimes, it i=
s
helpful to revisit your position.

>
> You are welcome to view that however you like.  I saw the v5 patchset
> and the nature of the kfunc became painfully obvious to me so I
> changed my opinion.

I think you have difficulties in recognizing that a piece of code can be
cross-cutting, and affect several subsystems at once. The code that was cle=
arly
belonging to LSMs was already moved in patch 2. The unrelated stuff is wher=
e it
has belonged in the past already, so that it can be reviewed by the right f=
olks.

The best course of action IMO is channeling your version from 1 month ago, =
where
you saw things more clearly, and help everyone move forward with this by la=
nding
the first two patches once you think they are in good shape. We will then t=
ake
the rest through BPF tree. It will be a better, more productive outcome for=
 everyone.

If you cannot do that, let's agree to disagree and not waste each others' t=
ime.
We will work on figuring out some other way to help David.
