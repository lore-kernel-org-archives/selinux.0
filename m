Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v92FTdJ2021945
 for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2017 11:29:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id e69so6057675pfg.4
 for <selinux@tycho.nsa.gov>; Mon, 02 Oct 2017 08:28:39 -0700 (PDT)
Date: Mon, 2 Oct 2017 23:28:32 +0800
From: Jason Zaman <jason@perfinion.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@tycho.nsa.gov
Message-ID: <20171002152832.GA11356@meriadoc.perfinion.com>
References: <20171001161517.16407-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171001161517.16407-1-nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/4] gui: remove the status bar
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Oct 01, 2017 at 06:15:14PM +0200, Nicolas Iooss wrote:
> The status bar of system-config-selinux's main window is not used and
> takes some room. Remove it.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged this whole set. It all worked for me when i ran it in the tree, I
also realized that i havent packaged the gui for gentoo. I'll do that
soon.

-- Jason
