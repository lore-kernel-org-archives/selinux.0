Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27440C432C0
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 09:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF3620727
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 09:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbOkkN80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfKRJdB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:33:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20594 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726464AbfKRJdB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 04:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574069579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ne6YDHO+RAdb54DoQA9570AfMQSKjRY/97iBK2vLerw=;
        b=PbOkkN80i0/scnA8A0mDF9WgD9INrl0Lnex+40Sl/AskJr4jm0lYHYOtmzqO1heCFbd3oC
        wRwFC1NvRFJbK7Os0314D+LCixIgo6k4Qiv0owmULqnIqf72lmmC7MF8DJD8Hqyu/fbI28
        3I1rygAHNh2Y5CEq5PeB2F71DAENZBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-JT5Ou0pFMrW7j0pfi4C9TQ-1; Mon, 18 Nov 2019 04:32:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34CB3107ACC7;
        Mon, 18 Nov 2019 09:32:54 +0000 (UTC)
Received: from localhost (unknown [10.43.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A075660856;
        Mon, 18 Nov 2019 09:32:53 +0000 (UTC)
References: <20191115145425.1460016-1-plautrba@redhat.com> <6ce96a14-0be8-5829-7fa4-e84d7f33c678@tycho.nsa.gov> <CAJfZ7=mBDX3c9rM42qYvsQebKV6MA_YGvSMmbu2BtCrjCAXZDg@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH] dbus: Fix FileNotFoundError in org.selinux.relabel_on_boot
In-reply-to: <CAJfZ7=mBDX3c9rM42qYvsQebKV6MA_YGvSMmbu2BtCrjCAXZDg@mail.gmail.com>
Date:   Mon, 18 Nov 2019 10:32:52 +0100
Message-ID: <pjdd0dpedh7.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: JT5Ou0pFMrW7j0pfi4C9TQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Fri, Nov 15, 2019 at 4:01 PM Stephen Smalley <sds@tycho.nsa.gov> wrote=
:
>>
>> On 11/15/19 9:54 AM, Petr Lautrbach wrote:
>> > When org.selinux.relabel_on_boot(0) was called twice, it failed with
>> > FileNotFoundError.
>> >
>> > Fixes:
>> >      $ dbus-send --system --print-reply --dest=3Dorg.selinux /org/seli=
nux/object org.selinux.relabel_on_boot int64:1
>> >      method return sender=3D:1.53 -> dest=3D:1.54 reply_serial=3D2
>> >      $ dbus-send --system --print-reply --dest=3Dorg.selinux /org/seli=
nux/object org.selinux.relabel_on_boot int64:0
>> >      method return sender=3D:1.53 -> dest=3D:1.55 reply_serial=3D2
>> >      $ dbus-send --system --print-reply --dest=3Dorg.selinux /org/seli=
nux/object org.selinux.relabel_on_boot int64:0
>> >      Error org.freedesktop.DBus.Python.FileNotFoundError: FileNotFound=
Error: [Errno 2] No such file or directory: '/.autorelabel'
>> >
>> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> > ---
>> >
>> > Note: This is python 3 only code and it fails in travis with PYVER=3Dp=
ython2.7 RUBYLIBVER=3D2.6:
>> >
>> > $ PATH=3D"$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8
>> >
>> > Analyzing 187 Python scripts
>> >
>> > ./dbus/selinux_server.py:90:20: F821 undefined name 'FileNotFoundError=
'
>> >
>> > ./installdir/usr/share/system-config-selinux/selinux_server.py:90:20: =
F821 undefined name 'FileNotFoundError'
>> >
>> > The command "PATH=3D"$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8" exi=
ted with 1.
>>
>> Hmm...given that, do we want to defer it until after 3.0 final release,
>> or are we going to switch travis over to only test with python3 now?
>

I'd switch it now so it won't report false positives after this patch is
applied.


Also I'll add explicit note to release notes about dropping support for
python 2.


> Hello, I personally do not have a strong opinion about dropping Python
> 2 support before or after 3.0 final release (for information, the Arch
> Linux packages will be Python 3-only anyway, because the distribution
> maintainers began dropping related Python 2 packages such as
> python2-audit).
>
> Nevertheless, on the patch itself, I am wondering whether
> "FileNotFoundError" could be replaced with "OSError" in order to make
> it compatible with Python 2. The main drawback of this alternative
> approach is that it silences PermissionError and other kind of errors
> that could be useful when debugging some issues on a production
> system. This is why I prefer keeping "FileNotFoundError", and the
> patch looks good to me.
>

I've considered OSError, but I don't like the fact that it would silence
PermissionError and others just for sake of Python 2 which won't be
maintained after end of this year.

>> >
>> >   dbus/selinux_server.py | 5 ++++-
>> >   1 file changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
>> > index b9debc071485..be4f4557a9fa 100644
>> > --- a/dbus/selinux_server.py
>> > +++ b/dbus/selinux_server.py
>> > @@ -85,7 +85,10 @@ class selinux_server(slip.dbus.service.Object):
>> >               fd =3D open("/.autorelabel", "w")
>> >               fd.close()
>> >           else:
>> > -            os.unlink("/.autorelabel")
>> > +            try:
>> > +                os.unlink("/.autorelabel")
>> > +            except FileNotFoundError:
>> > +                pass
>> >
>> >       def write_selinux_config(self, enforcing=3DNone, policy=3DNone):
>> >           path =3D selinux.selinux_path() + "config"
>> >
>>


--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

