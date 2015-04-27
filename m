Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3RJRjDk032019
 for <selinux@tycho.nsa.gov>; Mon, 27 Apr 2015 15:27:46 -0400
Received: by vnbg7 with SMTP id g7so13307803vnb.11
 for <selinux@tycho.nsa.gov>; Mon, 27 Apr 2015 12:27:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <553E8CA6.70404@tycho.nsa.gov>
References: <1430162024-29420-1-git-send-email-nnk@google.com>
 <553E8CA6.70404@tycho.nsa.gov>
Date: Mon, 27 Apr 2015 12:27:43 -0700
Message-ID: <CAFJ0LnHhz5wL5q5jTuD8pwRimZ0N7dTYPPGM18EAr=4qxXfWkA@mail.gmail.com>
Subject: Re: [PATCH] Don't assume SELinux code is already installed on host
From: Nick Kralevich <nnk@google.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Apr 27, 2015 at 12:23 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Hmmm...well, we don't assume it has been installed on the host; we just
> assume that you are building as per selinux/README, i.e.
> cd selinux && make DESTDIR=~/obj install
> will correctly install to a private build directory specified via
> DESTDIR and pick up the headers and libraries from there.
>
> Using relative paths within the selinux source tree is problematic in
> the other case since historically we have distributed individual
> tarballs for each components and not the entire tree.  Actually, it was
> the other way around originally but Red Hat wanted us to break it up
> into separate tarballs for inclusion in separate packages in the Linux
> distributions.

Ok, disregard this patch then. I figured I was doing something
fundamentally wrong. Next time I should read the README.

-- Nick

-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
