Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7258C19F2A
	for <selinux@archiver.kernel.org>; Sat, 30 Jul 2022 20:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiG3UNu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 30 Jul 2022 16:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiG3UNt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 30 Jul 2022 16:13:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6710513E84
        for <selinux@vger.kernel.org>; Sat, 30 Jul 2022 13:13:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y11so11778186lfs.6
        for <selinux@vger.kernel.org>; Sat, 30 Jul 2022 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=wCZgo+NtXQ6qhxmga0z119qY5nRPWfGBYNenK6YTKKY=;
        b=gMdKMmoyVvyB4hQiSHz2MGKSuRkQJI2QDJqKSXyXlaiLc3fNshqhWvyZSmQU/5Fv83
         YtPmgdd4d++2ObgSaXh5lIxbMLe2EMHtyf2JdC+06R1d1qmBYOF+mq1p1z3YHuu/yYsT
         yct+uFZ0QgDRv4J0ROPD+rFkI2f5mkO7ExThxn8+UBd5lZzKlBcaDew4VaxLT88hu23c
         jUaJH3bJ/yuV/qhizFvEvK4GAwU+4SjyQLdfT8mz5VPlKiCVYS8kST01XxGz4CKhiiJ5
         c8HIAvmt7DcueAk565085Gv0dmg7MGRKydqxurAxEmXADrLRF0HGo8WPThoeF8mgUOwW
         uTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wCZgo+NtXQ6qhxmga0z119qY5nRPWfGBYNenK6YTKKY=;
        b=IrBnoem/Wq2kyl+3uQ46y4X1Ri9EyJICZsjgmD9aSyAy523ExD+LJkDUnaDVBa650k
         n6LuXAbukuWtUOIIZZMkioSabg/PK/LaDJmDMPo7xPqrJpbT8H0NsHKkXiXp3MuYPd39
         b9OoRlBQyu+cVZ5M+9Dfi8ExhInmjlCo+X2l/tlHY2TarWIWZ0OjGyHJNt/CSTabxNno
         UjsK2DmrMLtk15kbWlvjJd/F3aC3qU356vW+OR7lUC+AIY5VVqrYxOV1ryipvpX1fQqa
         bAKrEIefq3e7GtR6DiN0OA+tL0ET4Z9asKL3Nh6xLXoUcEAf5mCR1gqRzSy6eX5KY27b
         mmkw==
X-Gm-Message-State: ACgBeo3fz1cpi9dbKnYgSyijyoMD0up+A+sCduLkBuRitFOh8T3KZV1Z
        dCWat6kXim3BdYPG1ps9ajzQKcCkKIw=
X-Google-Smtp-Source: AA6agR7pWLCUwkIa9HzQr9WEfF5dkqu9kJLC4k+WScMsMXVdbYLKCA7Ex+q5f79mWAm5Avny6jmGfw==
X-Received: by 2002:a05:6512:360c:b0:48a:e649:20a8 with SMTP id f12-20020a056512360c00b0048ae64920a8mr2128061lfs.264.1659212025424;
        Sat, 30 Jul 2022 13:13:45 -0700 (PDT)
Received: from [192.168.1.44] (91-158-88-16.elisa-laajakaista.fi. [91.158.88.16])
        by smtp.gmail.com with ESMTPSA id a21-20020a056512201500b0048a86468531sm1059749lfb.61.2022.07.30.13.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 13:13:45 -0700 (PDT)
Message-ID: <a8ab7102-cf2e-fd7d-afb1-dafbd15278c0@gmail.com>
Date:   Sat, 30 Jul 2022 23:13:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH testsuite 24/24] ci: add sysadm_t to the test matrix
Content-Language: en-US
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20220729120229.207584-1-omosnace@redhat.com>
 <20220729120229.207584-25-omosnace@redhat.com>
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <20220729120229.207584-25-omosnace@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 29.7.2022 15.02, Ondrej Mosnacek wrote:
> The testsuite should now be passing under the sysadm user as well, so
> test it.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   .github/workflows/checks.yml |  4 +++-
>   Vagrantfile                  | 16 ++++++++++++++++
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/.github/workflows/checks.yml b/.github/workflows/checks.yml
> index 96843e4..37455ea 100644
> --- a/.github/workflows/checks.yml
> +++ b/.github/workflows/checks.yml
> @@ -15,6 +15,7 @@ jobs:
>       strategy:
>         fail-fast: false
>         matrix:
> +        domain: [unconfined_t, sysadm_t]
>           env:
>             - { version: 35, kernel: default }
>             - { version: 36, kernel: default }
> @@ -22,6 +23,7 @@ jobs:
>       env:
>         FEDORA_VERSION: ${{ matrix.env.version }}
>         KERNEL_TYPE: ${{ matrix.env.kernel }}
> +      ROOT_DOMAIN: ${{ matrix.domain }}
>       steps:
>         - uses: actions/checkout@v2
>         # macOS sometimes allows symlinks to have permissions other than 777,
> @@ -39,6 +41,6 @@ jobs:
>         - name: Run SELinux testsuite
>           run: vagrant ssh -- sudo make -C /root/testsuite test
>         - name: Check unwanted denials
> -        run: vagrant ssh -- '! sudo ausearch -m avc -i </dev/null | grep unconfined_t'
> +        run: vagrant ssh -- '! sudo ausearch -m avc -i </dev/null | grep ${{ matrix.domain }}'
>         - name: Check .gitignore coverage
>           run: test "$(vagrant ssh -- sudo git -C /root/testsuite ls-files -o --exclude-standard | wc -l)" -eq 0
> diff --git a/Vagrantfile b/Vagrantfile
> index 783df5d..ec3a492 100644
> --- a/Vagrantfile
> +++ b/Vagrantfile
> @@ -51,6 +51,21 @@ Vagrant.configure("2") do |config|
>       abort
>     end
>   
> +  extra_commands = ''
> +  case ENV['ROOT_DOMAIN']
> +  when 'unconfined_t'
> +  when 'sysadm_t'
> +    extra_commands = <<EOF
> +      semanage boolean --modify --on ssh_sysadm_login
> +      semanage login --modify -s sysadm_u root
> +      semanage login --add -s sysadm_u -r s0-s0:c0.c1023 vagrant
> +EOF
> +    reboot_cmd = 'reboot'

Is this line needed?

-Topi

> +  else
> +    print("Invalid ROOT_DOMAIN '#{ENV['ROOT_DOMAIN']}'")
> +    abort
> +  end
> +
>     config.vm.provision :shell, inline: <<SCRIPT
>       dnf install -y #{dnf_opts} \
>         --allowerasing \
> @@ -79,6 +94,7 @@ Vagrant.configure("2") do |config|
>         jfsutils \
>         dosfstools \
>         #{kernel_pkgs}
> +    #{extra_commands}
>       #{reboot_cmd}
>   SCRIPT
>   end

