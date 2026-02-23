Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCDF3396E9
	for <selinux@vger.kernel.org>; Mon, 23 Feb 2026 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870611; cv=pass; b=Hi+iZrrFCny1MO+oSr/TrJbd4kGyYAVPZZ/SrfQqsUyY80VvwSZBs8upWLfoLjPYKr+u34RzmKD36QJA7NlE+llbcL26oj7MUoQEZW9tROXipXpLs8GUxTk4UOBefVavwAAmEcm9j8lO52iVmV+9HwmCw//xDINMw5UV/PUi/WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870611; c=relaxed/simple;
	bh=ccMr0y5dim90uRB9hZgV/H0P3HJMVHu7XUE6+oVOavU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mx0KBewp2Cz7FeIh6piMAmA10uYlsRv863LfrfMHht5pvnUuZGHUnixazmkD8GMQoatvgcG2j+49EHNurxjHmSx1+TJjBSesE6eOtQrp+/ZgkJ/E5W7OnPn/GqN/MQ9fiDcJ18MmB8KgxMng4QbjEkSnU5xmiCrGODzCm5MPXJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIBY3H2J; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIBY3H2J"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3530715386cso3818672a91.2
        for <selinux@vger.kernel.org>; Mon, 23 Feb 2026 10:16:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771870610; cv=none;
        d=google.com; s=arc-20240605;
        b=GkyzKXRSf49+O241/SelgB45Zj7V1x4s/DIMPDSuXqwnlfozGoUdQx+KlspKVN5JWn
         X7wsPx6v/JLx5BdCsLzR0+5mfx392MaYjdPa6MQaz8KQ42uAnCdBIG2Oq3qVrJQrwySD
         HEVf/nLX0C8UVL2AWAsoNVZg24F8jRgRfB/Mb14GnbBelwFfhaT5uAiadzqqTAatjbza
         wuduLmBzq8HyyUoEJ2uyNSyNGwPCwud11pFYxwdalWEv42VpFTwr+efwJBGtNjUOPxEa
         GXJ5Hor/ceBmmB4kxIsilDWjbictvz38WhDa1t0bh8XxPjyKlxv9ZkrxyKrFFrjjHhHD
         5+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WR5/isHJi+p+zaqIgVM6heHWbx8BffiQCVHOVHy8bls=;
        fh=BawarOUyYa4MjdWkcdupHeXlGj90HG96LMuvxJG17Po=;
        b=jp79aALfgLMCJf9SzG1XxlaouOm+1mAx7z8xhiACNvBNaTReWw5qQcJElK8pyjTEAE
         AcVDMM2ioT8Lyl8LyOnjVKtEPjYuQu7ppC2+wrc4jY6r7gS6RNj9EAzQyPq2gon9k+J5
         0hFsxTeZwmZxj2vJQHdkzqFZux/HRgyy7ketXYQ92Aei/uA6KpLRVLor1i2lqCttzc8j
         1KbzTFNy8bL33RCSj/V7MFkl7xNl9fDfdpSxAPg5eyJsNelk/jwcR4rfILVFcwgfnZrs
         7Ykp/FKNh0EriUYbk9s/I0IFWir/P9MOnu1VsY5nJLawyDTH1DWvlWrz12TxkuUB18Mn
         FhbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771870610; x=1772475410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR5/isHJi+p+zaqIgVM6heHWbx8BffiQCVHOVHy8bls=;
        b=AIBY3H2JLRtwac9dG5bObXu9PgN5gsN5zkhckcMd5Kgjf6Ssy1K1TfQQugnBgV7/cd
         HG8VuYdv8AYAR037yvoSz09eC/yFRePyXnSwOBtdCBQPsFqH+SWtV9okM/p2zNRX+X28
         7gJGwKkfjYqjtSlMCmydera85E9yxgAaFEGEHXelS8YymxnD5nIUSmBL6wKyc0/6iBt1
         15oQfz0Qu1s2KTvJoEtcYf76QF71PWNZAgx8KBK8AE2I3ooB4L4kG++cwjsWA9JYR51v
         PpO1pbVip6sWxmvxW2+4Q48DGrgDDuvmIg98B/1RC47O0OBY+iw9fXnnEgxiSU2dVYfD
         SbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771870610; x=1772475410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WR5/isHJi+p+zaqIgVM6heHWbx8BffiQCVHOVHy8bls=;
        b=jrxvUYwyhtfMeFwA/z0x+5byoaiQnAA0/BI7l60ojPapet/zbBVAntoQLalnC37UF/
         WgFyNRPjM4gHOwxCyNhWFq3UpeunsRrB5nybHSdX7MCob/IJ8jwkeEDc9PkXZmFsO6NP
         9al09TXvNMtbHJLBhY3yN0mA332Ki03iGwdTITDAknc0On1l0mYy2Malr0vBAGBSQmI8
         SNJipfbV7rhFIWBgi+c03P4LE2j0fio4JEIR3h0qOUM/ZD4HaVA2fnF/2IWHAIJWhxby
         9J8jTaJHiZXx5+snwyWuQaSJLXXf3V35UzU3fxE25tq1YnJZmP/dd0990mP+wC/zNh0Q
         qRbA==
