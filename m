Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6397AC4CECD
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468E32073C
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AXjg6YTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgD0Ukq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:40:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43862 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgD0Ukq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:40:46 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id E32F820B4737;
        Mon, 27 Apr 2020 13:40:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E32F820B4737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1588020046;
        bh=27VHzI2Hq65JTVFc/nPiFgJVJ9GP3hJURwzxyH2U6UE=;
        h=To:Cc:From:Subject:Date:From;
        b=AXjg6YTmUzWlsHLqOweBU2QlKaYmAb/X4ESaBpSTW7Egba0v5VPUU8fzBlwiNh2OT
         oPSSkjtxsvLFPN4d3SXw3bHJngVNwCFIpe+849G+r0TWiIroo6WHclNzFmwCXYOXdU
         NIPWm9ZoDfc3x+tPxkFine5Fx1lERD2JPBQNgiuQ=
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux list <selinux@vger.kernel.org>
Cc:     james.morris@microsoft.com
From:   Daniel Burgener <dburgener@linux.microsoft.com>
Subject: Race condition during policy load in kernel
Message-ID: <d3abd210-928e-374f-1e9b-fddfaa203c53@linux.microsoft.com>
Date:   Mon, 27 Apr 2020 16:40:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

We've noticed a few instances of strange failures in userspace object 
managers happening immediately after a policy load, that we believe 
we've traced to a race condition in the kernel, and wanted to get your 
thoughts on our diagnosis and the appropriate fix before creating a 
patch in case we've missed something.

The issue is that userspace object managers rely on /sys/fs/selinux to 
determine the mapping of object class and permission strings to numeric 
identifiers, however immediately after a policy load, 
/sys/fs/selinux/{booleans,class,policy_capabilities}, are deleted and 
recreated.  This leaves a window where the object classes (etc) appear 
to be not defined, even if they are defined in both the old and new 
policies.

We have observed this with both dbus and systemd userspace object 
managers, and it can be reproduced straightforwardly by running the 
following (borrowed from bug linked below):

# (while true; do cat /sys/fs/selinux/class/service/index >/dev/null; 
done) &
# while true; do sudo load_policy; echo -n .; sleep 0.1;done

Periodically, we will get "No such file or directory" messages printed 
to stderr.  In the event of a userspace object manager using libselinux 
to check a userspace permission, that will result in a USER_AVC message 
indicating an unknown object class, and in the event that 
--handle-unknown is set to "deny", it will deny the access.

It seems to me as though some sort of locking should occur in the 
selinuxfs to prevent access to the files being deleted and recreated 
during the policy load, so that userspace programs relying on them (in 
particular userspace object managers doing class lookups) get a 
consistent view of the classes, perms, booleans and capabilities in the 
loaded policy.

This seems to be related to 
https://github.com/SELinuxProject/selinux-kernel/issues/42 but I believe 
it is a different case.  The deadlock in that bug seems to be related to 
the underlying filesystem functions, specifically around directory 
deletion while this is an issue the selinuxfs logic specifically. The 
above linked issue appears to have been fixed in recent upstream 
kernels, per the bug, but I have verified the issue I am discussing here 
in 5.7.0 rc3.

It seems to me as though from the perspective of userspace that all of 
sel_make_policy_nodes (or at least all of each of its component 
functions) should be atomic.  There was some discussion in a previous 
thread 
(https://lore.kernel.org/selinux/20181002155810.GP32577@ZenIV.linux.org.uk/) 
around a significant refactor of policy loading in general.  It appears 
as though the direct issue there of access during the deletion has been 
resolved (commit d4f4de5e5ef8efde85febb6876cd3c8ab1631999), although the 
complete suggested fix of refactoring policy_load into two parts has not 
been done.  Would that refactor be the right approach to the problem I 
am trying to solve?  Would a patch for adding locking around the 
selinuxfs delete/recreate operation be considered? That wouldn't address 
all the concerns, (namely the potential to access a view of the policy 
that doesn't match the currently loaded policy and error recovery in the 
case that sel_make_nodes fails), but would improve the reliability of 
existing userspace object managers

I'm happy to create and submit a patch, but I wanted to get the 
communities thought on the problem and correct approach first.

-Daniel
