Return-Path: <SRS0=xXH+=5C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60C0C1975A
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 19:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E26920738
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 19:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+zmUpc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQTj2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:39:28 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:53124 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQTj2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Mar 2020 15:39:28 -0400
Received: by mail-wm1-f45.google.com with SMTP id 11so598478wmo.2
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2020 12:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sbJcjhEMPPsf2pknoxl27a3pQT0aCwJ5287DMi5nx3E=;
        b=a+zmUpc3W5r6Y1DTcoOLkS4fLiqsKuwXUtQ8poofMntFbjlonjjSzNwy1+gj+jW5jB
         2zEr5IDdrYoxxOdZosh1+lYA9x2wq+9PUzue2gRxur0iZTwDZ/+qC7txZnZo2gbj7zrh
         h1Fo/V4AbScWX/AqhmuU6ZSjGhNNY0E4kbH+eNlEvQqbnQGyKBYKTaHc1rLLEadMCUAi
         er5V1yaYPnQJSWZHD/rFUmj20EZjaAUjCHr0/1O5knyYFCtGy0cFiM0b4+DpNaqguMnh
         eroda0si2VBR51fOjVpH+iP6WsrNNlHC/f7sl1rCyfA5+5paq7QGRqInaNXG8aDdiCVy
         CZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=sbJcjhEMPPsf2pknoxl27a3pQT0aCwJ5287DMi5nx3E=;
        b=kAIY6m5WtllZXU5D1fwX2JZ0HLnF1IdCfv4lx6NpF7/Xc2XJKAJlg7pjYoMA5lmvPz
         oyrj5XJKrssPIF1/omG92BLm/1WV8hNsfnb8vLUvfzLt3QTA0BqbdsqmL1sGB6hnYRhF
         WDsEdUdyodwYev1H/q+VrhIDfTC/V3I0vV+vIAPVFxwcUz4w33JPCZpgodHU2uhLB5f8
         qabj7VPI2CISrKagVwMdKdT3DLqZO4KE1mFnGvoizdVAz59bFiKGh1wUgil/0bByfhuu
         YWSZblkHa0Rcb97nhKMuT3JTYv3qB5k8QRwXfTpyZ5U7DdhN4lpejwUagpVg8FZJV2wg
         lp+A==
X-Gm-Message-State: ANhLgQ38g2ifugeXdwStpTHeGwCKwQHi934LhHaPSWyR7tO+b/fwE6VM
        +o5rfk+QYKMGKPxEDryyj5N0bBMg
X-Google-Smtp-Source: ADFU+vvlGBDKGN9dtGkwvw19MPtFiLhk+Zg8SoewHNhIvr/I2+v1d52YCRQThvM2b3czgF9QVXpRlQ==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr605659wmc.171.1584473964855;
        Tue, 17 Mar 2020 12:39:24 -0700 (PDT)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id x17sm2558875wrt.0.2020.03.17.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 12:39:23 -0700 (PDT)