X-Gm-Message-State: AOJu0YzlFrAvk6BLu8eqzNd+pTJuPzoLeM2U640bg12VLijoHyOT/LRi
	CV0Fg04TAGfQ3HkBjwtgJgXlgWtbxj/Nis6u1c//tWETrwx/rQbnkKgWq6fHgROqkAChKEu/s68
	JsitpIfXfA6D8HTmdI2D47Zl8hWXHhf13Qw==
X-Gm-Gg: ATEYQzzhEN9e77rO+IxMdwO8n1O5TMT3DA15AyzN7DkiyBZPMTj9+o07abnbC4OZoyY
	oMLnwrxWJ6d7etE0F1fb0sNd0rV69zZ1AQUt833Wojc6Z8PswVmh87TXApmeVjZg3yfbqTncIe5
	Fy6YMJGJpfqIy1YmWFA9yrBUU6pKIz0Wmkg3tldeu+pKncAg2ddTF2w/wkXmNJEmlzWth0Wt64g
	XtyTSj24aDKyPudjbfR0rerROk0zvYkp6xBuBK4Y1g2G+xU+LBOozKASU+xFR7GtwhwsGf7SZTb
	NFyMcZqa3PquxSJJ/Q==
X-Received: by 2002:a17:90b:5410:b0:340:ca7d:936a with SMTP id
 98e67ed59e1d1-358ae8a87e3mr9084711a91.18.1771870609620; Mon, 23 Feb 2026
 10:16:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH3PPF7A88A980A236C1D23F1FDB87FAA2CF39BA@PH3PPF7A88A980A.namprd11.prod.outlook.com>
 <CAEjxPJ4BP1isHT2T0sL1K58bLycwocG8FGFK2OSrkA6Qc3Pxag@mail.gmail.com> <PH3PPF7A88A980A2ECF46C2CF01AF290FEBF377A@PH3PPF7A88A980A.namprd11.prod.outlook.com>
In-Reply-To: <PH3PPF7A88A980A2ECF46C2CF01AF290FEBF377A@PH3PPF7A88A980A.namprd11.prod.outlook.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 23 Feb 2026 13:16:38 -0500
X-Gm-Features: AaiRm52xFkAbHqCH8hhpu8gFFApnIzLS9OxFaBA4Kub7RuqYfflLGTite7PxZCE
Message-ID: <CAEjxPJ6_kQDikuPi6uYZBg2UmPV0v5KR48N7rskBQ5HPnr22pQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Missing audits
To: Martin Bonner <Martin.Bonner@entrust.com>
Cc: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 11:47=E2=80=AFAM Martin Bonner
<Martin.Bonner@entrust.com> wrote:
>
> I'd like to start by apologizing for how long it has taken me to get back=
 to
> you.  I got distracted onto other, higher priority, tasks, and then it to=
ok
> ages to get back to being able to reproduce the problem.
>
> Answers inline below:
>
> > From: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Sent: 03 February 2026 20:19
> > To: Martin Bonner <Martin.Bonner@entrust.com>
> > Cc: selinux@vger.kernel.org
> > Subject: [EXTERNAL] Re: Missing audits
> >
> > On Tue, Feb 3, 2026 at 5:29=E2=80=AFAM Martin Bonner <mailto:Martin.Bon=
ner@entrust.com> wrote:
> >>
> >> Complete SELinux newbie here.  If I use a word that has a specific tec=
hnical
> >> meaning in the context of SELinux, please don't assume I understand wh=
at it
> >> means.
> >>
> >> I am working on an embedded system using buildroot with SELinux.  I ha=
ve
> >> changed a directory permission from world-read-search to world-no-acce=
ss,
> >> and my device now fails to start up correctly if SELinux is set to enf=
orcing.
> >> I know it is SELinux because if I don't set enforcing, everything is
> >> perfectly happy.
> >>
> >> Well, this is easy to diagnose you say - just look at the audit logs. =
 The
