Date: Fri, 17 Sep 2010 08:30:39 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
cc: sds@tycho.nsa.gov, eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: fix parallel compile error
In-Reply-To: <20100916001452.GA2988@windriver.com>
Message-ID: <alpine.LRH.2.00.1009170830160.9105@tundra.namei.org>
References: <1281389665-22152-1-git-send-email-paul.gortmaker@windriver.com> <alpine.LRH.2.00.1009150819270.22184@tundra.namei.org> <20100915134429.GA17032@windriver.com> <alpine.LRH.2.00.1009160823270.32096@tundra.namei.org>
 <20100916001452.GA2988@windriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 15 Sep 2010, Paul Gortmaker wrote:

> With this change, compiling of all selinux files is dependent on
> completion of the header file generation, and this test case with
> the "sleep 30" now confirms it is functioning as expected.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  security/selinux/Makefile    |   17 ++++++-----------
>  security/selinux/ss/Makefile |    9 ---------
>  2 files changed, 6 insertions(+), 20 deletions(-)
>  delete mode 100644 security/selinux/ss/Makefile


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
