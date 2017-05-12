Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4CKQZDX023919
 for <selinux@tycho.nsa.gov>; Fri, 12 May 2017 16:26:35 -0400
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com
 [209.85.216.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id B7E2256476F
 for <selinux@tycho.nsa.gov>; Fri, 12 May 2017 22:26:32 +0200 (CEST)
Received: by mail-qt0-f174.google.com with SMTP id f55so8500241qta.3
 for <selinux@tycho.nsa.gov>; Fri, 12 May 2017 13:26:32 -0700 (PDT)
MIME-Version: 1.0
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Fri, 12 May 2017 22:26:31 +0200
Message-ID: <CAJfZ7=kc+bS6b6Owk-d8aiFp8sWXs1MOZ+=V9mBmgcU3QVX=iw@mail.gmail.com>
Subject: Possible use after free in selabel_subs_init
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

Currently libselinux/src/label.c defines selabel_subs_init() like this [1]:

    struct selabel_sub *selabel_subs_init(/* ... */)
    {
        /* ... */
        while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
            /* ... allocate and fill "sub" ... */
            sub->next = list;
            list = sub;
        }

        if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
            goto err;

    out:
        fclose(cfg);
        return list;
    err:
        if (sub)
            free(sub->src);
        free(sub);
        goto out;
    }

When digest_add_specfile() fails, sub is freed (in the err label), but
as list=sub, it means that the return value, list, is freed. This
leads to a use-after-free when this value is used.

What should selabel_subs_init() do (and return) when
digest_add_specfile() fails?

Nicolas

[1] https://github.com/SELinuxProject/selinux/blob/9cc62ce35d099acf7897b6259228479737521709/libselinux/src/label.c#L94
