Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF457C433DB
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 17:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04FE64E08
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 17:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbhBBRPK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Feb 2021 12:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbhBBRNI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Feb 2021 12:13:08 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9563FC061573;
        Tue,  2 Feb 2021 09:12:28 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f1so29054646lfu.3;
        Tue, 02 Feb 2021 09:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uShyWR3MNmvXVDpkE0D46LY+ORkDVqS/Qa6mLsHQbmA=;
        b=GGkMLzVNfZnjg41kzwybogaLKTyd50iu58ydKhc9p7VnR5hAzjFSVXwhfEDOgSd4wz
         IF9iB16wzH/seyfemK9Tc43fXWrq2rdWj7eZP2PlOwkW+1OGeAge09/+/bjT+9uktsrI
         HQcxjRdK8jVsGU8rlrkGydEDXjDcsTeomek/5D+wXcnPWhu2g/EW0SM1cZgK93acTRNv
         pIuRF0WQMMdeYtVrAE5M8LXkejvjdOAL75Urno2AiH4PxPdtIvRrBF65Js9C6F9T1Egt
         bIafcD+gdpI44KVxqFM3gqDzddXdsDiJCkLWfmVk7jG86RWX3FQv9Yt6n5wk5MOeBlew
         edfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uShyWR3MNmvXVDpkE0D46LY+ORkDVqS/Qa6mLsHQbmA=;
        b=arU0yhWaWBZuJ11NRqVDgIltc83ZfFQfEUXpJX6AztwqFR+4tG0/hUAeAAqPsczOvy
         SY3Ro6RGfLWeAYBMzp1ykZMn+XQ+vK7+k4J64aM46sHx4fK0akoteUmcg0m52z8FUdL5
         UpBBsacUsAQBh5Ef6djXKhXHHrIwlFzi5jHrQiFzehY2ZO5JLnxuHptJVeqUa4UBJMce
         K0O3/hM6Mv4J/TuHCYOZymbocPv1xCDlhv8+ieGuQD3TJKKEpJhnQQ0l+Jkv+tZRJegs
         98FgH2rswHWENEtIALhotSqayphK8YfleFJjmV7lrAr/C5M0fVt+dT/YcDrLcauF7hvC
         XXCQ==
X-Gm-Message-State: AOAM531L9wBACEavNz4n4dAZNqQnisbvDhb3qTOXYIL9G7dyQrlyB//H
        TiS4OEca54wG6N1RW6EXUOwMtIXRCjQ=
X-Google-Smtp-Source: ABdhPJyxUmatK38o8ykTXLx7DqtE30aaaFBQp8V5TivEquQQBlTpx5wu3jwd8mxQna+whhJKKyd/jg==
X-Received: by 2002:a05:6512:44e:: with SMTP id y14mr11062321lfk.603.1612285946235;
        Tue, 02 Feb 2021 09:12:26 -0800 (PST)
Received: from [192.168.1.36] (88-114-221-222.elisa-laajakaista.fi. [88.114.221.222])
        by smtp.gmail.com with ESMTPSA id v2sm1682162lft.4.2021.02.02.09.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 09:12:25 -0800 (PST)
Subject: Re: [PATCH v24 00/25] LSM: Module stacking for AppArmor
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org
References: <20210126164108.1958-1-casey.ref@schaufler-ca.com>
 <20210126164108.1958-1-casey@schaufler-ca.com>
 <31ba0fe7-afdf-8f7d-e7a7-8f15d8c690a4@gmail.com>
 <c810406d-2197-9529-a8cb-2f289e9c248c@schaufler-ca.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <c5c40a66-b36d-73ab-6c92-f4d1f5f4ad35@gmail.com>
