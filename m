Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E52C433FE
	for <selinux@archiver.kernel.org>; Wed, 23 Nov 2022 18:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbiKWSOd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Nov 2022 13:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239040AbiKWSNt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Nov 2022 13:13:49 -0500
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5C2C4953
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 10:10:13 -0800 (PST)
Received: from brutus (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id E73E0FC0B4D;
        Wed, 23 Nov 2022 19:10:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1669227010;
        bh=/HDVN7paz/O66+od458+Qo6x44B8lZnJQsLoOPbERwA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FB+puOGTlHH1YP8ht26e1+DEFyI0R3tGpssj68FS6mXmBE5Pe+MffK+yeL2UmaTu7
         FQ5Bri1/CxLn4x4iyFAsISVuQ7sMi643XPnfgIV6sf6z1+NaqSLjC1ibVDw6ot4T05
         ToXdWTbXMQ5oh8D9N1SROiBC4gwz64ufJ6MDl6Ck=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Matthew Sheets <masheets@linux.microsoft.com>
Cc:     SELinux <selinux@vger.kernel.org>
Subject: Re: secilc genfscon parsing error
In-Reply-To: <d11c25c5-727e-342a-162a-e3851ff03d27@linux.microsoft.com>
        (Matthew Sheets's message of "Wed, 23 Nov 2022 08:53:42 -0700")
References: <d11c25c5-727e-342a-162a-e3851ff03d27@linux.microsoft.com>
Date:   Wed, 23 Nov 2022 19:10:10 +0100
Message-ID: <87ilj5h799.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Matthew Sheets <masheets@linux.microsoft.com> writes:

> Hi,
>
> I am seeing a parsing error from secilc when trying to compile the
> following line:
> (genfscon sysfs "/zap" file (system_u object_r foo ((s0) (s0))))

Works fine here (unless i am overlooking something:

root@brutus:~# cat > mytest.cil <<EOF
> (blockinherit .sysfile.base_template)
> EOF
root@brutus:~# cat > mytest.cil <<EOF
> (block foo (blockinherit .sysfile.base_template) (genfscon "/foo" file sysfile_context))
> EOF
root@brutus:~# semodule -i mytest.cil
root@brutus:~# echo $?
0
root@brutus:~# seinfo --genfscon | grep foo
   genfscon /foo file  sys.id:sys.role:foo.sysfile:s0
root@brutus:~# 

>
> But according to the documentation here:
> https://github.com/SELinuxProject/selinux/blob/master/secilc/docs/cil_file_labeling_statements.md#genfscon
> I believe this should be a valid line.
>
> The compiler error given is:
> Invalid syntax
> Bad genfscon declaration at out.cil:129
> Failed to build AST
> Failed to compile cildb: -1
>
> If I remove the file keyword everything compiles correctly.
>
> Other interesting points of data:
>
> In ref policy there is the following line in selinux.te
> genfscon selinuxfs /booleans/ -- gen_context(system_u:object_r:boolean_t,s0)
>
> When compiling this to cil with checkpolicy the following line is produced:
> (genfscon selinuxfs "/booleans/" (system_u object_r boolean_t
> (systemlow systemlow)))
> Which has no reference to the optional file_type field.
>

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
