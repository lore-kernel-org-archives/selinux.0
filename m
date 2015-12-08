Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB8AiWsN018743
 for <selinux@tycho.nsa.gov>; Tue, 8 Dec 2015 05:44:32 -0500
Received: by pacdm15 with SMTP id dm15so10379589pac.3
 for <selinux@tycho.nsa.gov>; Tue, 08 Dec 2015 02:44:17 -0800 (PST)
Date: Tue, 8 Dec 2015 18:44:13 +0800
From: Jason Zaman <jason@perfinion.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: New setools3 release
Message-ID: <20151208104413.GA20349@meriadoc>
References: <566601F3.2020307@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <566601F3.2020307@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Dec 07, 2015 at 11:02:27PM +0100, Laurent Bigonville wrote:
> Hi,
> 
> Are there any plans to do a new setools3 release?
> 
> The current version is not building with the userspace 2.4 so I was 
> wondering if somebody could roll a new release? Otherwise I'll take a 
> snapshot of the git repository.

Last I checked there was not going to be any new release since all the
efforts are being put into setools4.

I have a few extra patches that you might want as well. Mainly getting
things working with newer automake and some python3 stuff. This is what
the latest version in gentoo is based off.
https://github.com/perfinion/setools3/tree/gentoo-patches

-- Jason
