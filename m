Return-Path: <SRS0=kuKh=SY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84408C10F11
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 21:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4B320896
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 21:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VATpkTOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfDVVAq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:00:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46064 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfDVVAq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Apr 2019 17:00:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id k92so10554920edc.12;
        Mon, 22 Apr 2019 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Qo3CRFIMaiF0yNVC2trLgFwP5GYCK2804PEPw9a+oQE=;
        b=VATpkTOIfX2DATzIn279u1wFkg9zsNwpCWKfaXXRlpo1c5U7u2+OK1v4l+tzQhV1W4
         +WROCEFyOZYu6eweNeUGZIMXWKc09c26llJYLxUk4uVDRQsWHSwEuuFhC2/TjOdkUX+B
         E/UH4Iem9ayPnJy5KZQ7KGhxB1GekSn3owtCYO1J3pKbnGLpEBOGco5lYye0ZGvffIdq
         YbnSuspk+Ni4ggklF9uB6RtLKL4V9TJHbkVdo28+aWUrIXfKQpTbA4u3opdSfv6p2ksM
         IQZCmCq0TwjpCevYZvPbYLHtbcmSkugZTCPmGBZcj9Hv8nsTYsVk/8ZY0pZbCBwcAJRC
         DXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Qo3CRFIMaiF0yNVC2trLgFwP5GYCK2804PEPw9a+oQE=;
        b=dtxaRdlU32i0tT2ycEoiHegLdW5Udq3D1gDVAJpRYRyxtuYJr2vvUET1mPGvqMD3tl
         kzQc2huvmSRzQAQzZRgAjgi7U5gYK4t62M2ToKEHKan066NuJIQuuBH6HdZYtqkoxpKK
         Seh17EJmq0tdNkVkU0EB0S8ep+AV4mYRXL8r5YfgpP/qmd+S8hnMbu02/nZqs4PYrk+R
         ozvCSwW2Sw8mHtsr4GSwACdC7vCy/QQ8tO4iLePTiKyybt6ylFLbzFUN72ukHUvRg8o0
         r4RK6Z1XsTAzQoiKlKGQtybarWYDappAN6ifGSK4KTzvqfRdV+Zo3aAfMq7alQ+WN25n
         S1aA==
X-Gm-Message-State: APjAAAV5QWJna3qkH9pM/hVbG3KYK+rCb/q5um7km2+Q/ADyDpCSo+bD
        RjXj5UWInyN3+NwKR+RU4KEKCsUHlgw=
X-Google-Smtp-Source: APXvYqwVWrPEWCAocRuom2zgPA6pkmniMIZG5k3dJroLlyLaM1xaJsCgtiWW0aGANRVRXuR+gXL7cw==
X-Received: by 2002:aa7:c24d:: with SMTP id y13mr13250181edo.146.1555966843912;
        Mon, 22 Apr 2019 14:00:43 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id l10sm2653474eda.8.2019.04.22.14.00.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Apr 2019 14:00:43 -0700 (PDT)
Date:   Mon, 22 Apr 2019 14:00:41 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: scripts/selinux build error in 4.14 after glibc update
Message-ID: <20190422210041.GA21711@archlinux-i9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi all,

After a glibc update to 2.29, my 4.14 builds started failing like so:

