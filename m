MIME-Version: 1.0
In-Reply-To: <CAFftDdooKv3Zuzzrj0wppO9WjMerX2C=Rj-r5zhNAoH+hgCr3w@mail.gmail.com>
References: <1478034104-25583-1-git-send-email-sds@tycho.nsa.gov>
 <CAFftDdooKv3Zuzzrj0wppO9WjMerX2C=Rj-r5zhNAoH+hgCr3w@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 1 Nov 2016 14:26:23 -0700
Message-ID: <CAFftDdptWKYSoVpQC0Q5mS74zdEoRP_ta2SccSnxw2wZd8MB4w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: avc_internal.c: allow building with clang
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Nov 1, 2016 at 2:23 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> We're gonna cross, I just sent this out as well, as well as noreturn
> fixes for utils.
>

Never-mind, a gitfoo mistake ended up in my favor of ditching my version of this
and rebasing on top of yours. You only need the noreturn patch, which
is the only
one sent.

<snip>
