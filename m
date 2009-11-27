Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nARI3g6n020463
	for <selinux@tycho.nsa.gov>; Fri, 27 Nov 2009 13:03:45 -0500
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nARI5tMU027520
	for <selinux@tycho.nsa.gov>; Fri, 27 Nov 2009 18:05:55 GMT
Message-ID: <4B10147F.5090206@manicmethod.com>
Date: Fri, 27 Nov 2009 13:03:43 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Manoj Srivastava <srivasta@golden-gryphon.com>
CC: selinux@tycho.nsa.gov, Manoj Srivastava <srivasta@debian.org>
Subject: Re: [PATCH] libsemanage: Fix the format of the NAME lines
References: <1258489723-15486-1-git-send-email-srivasta@golden-gryphon.com>
In-Reply-To: <1258489723-15486-1-git-send-email-srivasta@golden-gryphon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Manoj Srivastava wrote:
> From: Manoj Srivastava<srivasta@debian.org>
>
> Each manual page should start with a "NAME" section, which lists the
> name and a brief description of the page separated by "\-". These
> sections are parsed by "mandb" and stored in a database for the use of
> "apropos" and "whatis", so they must be in a certain format. These
> manual pages apparently use the wrong format and cannot be parsed by
> "mandb". This commit fixes that.
>
> Signed-off-by: Manoj Srivastava<srivasta@debian.org>

Merged in libsemanage 2.0.43.

In the future can you please create git diffs from our tree? I had to 
manually edit the patch because it was generated from the libsemanage 
directory rather than the top.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
