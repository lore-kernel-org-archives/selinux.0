Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4EJes02002557
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 15:40:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC12.oob.disa.mil (Postfix) with SMTP id 40l9zP1KCBz1pF1b
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 19:40:49 +0000 (UTC)
Received: from UPDC3CPA08_EEMSG_MP24.eemsg.mil (unknown [192.168.18.19])
 by UPDCF3IC12.oob.disa.mil (Postfix) with ESMTP id 40l9zN3k15z1pF1Y
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 19:40:48 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id m17-v6so14619735lfj.8
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 12:40:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526058913-14198-1-git-send-email-alexey.kodanev@oracle.com>
References: <1526058913-14198-1-git-send-email-alexey.kodanev@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 May 2018 15:39:04 -0400
Message-ID: <CAHC9VhTk8YEwG8kaApH9so67uZOhv=6kKpPVbpwxUju8t9B-AA@mail.gmail.com>
To: Alexey Kodanev <alexey.kodanev@oracle.com>,
 Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 linux-security-module@vger.kernel.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2 1/3] selinux: add AF_UNSPEC and INADDR_ANY
 checks to selinux_socket_bind()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 11, 2018 at 1:15 PM, Alexey Kodanev
<alexey.kodanev@oracle.com> wrote:
> Commit d452930fd3b9 ("selinux: Add SCTP support") breaks compatibility
> with the old programs that can pass sockaddr_in structure with AF_UNSPEC
> and INADDR_ANY to bind(). As a result, bind() returns EAFNOSUPPORT error.
> This was found with LTP/asapi_01 test.
>
> Similar to commit 29c486df6a20 ("net: ipv4: relax AF_INET check in
> bind()"), which relaxed AF_INET check for compatibility, add AF_UNSPEC
> case to AF_INET and make sure that the address is INADDR_ANY.
>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>
> v2: As suggested by Paul:
>     * return EINVAL for SCTP socket if sa_family is AF_UNSPEC and
>       address is not INADDR_ANY
>     * add new 'sa_family' variable so that it equals either AF_INET
>       or AF_INET6. Besides, it it will be used in the next patch that
>       fixes audit record.
>
>  security/selinux/hooks.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)

All three patches looked good to me.  I've merged them into
selinux/stable-4.17 and assuming nothing breaks in the next day or two
I'll send it up to Linus mid-week.

Thanks everyone!

-- 
paul moore
www.paul-moore.com
