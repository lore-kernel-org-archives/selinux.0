Return-Path: <SRS0=RXLG=5B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF5AC2BB1D
	for <selinux@archiver.kernel.org>; Mon, 16 Mar 2020 19:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A7320753
	for <selinux@archiver.kernel.org>; Mon, 16 Mar 2020 19:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn4ERgJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbgCPTY6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:24:58 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:37988 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732366AbgCPTY6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Mar 2020 15:24:58 -0400
Received: by mail-wm1-f52.google.com with SMTP id t13so13043604wmi.3
        for <selinux@vger.kernel.org>; Mon, 16 Mar 2020 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=98sTTJqA9eJs2IZWPtD4hKVVaSm6jJ7mR4bpAgcrhxE=;
        b=Rn4ERgJLi7jmMBRjf2ovpTBx9dSl45NpJkBgenkdYJVdmWzWYq0TJpTchISsppXtib
         L2hwnwWtZT8tSJTFurLWcH0Fcu6RwC2EAucoScmwLtf17oRxbnDfJbxEJ9dsLOVr9okb
         XZbSY3UjXCDo87v69SlShIZ7IqCBhYjQv87fGuB/PYXvEKAYJNBlzHsmkuePIUeHQugo
         UZ/+iy6TdUZP11iec5MbvuROTDqtZBpdlRzH8IqrB40BgufsrT6LsH3lysqX8x/3JSL9
         f9QYR/cS+EaKwV25ldRxG1FLUMzm3ualcp9SCJbLPFcbXEXvUn3QIIy2s2X2zWULdFXz
         malg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=98sTTJqA9eJs2IZWPtD4hKVVaSm6jJ7mR4bpAgcrhxE=;
        b=Nggjr1YdbY0dFyecV75GyDvHXmgAoXABv3oyToSUwYZa4fKU/dfOecjATu5LcAwmJk
         pmc0dD/kk08JxQ4q0LfHMXj+jNwgj7x9v52dBj+VT0ViAAu90w2CIQOp9tNnEg8nVvfK
         OzKpJr+ZOnTP0thfmQ2xskOsS3pRq7BuJQkBHFPwR1vTF/UtoPiIdN/Ax0qukstZAMFO
         k+ECnnUmZewCMnFOMpAyV6fipgJgRyp/zpeWheXbOO1OLWTt5ovjg5EBVZXn3m//IXuW
         LTuXmbulCDUtrEHz+WvLniuLPy9Ioj/n9rBKb+QyocEGQXQQRazLbQyXxXSytrcA9Feh
         Wpiw==
X-Gm-Message-State: ANhLgQ1oj1E69kYufhBIlWW3ln+aQMuDrDdc94elKDs0ZQrR5Z8nT97G
        dFL37SKuwbB/5V7oPqun+wB/ZWQ+
X-Google-Smtp-Source: ADFU+vu3UInsrbIkFSadwn2AmEQa0lb7T5zM5b+iBT/R9m0MWMhFgMVuEA6jtxFrHPHyzgZE/QLHNg==
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr661959wmb.8.1584386695809;
        Mon, 16 Mar 2020 12:24:55 -0700 (PDT)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id r18sm1196823wro.13.2020.03.16.12.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 12:24:55 -0700 (PDT)
From:   Dominick Grift <dac.override@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     selinux@vger.kernel.org
Subject: Re: Policy module to allow a domain transition
References: <Pine.LNX.4.44L0.2003161146070.8175-100000@netrider.rowland.org>
Date:   Mon, 16 Mar 2020 20:24:54 +0100
In-Reply-To: <Pine.LNX.4.44L0.2003161146070.8175-100000@netrider.rowland.org>
        (Alan Stern's message of "Mon, 16 Mar 2020 12:04:48 -0400 (EDT)")
Message-ID: <87y2s0gl15.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> If this is not the the right forum for this discussion, please redirect
> me to some place more appropriate.  Where to go for good advice on the
> trickier details of selinux is not obvious.
>
> The setting is CentOS 8.1.  I'm running tcpserver as a systemd service.  
> tcpserver is a general-purpose Internet (actually TCP) service 
> dispatcher, rather like inetd.
>
> In this case, I'm trying to use tcpserver as an entryway to sshd.  It 
> works fine when selinux is in permissive mode but fails in enforcing 
> mode.  According to audit.log, the error is:
>
> type=AVC msg=audit(1584123331.011:167): avc:  denied  { dyntransition } for  pid=2002 comm="sshd" scontext=system_u:system_r:unconfined_service_t:s0 tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=process permissive=1
>
> I take this to mean that tcpserver runs in the unconfined_service_t 
> domain (confirmed by ps -Z), that when it execs the sshd program it 
> doesn't make the transition to the sshd_t domain, and consequently sshd 
> is prevented from doing what it wants.
>
> audit2allow's recommendation is:
>
> 	allow unconfined_service_t unconfined_t:process dyntransition;
>
> which probably would work, but it seems like treating the symptom
> rather than the disease, not to mention opening up a fairly large
> security hole.  I'd like something a little more specific, particularly
> since I want to run one or two other services under tcpserver in
> addition to sshd.
>
> Probably the best approach would be to create a new tcpserver_t type
> with all the appropriate policies, but that's beyond my current skill.  
> Would it make sense to create a policy module that would simply allow
> unconfined_service_t to transition to sshd_t?
>
> And what would the source for such a policy module look like?  The 
> impression I get is something like:
>
> 	allow unconfined_service_t sshd_exec_t:file { execute
> 		execute_no_trans getattr ioctl map open read };

That would be redundant. unconfined_service_t already has broad access
and from a unconfined_service_t perspective you just need to tell
selinux what to do:

type_transition unconfined_service_t sshd_exec_t:process sshd_t;

That will tell selinux that processes types should transition from
unconfined_service_t to sshd_t when processes with type
unconfined_service_t execute files with type sshd_exec_t.

When you do this and try it out then some avc denials will likely
surface regarding access that sshd_t processes may need to
unconfined_service_t processes. (for example sending a child terminated
signal, but possibly others as well)

>
> basically just a copy an existing policy for inetd_t and 
> sshd_exec_t.  Is that the right way to go about this?  Is there 
> something better?
>
> Thank you,
>
> Alan Stern
>

-- 
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
