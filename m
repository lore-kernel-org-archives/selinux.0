Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8JKmJQx022573
 for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2018 16:48:23 -0400
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 169DD561228
 for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2018 22:46:37 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id v198-v6so6345185oif.9
 for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2018 13:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <DM5PR05MB3401C01C936FFE66579A1928D4070@DM5PR05MB3401.namprd05.prod.outlook.com>
In-Reply-To: <DM5PR05MB3401C01C936FFE66579A1928D4070@DM5PR05MB3401.namprd05.prod.outlook.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 19 Sep 2018 22:46:24 +0200
Message-ID: <CAJfZ7=nMsRxm9-_M-nU4zzFOJRSrsLtN9cpV72ZSHUZ=PAvp3w@mail.gmail.com>
To: liwugang@outlook.com
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Bug report
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Sep 10, 2018 at 2:46 PM 李 武刚 <liwugang@outlook.com> wrote:
> Hi, ALL
>
> There is one bug which has not checking the result value of  hashtab_search in the function define_level of policydb_define.c. If the category is not defined, a null-pointer dereference will be taken place.
>
> The patch is attached.
>
Hi,
Thanks for your bugfix. It looks good to me and as no one complained,
I have merged it.

By the way, if you want to submit more patches, please send them
inline and not as attachment (with "git send-email" for example). This
makes the review easier.

Nicolas