Date:   Tue, 2 Feb 2021 19:12:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <c810406d-2197-9529-a8cb-2f289e9c248c@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2.2.2021 17.30, Casey Schaufler wrote:
> On 2/2/2021 4:05 AM, Topi Miettinen wrote:
>> On 26.1.2021 18.40, Casey Schaufler wrote:
>>> This patchset provides the changes required for
>>> the AppArmor security module to stack safely with any other.
>>
>> In my test, when kernel command line has apparmor before selinux in lsm= entry, the boot is not successful with enforcing=1:
>> systemd[1]: Failed to compute init label, ignoring.
>> systemd[1]: Failed to set SELinux security context system_u:object_r:cgroup_t:s0 for /sys/fs/cgroup: Invalid argument
>> systemd[1]: Failed to set SELinux security context system_u:object_r:pstore_t:s0 for /sys/fs/pstore: Invalid argument
>> systemd[1]: Failed to set SELinux security context system_u:object_r:sysfs_t:s0 for /sys/firmware/efi/efivars: Invalid argument
>> ...
>> Failed to drop capability bounding set of usermode helpers: Operation not permitted
>> Failed to drop capability bounding set of usermode helpers.
>> systemd[1]: Freezing execution.
> 
> Systemd has extensive support for SELinux. That's good.
> It doesn't have an understanding of what needs to be done
> if SELinux is active but not the default security module
> for interfaces including SO_PEERSEC and /proc/*/attr/*.
> That's going to take some work.

Ok. What will be the replacement for SO_PEERSEC? Systemd calls 
getsockopt(fd, SOL_SOCKET, SO_PEERSEC, s, &n).

Is the /proc part something that should be fixed on systemd side, or can 
perhaps the SELinux libraries hide this from applications?

> 
>>
>> Probably SELinux libraries can't find or set the labels for the PID1 or any file systems. Before the init label message, systemd calls getcon_raw(), getfilecon_raw(), string_to_security_class() and security_compute_create_raw(), so one of these don't understand the LSM stacking.
> 
> That is correct.
> 
>>
>> Also the policy needs updating to handle process2:setdisplay:
>> SELinux:  Permission setdisplay in class process2 not defined in policy.
>> SELinux: the above unknown classes and permissions will be denied
>>
>> With enforcing=0, many services start, but for example systemd-journald doesn't. This is probably related to the earlier problem with labels (maybe libraries try to use SELinux labels where kernel wants AppArmor profiles):
>> systemd[1]: Failed to set SELinux security context system_u:object_r:init_runtime_t:s0 for /run/systemd/units/invocation:systemd-user-sessions.service: Invalid argument
> 
> This is also an artifact of systemd seeing AppArmor information
> instead of SELinux contexts.

Will SELinux libraries choose automatically the correct way to set 
labels in the future?

>>
>> Switching the order so that apparmor is after selinux, boot is successful. Loading AppArmor profiles needs a permission from SELinux:
>>
>> Feb 02 08:53:15 audit[963]: AVC avc:  denied  { mac_admin } for  pid=963 comm="apparmor_parser" capability=33 scontext=system_u:system_r:initrc_t:s0 tcontext=system_u:system_r:initrc_t:s0 tclass=capability2 permissive=0
>> Feb 02 08:53:15 audit[963]: AVC apparmor="STATUS" operation="profile_replace" info="not policy admin" error=-13 profile="unconfined" pid=963 comm="apparmor_parser"
>> Feb 02 08:53:15 audit: AUDIT1420 subj_selinux=system_u:system_r:initrc_t:s0 subj_apparmor==unconfined
>> Feb 02 08:53:15 audit[963]: SYSCALL arch=c000003e syscall=1 success=no exit=-13 a0=7 a1=7a8f2ff04f80 a2=1e09 a3=0 items=0 ppid=961 pid=963 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="apparmor_parser" exe="/usr/sbin/apparmor_parser" subj=? key=(null)
>> Feb 02 08:53:15 audit: PROCTITLE proctitle=2F7362696E2F61707061726D6F725F706172736572002D2D77726974652D6361636865002D2D7265706C616365002D2D002F6574632F61707061726D6F722E64
>> Feb 02 08:53:15 apparmor.systemd[963]: /sbin/apparmor_parser: Unable to replace "/lib/systemd/systemd-resolved".  Permission denied; attempted to load a profile while confined?
>>
>> This just seems to need TE rules for the apparmor_parser.
>>
>> Double equal sign in subj_apparmor==unconfined looks odd, should that be just one like subj_selinux?
> 
> The audit code is reporting what AppArmor provides.
> I agree that this looks odd.
> 
>>
>>
>> Tools like ps, and KDE and Gnome System Monitors only show SELinux context, but it would be nice if MAC contexts for all enabled LSMs were shown.
> 
> I agree. How this should be done has been a topic of
> lively debate for some time.
> 
>>
>> -Topi
> 
> Thank you for this report. Which distribution are you using?
> I have been testing with Fedora (SELinux + AppArmor) and Ubuntu
> (AppArmor + Smack). I would be very interested to see how a
> distribution that doesn't use systemd behaves.

This is Debian with systemd, I'm using SELinux + TOMOYO + AppArmor.

-Topi

> 
>>
>>>
>>> v24: Rebase to 5.11-rc1
>>>        Incorporate feedback from v23
>>>        - Address the IMA team's concerns about "label collisions".
>>>          A label collision occurs when there is ambiguity about
>>>          which of multiple LSMs is being targeted in the definition
>>>          of an integrity check rule.  A system with Smack and
>>>          AppArmor would be unable to distinguish which LSM is
>>>          important to an integrity rule referrencing the label
>>>          "unconfined" as that label is meaningful to both.
>>>          Provide a boot option to specify which LSM will be used in
>>>          IMA rules when multiple LSMs are present. (patch 04)
>>>          Pull LSM "slot" identification from later audit patches in
>>>          in support of this (patch 03).
>>>        - Pick up a few audit events that need to include supplimental
>>>          subject context records that had been missed in the
>>>          previous version.
>>> v23: Rebase to 5.10-rc4
>>>        Incorporate feedback from v22
>>>        - Change /proc/*/attr/display to /proc/*/attr/interface_lsm to
>>>          make the purpose clearer. (patch 0012)
>>>        - Include ABI documentation. (patch 0012, 0022)
>>>        - Introduce LSM documentation updates with the patches where
>>>          the interfaces are added rather than at the end. (patch 0012, 0022)
>>>        Include more maintainers and mail lists in To: and Cc: directives.
>>> v22: Rebase to 5.10-rc1
>>> v21: Rebase to 5.9-rc4
>>>        Incorporate feedback from v20
>>>        - Further revert UDS SO_PEERSEC to use scaffolding around
>>>          the interfaces that use lsmblobs and store only a single
>>>          secid. The possibility of multiple security modules
>>>          requiring data here is still a future problem.
>>>        - Incorporate Richard Guy Briggs' non-syscall auxiliary
>>>          records patch (patch 0019-0021) in place of my "supplimental"
>>>          records implementation. [I'm not sure I've given proper
>>>          attestation. I will correct as appropriate]
>>> v20: Rebase to 5.9-rc1
>>>        Change the BPF security module to use the lsmblob data. (patch 0002)
>>>        Repair length logic in subject label processing (patch 0015)
>>>        Handle -EINVAL from the empty BPF setprocattr hook (patch 0020)
>>>        Correct length processing in append_ctx() (patch 0022)
>>> v19: Rebase to 5.8-rc6
>>>        Incorporate feedback from v18
>>>        - Revert UDS SO_PEERSEC implementation to use lsmblobs
>>>          directly, rather than allocating as needed. The correct
>>>          treatment of out-of-memory conditions in the later case
>>>          is difficult to define. (patch 0005)
>>>        - Use a size_t in append_ctx() (patch 0021)
>>>        - Fix a memory leak when creating compound contexts. (patch 0021)
>>>        Fix build error when CONFIG_SECURITY isn't set (patch 0013)
>>>        Fix build error when CONFIG_SECURITY isn't set (patch 0020)
>>>        Fix build error when CONFIG_SECURITY isn't set (patch 0021)
>>> v18: Rebase to 5.8-rc3
>>>        Incorporate feedback from v17
>>>        - Null pointer checking in UDS (patch 0005)
>>>        Match changes in IMA code (patch 0012)
>>>        Fix the behavior of LSM context supplimental audit
>>>        records so that there's always exactly one when it's
>>>        appropriate for there to be one. This is a substantial
>>>        change that requires extention of the audit_context beyond
>>>        syscall events. (patch 0020)
>>> v17: Rebase to 5.7-rc4
>>> v16: Rebase to 5.6
>>>        Incorporate feedback from v15 - Thanks Stephen, Mimi and Paul
>>>        - Generally improve commit messages WRT scaffolding
>>>        - Comment ima_lsm_isset() (patch 0002)
>>>        - Some question may remain on IMA warning (patch 0002)
>>>        - Mark lsm_slot as __lsm_ro_after_init not __init_data (patch 0002)
>>>        - Change name of lsmblob variable in ima_match_rules() (patch 0003)
>>>        - Instead of putting a struct lsmblob into the unix_skb_parms
>>>          structure put a pointer to an allocated instance. There is
>>>          currently only space for 5 u32's in unix_skb_parms and it is
>>>          likely to get even tighter. Fortunately, the lifecycle
>>>          management of the allocated lsmblob is simple. (patch 0005)
>>>        - Dropped Acks due to the above change (patch 0005)
>>>        - Improved commentary on secmark labeling scaffolding. (patch 0006)
>>>        - Reduced secmark related labeling scaffolding. (patch 0006)
>>>        - Replace use of the zeroth entry of an lsmblob in scaffolding
>>>          with a function lsmblob_value() to hopefully make it less
>>>          obscure. (patch 0006)
>>>        - Convert security_secmark_relabel_packet to use lsmblob as
>>>          this reduces much of the most contentious scaffolding. (patch 0006)
>>>        - Dropped Acks due to the above change (patch 0006)
>>>        - Added BUILD_BUG_ON() for CIPSO tag 6. (patch 0018)
>>>        - Reworked audit subject information. Instead of adding fields in
>>>          the middle of existing records add a new record to the event. When
>>>          a separate record is required use subj="?". (patch 0020)
>>>        - Dropped Acks due to the above change (patch 0020)
>>>        - Reworked audit object information. Instead of adding fields in
>>>          the middle of existing records add a new record to the event. When
>>>          a separate record is required use obj="?". (patch 0021)
>>>        - Dropped Acks due to the above change (patch 0021)
>>>        - Enhanced documentation (patch 0022)
>>>        - Removed unnecessary error code check in security_getprocattr()
>>>          (patch 0021)
>>> v15: Rebase to 5.6-rc1
>>>        - Revise IMA data use (patch 0002)
>>>        Incorporate feedback from v14
>>>        - Fix lockdown module registration naming (patch 0002)
>>>        - Revise how /proc/self/attr/context is gathered. (patch 0022)
>>>        - Revise access modes on /proc/self/attr/context. (patch 0022)
>>>        - Revise documentation on LSM external interfaces. (patch 0022)
>>> v14: Rebase to 5.5-rc5
>>>        Incorporate feedback from v13
>>>        - Use an array of audit rules (patch 0002)
>>>        - Significant change, removed Acks (patch 0002)
>>>        - Remove unneeded include (patch 0013)
>>>        - Use context.len correctly (patch 0015)
>>>        - Reorder code to be more sensible (patch 0016)
>>>        - Drop SO_PEERCONTEXT as it's not needed yet (patch 0023)
>>> v13: Rebase to 5.5-rc2
>>>        Incorporate feedback from v12
>>>        - Print lsmblob size with %z (Patch 0002)
>>>        - Convert lockdown LSM initialization. (Patch 0002)
>>>        - Restore error check in nft_secmark_compute_secid (Patch 0006)
>>>        - Correct blob scaffolding in ima_must_appraise() (Patch 0009)
>>>        - Make security_setprocattr() clearer (Patch 0013)
>>>        - Use lsm_task_display more widely (Patch 0013)
>>>        - Use passed size in lsmcontext_init() (Patch 0014)
>>>        - Don't add a smack_release_secctx() hook (Patch 0014)
>>>        - Don't print warning in security_release_secctx() (Patch 0014)
>>>        - Don't duplicate the label in nfs4_label_init_security() (Patch 0016)
>>>        - Remove reviewed-by as code has significant change (Patch 0016)
>>>        - Send the entire lsmblob for Tag 6 (Patch 0019)
>>>        - Fix description of socket_getpeersec_stream parameters (Patch 0023)
>>>        - Retain LSMBLOB_FIRST. What was I thinking? (Patch 0023)
>>>        - Add compound context to LSM documentation (Patch 0023)
>>> v12: Rebase to 5.5-rc1
>>>        Fixed a couple of incorrect contractions in the text.
>>> v11: Rebase to 5.4-rc6
>>>        Incorporate feedback from v10
>>>        - Disambiguate reading /proc/.../attr/display by restricting
>>>          all use of the interface to the current process.
>>>        - Fix a merge error in AppArmor's display attribute check
>>> v10: Ask the security modules if the display can be changed.
>>> v9: There is no version 9
>>> v8: Incorporate feedback from v7
>>>       - Minor clean-up in display value management
>>>       - refactor "compound" context creation to use a common
>>>         append_ctx() function.
>>> v7: Incorporate feedback from v6
>>>       - Make setting the display a privileged operation. The
>>>         availability of compound contexts reduces the need for
>>>         setting the display.
>>> v6: Incorporate feedback from v5
>>>       - Add subj_<lsm>= and obj_<lsm>= fields to audit records
>>>       - Add /proc/.../attr/context to get the full context in
>>>         lsmname\0value\0... format as suggested by Simon McVittie
>>>       - Add SO_PEERCONTEXT for getsockopt() to get the full context
>>>         in the same format, also suggested by Simon McVittie.
>>>       - Add /sys/kernel/security/lsm_display_default to provide
>>>         the display default value.
>>> v5: Incorporate feedback from v4
>>>       - Initialize the lsmcontext in security_secid_to_secctx()
>>>       - Clear the lsmcontext in all security_release_secctx() cases
>>>       - Don't use the "display" on strictly internal context
>>>         interfaces.
>>>       - The SELinux binder hooks check for cases where the context
>>>         "display" isn't compatible with SELinux.
>>> v4: Incorporate feedback from v3
>>>       - Mark new lsm_<blob>_alloc functions static
>>>       - Replace the lsm and slot fields of the security_hook_list
>>>         with a pointer to a LSM allocated lsm_id structure. The
>>>         LSM identifies if it needs a slot explicitly. Use the
>>>         lsm_id rather than make security_add_hooks return the
>>>         slot value.
>>>       - Validate slot values used in security.c
>>>       - Reworked the "display" process attribute handling so that
>>>         it works right and doesn't use goofy list processing.
>>>       - fix display value check in dentry_init_security
>>>       - Replace audit_log of secids with '?' instead of deleting
>>>         the audit log
>>> v3: Incorporate feedback from v2
>>>       - Make lsmblob parameter and variable names more
>>>         meaningful, changing "le" and "l" to "blob".
>>>       - Improve consistency of constant naming.
>>>       - Do more sanity checking during LSM initialization.
>>>       - Be a bit clearer about what is temporary scaffolding.
>>>       - Rather than clutter security_getpeersec_dgram with
>>>         otherwise unnecessary checks remove the apparmor
>>>         stub, which does nothing useful.
>>>
>>> Patch 01 moves management of the sock security blob
>>> from the individual modules to the infrastructure.
>>>
>>> Patches 02-03 introduce a structure "lsmblob" that will gradually
>>> replace the "secid" as a shorthand for security module information.
>>> At this point lsmblob contains an array of u32 secids, one "slot"
>>> for each of the security modules compiled into the kernel that
>>> used secids. A "slot" is allocated when a security module requests
>>> one.
>>>
>>> Patch 04 provides mechanism for the IMA subsystem to identify
>>> explicitly which LSM is subject to IMA policy. This includes
>>> a boot option for specifying the default and an additional option
>>> in IMA rules "lsm=".
>>>
>>> Patches 05-13 change LSM interfaces to use the lsmblob instead
>>> of secids. It is important that the lsmblob be a fixed size entity
>>> that does not have to be allocated. Several of the places
>>> where it is used would have performance and/or locking
>>> issues with dynamic allocation.
>>>
>>> Patch 14 provides a mechanism for a process to identify which
>>> security module's hooks should be used when displaying or
>>> converting a security context string.  A new interface
>>> /proc/self/attr/interface_lsm contains the name of the security
>>> module to show. Reading from this file will present the name of
>>> the module, while writing to it will set the value. Only names
>>> of active security modules are accepted. Internally, the name
>>> is translated to the appropriate "slot" number for the module
>>> which is then stored in the task security blob. Setting the
>>> display requires that all modules using the /proc interfaces
>>> allow the transition. The interface LSM of other processess
>>> can be neither read nor written. All suggested cases for
>>> reading the interface LSM of a different process have race
>>> conditions.
>>>
>>> Patch 15 Starts the process of changing how a security
>>> context is represented. Since it is possible for a
>>> security context to have been generated by more than one
>>> security module it is now necessary to note which module
>>> created a security context so that the correct "release"
>>> hook can be called. There are several places where the
>>> module that created a security context cannot be inferred.
>>>
>>> This is achieved by introducing a "lsmcontext" structure
>>> which contains the context string, its length and the
>>> "slot" number of the security module that created it.
>>> The security_release_secctx() interface is changed,
>>> replacing the (string,len) pointer pair with a lsmcontext
>>> pointer.
>>>
>>> Patches 16-18 convert the security interfaces from
>>> (string,len) pointer pairs to a lsmcontext pointer.
>>> The slot number identifying the creating module is
>>> added by the infrastructure. Where the security context
>>> is stored for extended periods the data type is changed.
>>>
>>> The Netlabel code is converted to save lsmblob structures
>>> instead of secids in Patch 19. This is not strictly
>>> necessary as there can only be one security module that
>>> uses Netlabel at this point. Using a lsmblob is much
>>> cleaner, as the interfaces that use the data have all
>>> been converted.
>>>
>>> Patch 20 adds checks to the binder hooks which verify
>>> that both ends of a transaction use the same interface LSM.
>>>
>>> Patches 21-23 add addition audit records for subject and
>>> object LSM data when there are multiple security modules
>>> with such data. The AUDIT_MAC_TASK_CONTEXTS record is used
>>> in conjuction with a "subj=?" field to identify the subject
>>> data. The AUDIT_MAC_OBJ_CONTEXTS record is used in conjuction
>>> with a "obj=?" field to identify the object data.  The
>>> AUDIT_MAC_TASK_CONTEXTS record identifies the security module
>>> with the data: "subj_selinux=xyz_t subj_apparmor=abc". The
>>> AUDIT_MAC_OBJ_CONTEXTS record identifies the security module
>>> with the data: "obj_selinux=xyz_t obj_apparmor=abc".  While
>>> AUDIT_MAC_TASK_CONTEXTS records will always contain an entry
>>> for each possible security modules, AUDIT_MAC_OBJ_CONTEXTS
>>> records will only contain entries for security modules for
>>> which the object in question has data.
>>>
>>> An example of the MAC_TASK_CONTEXTS (1420) record is:
>>>
>>>       type=UNKNOWN[1420]
>>>       msg=audit(1600880931.832:113)
>>>       subj_apparmor==unconfined
>>>       subj_smack=_
>>>
>>> An example of the MAC_OBJ_CONTEXTS (1421) record is:
>>>
>>>       type=UNKNOWN[1421]
>>>       msg=audit(1601152467.009:1050):
>>>       obj_selinux=unconfined_u:object_r:user_home_t:s0
>>>
>>> Patch 24 adds a new interface for getting the compound security
>>> contexts, /proc/self/attr/context.  An example of the content
>>> of this file is:
>>>
>>>       selinux\0one_u:one_r:one_t:s0-s0:c0.c1023\0apparmor\0unconfined\0
>>>
>>> Finally, with all interference on the AppArmor hooks removed,
>>> Patch 25 removes the exclusive bit from AppArmor. An unnecessary
>>> stub hook was also removed.
>>>
>>> The Ubuntu project is using an earlier version of this patchset in
>>> their distribution to enable stacking for containers.
>>>
>>> Performance measurements to date have the change within the "noise".
>>> The sockperf and dbench results are on the order of 0.2% to 0.8%
>>> difference, with better performance being as common as worse. The
>>> benchmarks were run with AppArmor and Smack on Ubuntu.
>>>
>>> https://github.com/cschaufler/lsm-stacking.git#stack-5.11-rc1-v24
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>
>>>
>>> Casey Schaufler (25):
>>>     LSM: Infrastructure management of the sock security
>>>     LSM: Add the lsmblob data structure.
>>>     LSM: provide lsm name and id slot mappings
>>>     IMA: avoid label collisions with stacked LSMs
>>>     LSM: Use lsmblob in security_audit_rule_match
>>>     LSM: Use lsmblob in security_kernel_act_as
>>>     LSM: Use lsmblob in security_secctx_to_secid
>>>     LSM: Use lsmblob in security_secid_to_secctx
>>>     LSM: Use lsmblob in security_ipc_getsecid
>>>     LSM: Use lsmblob in security_task_getsecid
>>>     LSM: Use lsmblob in security_inode_getsecid
>>>     LSM: Use lsmblob in security_cred_getsecid
>>>     IMA: Change internal interfaces to use lsmblobs
>>>     LSM: Specify which LSM to display
>>>     LSM: Ensure the correct LSM context releaser
>>>     LSM: Use lsmcontext in security_secid_to_secctx
>>>     LSM: Use lsmcontext in security_inode_getsecctx
>>>     LSM: security_secid_to_secctx in netlink netfilter
>>>     NET: Store LSM netlabel data in a lsmblob
>>>     LSM: Verify LSM display sanity in binder
>>>     audit: add support for non-syscall auxiliary records
>>>     Audit: Add new record for multiple process LSM  attributes
>>>     Audit: Add a new record for multiple object LSM attributes
>>>     LSM: Add /proc attr entry for full LSM context
>>>     AppArmor: Remove the exclusive flag
>>>
>>>    Documentation/ABI/testing/ima_policy          |   8 +-
>>>    Documentation/ABI/testing/procfs-attr-context |  14 +
>>>    .../ABI/testing/procfs-attr-lsm_display       |  22 +
>>>    Documentation/security/lsm.rst                |  28 +
>>>    drivers/android/binder.c                      |  26 +-
>>>    fs/ceph/xattr.c                               |   6 +-
>>>    fs/nfs/nfs4proc.c                             |   8 +-
>>>    fs/nfsd/nfs4xdr.c                             |  20 +-
>>>    fs/proc/base.c                                |   2 +
>>>    include/linux/audit.h                         |  43 +-
>>>    include/linux/cred.h                          |   3 +-
>>>    include/linux/lsm_hooks.h                     |  36 +-
>>>    include/linux/security.h                      | 185 +++++-
>>>    include/net/netlabel.h                        |  11 +-
>>>    include/net/scm.h                             |  15 +-
>>>    include/net/xfrm.h                            |  13 +-
>>>    include/uapi/linux/audit.h                    |   2 +
>>>    kernel/audit.c                                | 175 ++++--
>>>    kernel/audit.h                                |  11 +-
>>>    kernel/auditfilter.c                          |  36 +-
>>>    kernel/auditsc.c                              | 191 +++---
>>>    kernel/cred.c                                 |  12 +-
>>>    net/ipv4/cipso_ipv4.c                         |  26 +-
>>>    net/ipv4/ip_sockglue.c                        |  12 +-
>>>    net/netfilter/nf_conntrack_netlink.c          |  24 +-
>>>    net/netfilter/nf_conntrack_standalone.c       |  11 +-
>>>    net/netfilter/nfnetlink_queue.c               |  38 +-
>>>    net/netfilter/nft_meta.c                      |  10 +-
>>>    net/netfilter/xt_SECMARK.c                    |   7 +-
>>>    net/netlabel/netlabel_domainhash.c            |   4 +-
>>>    net/netlabel/netlabel_kapi.c                  |   6 +-
>>>    net/netlabel/netlabel_unlabeled.c             | 106 ++--
>>>    net/netlabel/netlabel_unlabeled.h             |   2 +-
>>>    net/netlabel/netlabel_user.c                  |  23 +-
>>>    net/netlabel/netlabel_user.h                  |   2 +-
>>>    net/xfrm/xfrm_policy.c                        |  10 +-
>>>    net/xfrm/xfrm_state.c                         |  20 +-
>>>    security/apparmor/include/apparmor.h          |   3 +-
>>>    security/apparmor/include/net.h               |   6 +-
>>>    security/apparmor/include/procattr.h          |   2 +-
>>>    security/apparmor/lsm.c                       | 105 ++--
>>>    security/apparmor/procattr.c                  |  22 +-
>>>    security/bpf/hooks.c                          |  12 +-
>>>    security/commoncap.c                          |   7 +-
>>>    security/integrity/ima/ima.h                  |  15 +-
>>>    security/integrity/ima/ima_api.c              |  17 +-
>>>    security/integrity/ima/ima_appraise.c         |   6 +-
>>>    security/integrity/ima/ima_main.c             |  54 +-
>>>    security/integrity/ima/ima_policy.c           |  97 ++-
>>>    security/integrity/integrity_audit.c          |   6 +-
>>>    security/loadpin/loadpin.c                    |   8 +-
>>>    security/lockdown/lockdown.c                  |   7 +-
>>>    security/safesetid/lsm.c                      |   8 +-
>>>    security/security.c                           | 561 ++++++++++++++++--
>>>    security/selinux/hooks.c                      |  99 ++--
>>>    security/selinux/include/classmap.h           |   2 +-
>>>    security/selinux/include/objsec.h             |   5 +
>>>    security/selinux/include/security.h           |   1 +
>>>    security/selinux/netlabel.c                   |  25 +-
>>>    security/selinux/ss/services.c                |   4 +-
>>>    security/smack/smack.h                        |   6 +
>>>    security/smack/smack_access.c                 |   2 +-
>>>    security/smack/smack_lsm.c                    |  91 +--
>>>    security/smack/smack_netfilter.c              |   8 +-
>>>    security/smack/smackfs.c                      |  13 +-
>>>    security/tomoyo/tomoyo.c                      |   8 +-
>>>    security/yama/yama_lsm.c                      |   7 +-
>>>    67 files changed, 1741 insertions(+), 634 deletions(-)
>>>    create mode 100644 Documentation/ABI/testing/procfs-attr-context
>>>    create mode 100644 Documentation/ABI/testing/procfs-attr-lsm_display
>>>
>>

