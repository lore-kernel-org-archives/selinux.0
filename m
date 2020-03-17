Return-Path: <SRS0=xXH+=5C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C5C18E5B
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 15:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5A920714
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 15:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRciRCqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCQPvn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:51:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38928 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQPvn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Mar 2020 11:51:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id h6so6009194wrs.6
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2020 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2QB4k9JCf4NxD2ttbVn82OApWT40ScHrPNoUECwlbM4=;
        b=fRciRCqpluOlR0nAoU/aLVl04YX4UJRyQQpj+EPxm2x5ZcZWp3kig8mWJNDDknFISO
         viAhPEtVmPZ9HY5C7hHcXEeqjjnpDzbRNIdU+H/f2+JgkOHZFprWvM334VdTkAR5IXfD
         vccIrRNHdlxdYtDz0daZgx32Zd9wRvGOWkU+ixs/tfWkHd1j6F9v0A9WcxZmrxvEB7W8
         /6tWnhmWS411HbKU4Bg1w5PwjRMzX6FR4QcsM9eDzZIhMcKUWmvmqp0qHv60AFmF310N
         +ddcOjbJ55O8wL7csDp13OxeQqsIJQFUnvL44PLCHscQvE+mGORg07bMmtdXzy7p/rjb
         /Dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=2QB4k9JCf4NxD2ttbVn82OApWT40ScHrPNoUECwlbM4=;
        b=B3Ax72RurD8CTdbH6H+FKWxzliyXluEvJNqCZiGNFZgRw49f+uQ4mdNkifXK4vtgVr
         SmCqrwh4i9vZ2H2X7mSbLSzEJnJp/iAOx3ow0W4+1izVURPO2M13juwkZvbdwexiyLvx
         2/UOnAkQ6+kdaeGdBLcVzXTWl6VrcA6Juz9FRX5+hT4OHYzlOGgDqvTjs9IFXUOQHDhT
         gUdcKMtq/rVTYHx9JpLSc485Bbvh46ZnZXxiJjCIIV7TJTSST64ynBoCM8xo9S+xxCfu
         HzMECoddrzWnUtUI9a1DzmSXzdI/MOW1FSCinBoGjBEgmE+x/Ljy3gEaPPuJGxNAncGu
         FAxA==
X-Gm-Message-State: ANhLgQ2iEHPp5NUOdH/htzsj6a23Sso84NO5jcAIioMS3w6DuOAg1KFo
        H0EuO0CXiGTkev0FQ8+j1GKR2x5U
X-Google-Smtp-Source: ADFU+vsFEKpYvIZ1LHhygRhV+hjEtxeQ0q8cz8F9erMof8cafqsAtSIfgG5AW1gSxy4OEDMDyQvpkg==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr6596546wrq.216.1584460298659;
        Tue, 17 Mar 2020 08:51:38 -0700 (PDT)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id u204sm4517406wmg.40.2020.03.17.08.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 08:51:37 -0700 (PDT)