$ make -j$(nproc) defconfig bzImage
HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'x86_64_defconfig'
#
# configuration written to .config
#
scripts/kconfig/conf  --silentoldconfig Kconfig
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  UPD     include/generated/uapi/linux/version.h
  DESCEND  objtool
  HOSTCC   /home/nathan/cbl/linux-stable/tools/objtool/fixdep.o
  HOSTLD   /home/nathan/cbl/linux-stable/tools/objtool/fixdep-in.o
  LINK     /home/nathan/cbl/linux-stable/tools/objtool/fixdep
  CC       /home/nathan/cbl/linux-stable/tools/objtool/builtin-check.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/builtin-orc.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/check.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/orc_gen.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/orc_dump.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/elf.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/special.o
  GEN      /home/nathan/cbl/linux-stable/tools/objtool/arch/x86/lib/inat-tables.c
  CC       /home/nathan/cbl/linux-stable/tools/objtool/objtool.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/libstring.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/str_error_r.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/exec-cmd.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/pager.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/help.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/parse-options.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/run-command.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/sigchain.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/subcmd-config.o
  CC       /home/nathan/cbl/linux-stable/tools/objtool/arch/x86/decode.o
  LD       /home/nathan/cbl/linux-stable/tools/objtool/libsubcmd-in.o
  LD       /home/nathan/cbl/linux-stable/tools/objtool/arch/x86/objtool-in.o
  LD       /home/nathan/cbl/linux-stable/tools/objtool/objtool-in.o
  AR       /home/nathan/cbl/linux-stable/tools/objtool/libsubcmd.a
  LINK     /home/nathan/cbl/linux-stable/tools/objtool/objtool
  UPD     include/config/kernel.release
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTCC  arch/x86/tools/relocs_64.o
  WRAP    arch/x86/include/generated/asm/dma-contiguous.h
  WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
  WRAP    arch/x86/include/generated/asm/clkdev.h
  WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
  WRAP    arch/x86/include/generated/asm/early_ioremap.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/sortextable
  CC      scripts/mod/empty.o
  CC      scripts/mod/devicetable-offsets.s
  HOSTCC  scripts/mod/mk_elfconfig
  HOSTCC  scripts/selinux/mdp/mdp
  HOSTCC  scripts/selinux/genheaders/genheaders
In file included from scripts/selinux/genheaders/genheaders.c:19:
./security/selinux/include/classmap.h:245:2: error: #error New address family defined, please update secclass_map.
 #error New address family defined, please update secclass_map.
  ^~~~~
make[4]: *** [scripts/Makefile.host:102: scripts/selinux/genheaders/genheaders] Error 1
make[3]: *** [scripts/Makefile.build:585: scripts/selinux/genheaders] Error 2
make[3]: *** Waiting for unfinished jobs....
In file included from scripts/selinux/mdp/mdp.c:49:
./security/selinux/include/classmap.h:245:2: error: #error New address family defined, please update secclass_map.
 #error New address family defined, please update secclass_map.
  ^~~~~
make[4]: *** [scripts/Makefile.host:102: scripts/selinux/mdp/mdp] Error 1
make[3]: *** [scripts/Makefile.build:585: scripts/selinux/mdp] Error 2
make[2]: *** [scripts/Makefile.build:585: scripts/selinux] Error 2
make[2]: *** Waiting for unfinished jobs....
  HOSTLD  arch/x86/tools/relocs
  CHK     scripts/mod/devicetable-offsets.h
  UPD     scripts/mod/devicetable-offsets.h
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  CHK     include/generated/timeconst.h
  CC      kernel/bounds.s
  UPD     include/generated/timeconst.h
  CHK     include/generated/bounds.h
  UPD     include/generated/bounds.h
  CC      arch/x86/kernel/asm-offsets.s
  HOSTLD  scripts/mod/modpost
make[1]: *** [Makefile:572: scripts] Error 2
make[1]: *** Waiting for unfinished jobs....
  CHK     include/generated/asm-offsets.h
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
make: *** [Makefile:264: __build_one_by_one] Error 2

This is due to commit c017c71ce09f ("selinux: include sys/socket.h in
host programs to have PF_MAX") [1] in the kernel interacting poorly
with glibc's commit 38b0593e9a ("Add PF_XDP, AF_XDP and SOL_XDP from
Linux 4.18 to bits/socket.h.") [2]

I am not really sure how this should be fixed or who is at fault but I
didn't see it reported anywhere yet (I assume the kernel) and I feel
more comfortable on the kernel mailing list than other bug trackers so
here we are.

[1]: https://git.kernel.org/linus/c017c71ce09f4c7a5378fccbec6a3d7e96b0c5c2
[2]: https://sourceware.org/git/?p=glibc.git;a=commit;h=38b0593e9a862c3b35392a0f5b202696b8116aa3

Thanks,
Nathan
