Date: Thu, 16 Sep 2010 08:24:40 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
cc: sds@tycho.nsa.gov, eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: fix parallel compile error
In-Reply-To: <20100915134429.GA17032@windriver.com>
Message-ID: <alpine.LRH.2.00.1009160823270.32096@tundra.namei.org>
References: <1281389665-22152-1-git-send-email-paul.gortmaker@windriver.com> <alpine.LRH.2.00.1009150819270.22184@tundra.namei.org> <20100915134429.GA17032@windriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 15 Sep 2010, Paul Gortmaker wrote:

> Thanks for applying this earlier patch.  I found that there still
> is a (now smaller) corner case to trigger this because of the ss subdir,
> which is why I resent a slightly different patch to you last week.
> This updated patch does a better job of showing and fixing the problem.
> 
> http://www.spinics.net/linux/fedora/linux-security-module/msg09277.html
> 
> Let me know if you would like a delta patch, instead of rewinding
> and replacing the older one with this one.

Please send a delta patch, otherwise, it will mess up the git history.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