From:   Dominick Grift <dac.override@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     selinux@vger.kernel.org
Subject: Re: Policy module to allow a domain transition
References: <Pine.LNX.4.44L0.2003170941070.23042-100000@netrider.rowland.org>
Date:   Tue, 17 Mar 2020 16:51:35 +0100
In-Reply-To: <Pine.LNX.4.44L0.2003170941070.23042-100000@netrider.rowland.org>
        (Alan Stern's message of "Tue, 17 Mar 2020 10:03:42 -0400 (EDT)")
Message-ID: <87lfnzget4.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Mon, 16 Mar 2020, Dominick Grift wrote:
>
>> Alan Stern <stern@rowland.harvard.edu> writes:
>> 
>> > If this is not the the right forum for this discussion, please redirect
>> > me to some place more appropriate.  Where to go for good advice on the
>> > trickier details of selinux is not obvious.
>> >
>> > The setting is CentOS 8.1.  I'm running tcpserver as a systemd service.  
>> > tcpserver is a general-purpose Internet (actually TCP) service 
>> > dispatcher, rather like inetd.
>> >
>> > In this case, I'm trying to use tcpserver as an entryway to sshd.  It 
>> > works fine when selinux is in permissive mode but fails in enforcing 
>> > mode.  According to audit.log, the error is:
>> >
>> > type=AVC msg=audit(1584123331.011:167): avc:  denied  { dyntransition } for  pid=2002 comm="sshd" scontext=system_u:system_r:unconfined_service_t:s0 tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=process permissive=1
>> >
>> > I take this to mean that tcpserver runs in the unconfined_service_t 
>> > domain (confirmed by ps -Z), that when it execs the sshd program it 
>> > doesn't make the transition to the sshd_t domain, and consequently sshd 
>> > is prevented from doing what it wants.
>> >
>> > audit2allow's recommendation is:
>> >
>> > 	allow unconfined_service_t unconfined_t:process dyntransition;
>> >
>> > which probably would work, but it seems like treating the symptom
>> > rather than the disease, not to mention opening up a fairly large
>> > security hole.  I'd like something a little more specific, particularly
>> > since I want to run one or two other services under tcpserver in
>> > addition to sshd.
>> >
>> > Probably the best approach would be to create a new tcpserver_t type
>> > with all the appropriate policies, but that's beyond my current skill.  
>> > Would it make sense to create a policy module that would simply allow
>> > unconfined_service_t to transition to sshd_t?
>> >
>> > And what would the source for such a policy module look like?  The 
>> > impression I get is something like:
>> >
>> > 	allow unconfined_service_t sshd_exec_t:file { execute
>> > 		execute_no_trans getattr ioctl map open read };
>> 
>> That would be redundant. unconfined_service_t already has broad access
>> and from a unconfined_service_t perspective you just need to tell
>> selinux what to do:
>> 
>> type_transition unconfined_service_t sshd_exec_t:process sshd_t;
>> 
>> That will tell selinux that processes types should transition from
>> unconfined_service_t to sshd_t when processes with type
>> unconfined_service_t execute files with type sshd_exec_t.
>> 
>> When you do this and try it out then some avc denials will likely
>> surface regarding access that sshd_t processes may need to
>> unconfined_service_t processes. (for example sending a child terminated
>> signal, but possibly others as well)
>
> Yes, I see what you mean.  I'm getting AVC violations because sshd 
> isn't supposed to perform getattr and setopt actions on a tcp_socket of 
> type unconfined_service_t, which is what it gets when it inherits a 
> socket from tcpserver instead of opening the socket itself.
>
> It looks like the tcp_socket needs to undergo a type transition along
> with the process.  Is there any way to express this?

tcpd would have to grow selinux awareness and do that manually using the
setsockcreate() functionality provided by libselinux.

systemd does this with its socket activation functionality.

>
> Alan Stern
>
> PS: There appears to be a bunch of redundant rules relating sshd_t and 
> tcp_socket in the system's policy database.  Part of the output from 
> sesearch says:
>
> allow sshd_t sshd_t:tcp_socket { accept append bind connect create getattr getopt ioctl listen lock read setattr setopt shutdown write };
> allow sshd_t sshd_t:tcp_socket { accept append bind connect create
> getattr getopt ioctl listen lock read setattr setopt shutdown write };
> [ nis_enabled ]:True
> allow sshd_t sshd_t:tcp_socket { accept append bind connect create
> getattr getopt ioctl listen lock read setattr setopt shutdown write };
> [ nis_enabled ]:True
> allow sshd_t sshd_t:tcp_socket { append bind connect create getattr
> getopt ioctl lock read setattr setopt shutdown write }; [
> authlogin_nsswitch_use_ldap ]:True
> allow sshd_t sshd_t:tcp_socket { append bind connect create getattr
> getopt ioctl lock read setattr setopt shutdown write }; [
> kerberos_enabled ]:True
> allow sshd_t sshd_t:tcp_socket { append bind connect create getattr
> getopt ioctl lock read setattr setopt shutdown write }; [
> kerberos_enabled ]:True
> allow sshd_t sshd_t:tcp_socket { append bind connect create getattr
> getopt ioctl lock read setattr setopt shutdown write }; [
> kerberos_enabled ]:True
> allow sshd_t tcpd_t:tcp_socket { append bind connect getattr getopt ioctl lock read setattr setopt shutdown write }; [ ssh_use_tcpd ]:True
>
> Don't all those boolean-controlled rules just allow things that are
> already allowed anyway?  Or do they override the first rule, forbidding
> some of the things it allows (which seems contrary to the idea of using
> these booleans to allow things that wouldn't normally be allowed)?

Yes, inefficient 

>
> PPS: Is there any document anywhere that explains all the details
> needed to understand and create selinux policies?  I see individual
> items covered piecemeal in the wiki pages at selinuxproject.org, but no
> organized whole.  Certainly nothing that would enable the reader to
> formulate a strategy for solving the problem I encountered.
>
> As just one example, is there a complete listing of the syntax
> required/accepted by checkmodule in a .te file?

selinuxproject.org documents almost the full policy language (the docs
there arent maintained all that well)

Another great documentation is:
https://github.com/SELinuxProject/selinux/tree/master/secilc/docs
This is for the CIL, but can be useful nonetheless to give an idea of
the possibilities.

Some aspects that are interesting:

transitions: manual, automatic and dynamic
role based access control: user role, role type and role allow rules
policy constraints
attributes vs. identifiers
security classes and access vector permissions (access vectors)

>

-- 
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
