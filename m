Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t82JWf1Q013084
 for <selinux@tycho.nsa.gov>; Wed, 2 Sep 2015 15:32:42 -0400
Received: by oixx17 with SMTP id x17so12279857oix.0
 for <selinux@tycho.nsa.gov>; Wed, 02 Sep 2015 12:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <1441025637-18267-1-git-send-email-slawrence@tresys.com>
 <1441025637-18267-3-git-send-email-slawrence@tresys.com>
 <55E73FF1.5040601@tycho.nsa.gov> <55E74747.1030106@tresys.com>
In-Reply-To: <55E74747.1030106@tresys.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Wed, 02 Sep 2015 19:32:30 +0000
Message-ID: <CABXk95D5KM9caJVAQ-w90b9j3HGS_YbFmxOevykE==P+ngs9LA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] libsepol/cil: add ioctl whitelist support
To: Steve Lawrence <slawrence@tresys.com>,
 James Carter <jwcart2@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1137c390cb4bbc051ec8babd
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1137c390cb4bbc051ec8babd
Content-Type: text/plain; charset=UTF-8

>
> Really, the only thing they have in common, which was copied directly
> from policy_define.c, is the xperm_setrangebits function. Now that that
> function is in CIL/libsepol, it wouldn't be much effort to have
> checkpolicy use that one and remove the one in policy_define, but I
> think that's about all the refactoring we could do without maybe
> rewriting policy_define.c to use ebitmaps, and I'm not even sure that
> would remove very much code.
>

I'm considering rewriting the checkpolicy code to use an ebitmap. If/when I
get around to it I'll certainly reuse as much from cil as possible.

--001a1137c390cb4bbc051ec8babd
Content-Type: text/html; charset=UTF-8

<div dir="ltr"><div class="gmail_quote"><blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Really, the only thing they have in common, which was copied directly<br>
from policy_define.c, is the xperm_setrangebits function. Now that that<br>
function is in CIL/libsepol, it wouldn&#39;t be much effort to have<br>
checkpolicy use that one and remove the one in policy_define, but I<br>
think that&#39;s about all the refactoring we could do without maybe<br>
rewriting policy_define.c to use ebitmaps, and I&#39;m not even sure that<br>
would remove very much code.<br></blockquote><div><br></div><div>I&#39;m considering rewriting the checkpolicy code to use an ebitmap. If/when I get around to it I&#39;ll certainly reuse as much from cil as possible.</div></div></div>

--001a1137c390cb4bbc051ec8babd--
