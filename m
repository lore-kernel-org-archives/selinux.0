Return-Path: <SRS0=RXLG=5B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06182C0044D
	for <selinux@archiver.kernel.org>; Mon, 16 Mar 2020 20:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C202020674
	for <selinux@archiver.kernel.org>; Mon, 16 Mar 2020 20:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6sxVAYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbgCPUo2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:44:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40590 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbgCPUo2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Mar 2020 16:44:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id f3so15995598wrw.7
        for <selinux@vger.kernel.org>; Mon, 16 Mar 2020 13:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1B22v6/xuR3ac9fU//VCYBQOpyNRAL4QP+y5rzZLyHM=;
        b=G6sxVAYDsIRZSGTKQFoC5w7bhfu2MVSa2VwvzChnpYceBCUFQFv/NccFcT7gQ++ZuD
         3yst0Ddao27L3JA2ng7d7Aao/is0fQqSrLW8Qwvnm9gB1isPfkPD3QBwaaxvr1MmvPq8
         tTa61Rof8osuyuQcP97dsNJ/Z90l40vejc+JuJYr/6Wr/5OvGLqjFHcEhbmxDL40gH0B
         FNfSKlqRcIr57yaUcoKikIjTURVEv8+zzbBeNz6I/RUKCYa/BPKvXWpf+LpdtugESTAy
         OJtXF8vrvRPUwTaSuBJbO5DWytvYDmDOifL9xnb3vTrdteK+3c9dW+ol4VOLwkHfBX8b
         zqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=1B22v6/xuR3ac9fU//VCYBQOpyNRAL4QP+y5rzZLyHM=;
        b=j3AHSPFs9LJFt6wwMb9CHrmZDvJVVmu+VYd9SMRrNCc0x/J/YyPwF0oadflsCM379/
         rArkW/6E6AM2aBns2wtWHUTkLtB6b2IiEOcnv2AVvGdHLxX7e8sgi7jvljVHYd7KwCtm
         kY1CtcUwrOrtXcijEd3a9jTEngQ4C9FpgGj0SJ4LYk6+RPEK9oIrssrVKfUg58djm9PE
         pV10BGDxWrVmsyB5nMuYd/VXGTOSzvEOZDzNdvIp3FDF5CfFy+jFSI6NWYHUmpRtV1bz
         9EqV0VesTbliUetuydbxKlUGNGobkYsbtmRV56eXvtxhJII77lSG7P0HDNjsondxJHfA
         dYgw==
X-Gm-Message-State: ANhLgQ3MG2kzmy/qMnGHAkDx5+m1yRM+SBJRYYt7dEOCF97v2Xg6I22b
        xkzHo+5cxRuEuYGyXBCDWLuYy+WO
X-Google-Smtp-Source: ADFU+vtMm+BiGphZoPOOg9Yw+F9ydajaMwpaU42XCEqS4oXsZYCrr34m7H71KY1zLhGypTGEzHh8Zw==
X-Received: by 2002:a5d:68d1:: with SMTP id p17mr1344561wrw.56.1584391465171;
        Mon, 16 Mar 2020 13:44:25 -0700 (PDT)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id k84sm1124866wmk.2.2020.03.16.13.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 13:44:24 -0700 (PDT)
From:   Dominick Grift <dac.override@gmail.com>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, <selinux@vger.kernel.org>
Subject: Re: Policy module to allow a domain transition
References: <Pine.LNX.4.44L0.2003161146070.8175-100000@netrider.rowland.org>
        <c9b092e8-caa5-52dd-1efb-1a5ab324a68f@sony.com>
