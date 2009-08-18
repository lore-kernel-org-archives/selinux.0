Date: Wed, 19 Aug 2009 08:14:09 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Huang Weiyi <weiyi.huang@gmail.com>
cc: eparis@redhat.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Security/SELinux: remove duplicated #include
In-Reply-To: <1250603833-3972-1-git-send-email-weiyi.huang@gmail.com>
Message-ID: <alpine.LRH.2.00.0908190813520.15789@tundra.namei.org>
References: <1250603833-3972-1-git-send-email-weiyi.huang@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 Aug 2009, Huang Weiyi wrote:

> Remove duplicated #include('s) in
>   kernel/sysctl.c
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris <jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
