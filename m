Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2AKO7M3025335
 for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2014 16:24:07 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so7682961pbb.8
 for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2014 13:24:06 -0700 (PDT)
Date: Mon, 10 Mar 2014 13:24:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH V3] ss: Add support for retrieving SELinux contexts
Message-ID: <20140310132404.6d792d30@nehalam.linuxnetplumber.net>
In-Reply-To: <1394188612-3662-1-git-send-email-richard_c_haines@btinternet.com>
References: <1394188612-3662-1-git-send-email-richard_c_haines@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri,  7 Mar 2014 10:36:52 +0000
Richard Haines <richard_c_haines@btinternet.com> wrote:

> The process SELinux contexts can be added to the output using the -Z
> option. Using the -z option will show the process and socket contexts (see
> the man page for details).
> For netlink sockets: if valid process show process context, if pid = 0
> show kernel initial context, if unknown show "unavailable".
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Applied, thanks