From:   Dominick Grift <dac.override@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     selinux@vger.kernel.org
Subject: Re: Policy module to allow a domain transition
References: <Pine.LNX.4.44L0.2003171515120.21801-100000@netrider.rowland.org>
Date:   Tue, 17 Mar 2020 20:39:22 +0100
In-Reply-To: <Pine.LNX.4.44L0.2003171515120.21801-100000@netrider.rowland.org>
        (Alan Stern's message of "Tue, 17 Mar 2020 15:30:15 -0400 (EDT)")
Message-ID: <87h7ymhitx.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Tue, 17 Mar 2020, Dominick Grift wrote:
>
>> Alan Stern <stern@rowland.harvard.edu> writes:
>> 
>> > On Mon, 16 Mar 2020, Dominick Grift wrote:
>> >
>> >> Alan Stern <stern@rowland.harvard.edu> writes:
>> >> 
>> >> > If this is not the the right forum for this discussion, please redirect
>> >> > me to some place more appropriate.  Where to go for good advice on the
>> >> > trickier details of selinux is not obvious.
>> >> >
>> >> > The setting is CentOS 8.1.  I'm running tcpserver as a systemd service.  
>> >> > tcpserver is a general-purpose Internet (actually TCP) service 
>> >> > dispatcher, rather like inetd.
>> >> >
>> >> > In this case, I'm trying to use tcpserver as an entryway to sshd.  It 
>> >> > works fine when selinux is in permissive mode but fails in enforcing 
>> >> > mode.  According to audit.log, the error is:
>> >> >
>> >> > type=AVC msg=audit(1584123331.011:167): avc:  denied  { dyntransition } for  pid=2002 comm="sshd" scontext=system_u:system_r:unconfined_service_t:s0 tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=process permissive=1
>> >> >
>> >> > I take this to mean that tcpserver runs in the unconfined_service_t 
>> >> > domain (confirmed by ps -Z), that when it execs the sshd program it 
>> >> > doesn't make the transition to the sshd_t domain, and consequently sshd 
>> >> > is prevented from doing what it wants.
>> >> >
>> >> > audit2allow's recommendation is:
>> >> >
>> >> > 	allow unconfined_service_t unconfined_t:process dyntransition;
>> >> >
>> >> > which probably would work, but it seems like treating the symptom
>> >> > rather than the disease, not to mention opening up a fairly large
>> >> > security hole.  I'd like something a little more specific, particularly
>> >> > since I want to run one or two other services under tcpserver in
>> >> > addition to sshd.
>> >> >
>> >> > Probably the best approach would be to create a new tcpserver_t type
>> >> > with all the appropriate policies, but that's beyond my current skill.  
>> >> > Would it make sense to create a policy module that would simply allow
>> >> > unconfined_service_t to transition to sshd_t?
>> >> >
>> >> > And what would the source for such a policy module look like?  The 
>> >> > impression I get is something like:
>> >> >
>> >> > 	allow unconfined_service_t sshd_exec_t:file { execute
>> >> > 		execute_no_trans getattr ioctl map open read };
>> >> 
>> >> That would be redundant. unconfined_service_t already has broad access
>> >> and from a unconfined_service_t perspective you just need to tell
>> >> selinux what to do:
>> >> 
>> >> type_transition unconfined_service_t sshd_exec_t:process sshd_t;
>> >> 
>> >> That will tell selinux that processes types should transition from
>> >> unconfined_service_t to sshd_t when processes with type
>> >> unconfined_service_t execute files with type sshd_exec_t.
>> >> 
>> >> When you do this and try it out then some avc denials will likely
>> >> surface regarding access that sshd_t processes may need to
>> >> unconfined_service_t processes. (for example sending a child terminated
>> >> signal, but possibly others as well)
>> >
>> > Yes, I see what you mean.  I'm getting AVC violations because sshd 
>> > isn't supposed to perform getattr and setopt actions on a tcp_socket of 
>> > type unconfined_service_t, which is what it gets when it inherits a 
>> > socket from tcpserver instead of opening the socket itself.
>> >
>> > It looks like the tcp_socket needs to undergo a type transition along
>> > with the process.  Is there any way to express this?
>> 
>> tcpd would have to grow selinux awareness and do that manually using the
>> setsockcreate() functionality provided by libselinux.
>> 
>> systemd does this with its socket activation functionality.
>
> All right, so rather than try to change the programs, I added the
> following TE rule:
>
> allow sshd_t unconfined_service_t:tcp_socket { getattr setopt };
>
> With that, sshd under tcpserver worked okay in permissive mode, with no
> AVC notices in audit.log.  But when I changed to enforcing mode, the
> program failed for no apparent reason (and again, no AVC messages).  
> The remote system merely reported "Connection reset by peer".  Any idea
> what's wrong?

You can run `semodule -DB` to make SELinux more verbose. (use `semodule
-B` to make SELinux less verbose when youre done)

My guess is that some socket accesses are silently blocked. Is a long
story but the socket read and write accessed might be silently blocked
because they are often false positives caused by leaked file
descriptors.

In this case the read write on tcp_socket would be legit and would need
to be allowed.

So if you do a `semodule -DB` then reproduce a login, then look for avc
denials related to sshd_t, unconfined_service_t and tcp_sockets (my bet
is on read and write) but eventually sshd obviously also needs to
"accept" connections as well. In other words: "tcp_socket { getattr
setopt }" is incomplete but the next access attempts (read/write) are
silently blocked by policy and so without that it cannot do its job.

>
> Alan Stern
>

-- 
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
