MIME-Version: 1.0
In-Reply-To: <1473980857-10199-1-git-send-email-william.c.roberts@intel.com>
References: <1473980857-10199-1-git-send-email-william.c.roberts@intel.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 15 Sep 2016 16:14:41 -0700
Message-ID: <CAFftDdrVjxF5iYfxzLaCYL_TKTT9c8SxfJoLN7cTzjJZih1vVQ@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: correct error path to always try text
To: William Roberts <william.c.roberts@intel.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>, James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<snip>
> +               if (!rc) {
> +                       rc = digest_add_specfile(digest, fp, NULL, sb.st_size, found_path);
> +               }
One more time...

<snip>