Date:   Mon, 16 Mar 2020 21:44:21 +0100
In-Reply-To: <c9b092e8-caa5-52dd-1efb-1a5ab324a68f@sony.com> (peter
        enderborg's message of "Mon, 16 Mar 2020 21:20:18 +0100")
Message-ID: <87tv2oghcq.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

peter enderborg <peter.enderborg@sony.com> writes:

> On 3/16/20 5:04 PM, Alan Stern wrote:
>> If this is not the the right forum for this discussion, please redirect
>> me to some place more appropriate.  Where to go for good advice on the
>> trickier details of selinux is not obvious.
>>
>> The setting is CentOS 8.1.  I'm running tcpserver as a systemd service.=
=20=20
>> tcpserver is a general-purpose Internet (actually TCP) service=20
>> dispatcher, rather like inetd.
>>
>> In this case, I'm trying to use tcpserver as an entryway to sshd.  It=20
>> works fine when selinux is in permissive mode but fails in enforcing=20
>> mode.  According to audit.log, the error is:
>>
>> type=3DAVC msg=3Daudit(1584123331.011:167): avc:  denied  { dyntransitio=
n } for  pid=3D2002 comm=3D"sshd" scontext=3Dsystem_u:system_r:unconfined_s=
ervice_t:s0 tcontext=3Dunconfined_u:unconfined_r:unconfined_t:s0 tclass=3Dp=
rocess permissive=3D1
>>
>> I take this to mean that tcpserver runs in the unconfined_service_t=20
>> domain (confirmed by ps -Z), that when it execs the sshd program it=20
>> doesn't make the transition to the sshd_t domain, and consequently sshd=
=20
>> is prevented from doing what it wants.
>>
>> audit2allow's recommendation is:
>>
>> 	allow unconfined_service_t unconfined_t:process dyntransition;
>>
>> which probably would work, but it seems like treating the symptom
>> rather than the disease, not to mention opening up a fairly large
>> security hole.  I'd like something a little more specific, particularly
>> since I want to run one or two other services under tcpserver in
>> addition to sshd.
>>
>> Probably the best approach would be to create a new tcpserver_t type
>> with all the appropriate policies, but that's beyond my current skill.=
=20=20
>> Would it make sense to create a policy module that would simply allow
>> unconfined_service_t to transition to sshd_t?
>>
>> And what would the source for such a policy module look like?  The=20
>> impression I get is something like:
>>
>> 	allow unconfined_service_t sshd_exec_t:file { execute
>> 		execute_no_trans getattr ioctl map open read };
>>
>> basically just a copy an existing policy for inetd_t and=20
>> sshd_exec_t.  Is that the right way to go about this?  Is there=20
>> something better?
>
> The hole idea with MAC is that you should explicit declare what is allowe=
d.

I do not agree with that. The idea of MAC is Mandatory (centralized) Access
Control. The idea of SELinux is "Flexible MAC". Least privilege is an optio=
n.

>
> Starting with anything=C2=A0unconfined is a bad idea for anything that is=
 seen
> from the internet. If you do it for the security your tcpserver should ha=
ve it's own
> domain that is not unconfined. And then you can give rules on what it is =
allowed
> to start.=C2=A0 So you need to create a tcpservice_service_t, so your rul=
e should be

Op made it clear that this is not an option right now. Also keep in mind
that tcp server listens on behalf of sshd which will be confined once
SELinux transitions tcpserver from unconfined_service_t to sshd_t as per
my example earlier.

It is not ideal, granted, but there are subtile details to
consider. Things are either black or white.

>
> allow tcpservice_service_t sshd_exec_t:file { execute
> 		execute_no_trans getattr ioctl map open read };
>
> /* execute_no_trans is probably not what you want */
>
> =C2=A0But you do NOT want
>
> allow tcpservice_service_t unconfined_t:process dyntransition;
>
>
> On fedora it would be like:
>
> allow tcpservice_service_t sshd_t:process dyntransition;
>
> and sshd is then allowed to create unconfined shell or what ever.
> =C2=A0
>
>> Thank you,
>>
>> Alan Stern
>>
>>
>

--=20
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0xDA7E521F10F64098
Dominick Grift