> >> trouble is, that the only thing in the audit logs is a bunch of audits=
 from
> >> all the "ls -laR" commands I was invoking, trying to debug what was go=
ing
> >> wrong with the permissions.
> >>
> >> Next try:  comment out all the "dontaudit" rules we had added (I left =
the
> >> ones in the base rule set alone).  These were mostly rules concerning =
fifo
> >> access -processes are invoking sub-processes, switching domains (is th=
at the
> >> right word?), and then they no longer have access to stdin/stdout/stde=
rr of
> >> the calling process (they don't actually need such access).  The freak=
y
> >> thing here was that although I got lots of audits about fifo accesses,=
 _all
> >> the audits about the debugging had disappeared_!
> >>
> >> What is going on here?  Is there some sort of configuration that will
> >> suppress an audit if another audit has been sent "too recently"?  Any
> >> suggestions to debug this?
> >>
> >> One additional complexity:  the access to the directory is (or should =
be)
> >> happening inside an lxc container (with luck this is irrelevant).
> >
> > audit messages can be lost on OOM or hitting the rate limit or backlog =
limit.
>
> I don't _think_ I am out of memory.  (It's embedded, but I've got about
> 8GBytes.)  What's the rate limit, what's the backlog limit?  Can I change
> either?

If set to non-zero (default is 0), the audit rate limit is the limit
of audit messages sent per second. If set to non-zero (default is 64),
the audit backlog limit is the limit of outstanding audit buffers,
i.e. buffers not yet processed by auditd. Both settable via auditctl
or in /etc/audit/audit.rules -r and/or -b options.
audit_backlog_limit can also be set via a kernel parameter. Probably
not your issue though if you aren't even seeing messages about audit
messages being lost.

>
> > When you say you looked at the audit logs, are you only looking at
> > what auditd has written out under /var/log/audit or also checking
> > journalctl, dmesg, or cat /proc/kmsg for any messages.
>
> I was only looking at /var/log/audit (well, the location we shifted that =
to).
>
> I don't have journalctl (that's a systemd thing isn't it - I'm not runnin=
g
> systemd).
>
> dmesg, and /var/log/messages, and the console output, all show the same f=
ew
> audit: messages - but none of them seem to be relevant, and they are all
> present regardless of the directory mode
>
> > Was the system working with SELinux in enforcing mode before you made
> > the change to the directory mode, or you hadn't tried it yet?
> Yes it was.  (Good question though.)
>
> >
> > Does your system look basically sane in terms of process and file
> > labels? If you have sestatus installed, what does sestatus -v report?
>
> Yes, the labels look reasonable.
>
> It reports as follows:  Note, I am running in permissive mode here becaus=
e
> that makes debugging much simpler, and I currently just want to find the
> text of the ***** audit.
>
> # sestatus -v
> SELinux status:                 enabled
> SELinuxfs mount:                /sys/fs/selinux
> SELinux root directory:         /etc/selinux
> Loaded policy name:             targeted
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy MLS status:              enabled
> Policy deny_unknown status:     denied

deny_unknown means deny any permissions not defined by your policy.
Did you get any SELinux: messages during policy load about unknown
permissions? Can you share all messages that start with SELinux: or
avc: from your dmesg or /var/log/messages or console output?

> Memory protection checking:     actual (secure)
> Max kernel policy version:      33
>
> Process contexts:
> Current context:                root:sysadm_r:sysadm_t:s0
> Init context:                   system_u:system_r:kernel_t:s0

The init process should re-exec or dynamically switch its context to
init_t after loading policy rather than staying in kernel_t.

> /usr/sbin/sshd                  system_u:system_r:sshd_t:s0
>
> File contexts:
> Controlling terminal:           root:object_r:user_tty_device_t:s0
> /etc/passwd                     system_u:object_r:etc_t:s0
> /etc/shadow                     system_u:object_r:shadow_t:s0
> /bin/login                      system_u:object_r:login_exec_t:s0
> /bin/sh                         system_u:object_r:shell_exec_t:s0
> /sbin/init                      system_u:object_r:init_exec_t:s0
> /usr/sbin/sshd                  system_u:object_r:sshd_exec_t:s0
>
> --
> Martin Bonner

> Any email and files/attachments transmitted with it are intended solely f=
or the use of the individual or entity to whom they are addressed. If this =
message has been sent to you in error, you must not copy, distribute or dis=
close of the information it contains. Please notify Entrust immediately and=
 delete the message from your system.

Please remove such statements from emails you post to public mailing
lists if you are able to do so.
