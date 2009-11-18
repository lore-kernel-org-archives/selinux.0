Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAIM9NVx001692
	for <selinux@tycho.nsa.gov>; Wed, 18 Nov 2009 17:09:23 -0500
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nAIM8LwQ003258
	for <selinux@tycho.nsa.gov>; Wed, 18 Nov 2009 22:08:22 GMT
Date: Thu, 19 Nov 2009 09:09:20 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: =?ISO-8859-15?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>
cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Fix warnings
In-Reply-To: <20091118160459.GA3287@hack>
Message-ID: <alpine.LRH.2.00.0911190909030.22277@tundra.namei.org>
References: <20091118143951.4691.33970.stgit@localhost.localdomain> <20091118160459.GA3287@hack>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 19 Nov 2009, Am?rico Wang wrote:

> On Wed, Nov 18, 2009 at 02:39:51PM +0000, Alan Cox wrote:
> >scripts/selinux/genheaders/genheaders.c:20: warning: no previous prototype  
> >for ?usage?
> >scripts/selinux/genheaders/genheaders.c:26: warning: no previous prototype
> >for ?stoupperx?
> >
> >Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> Acked-by: WANG Cong <xiyou.wangcong@gmail.com>
> 

Thanks.


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

> >---
> >
> > scripts/selinux/genheaders/genheaders.c |    4 ++--
> > 1 files changed, 2 insertions(+), 2 deletions(-)
> >
> >
> >diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
> >index 3b16145..771b86f 100644
> >--- a/scripts/selinux/genheaders/genheaders.c
> >+++ b/scripts/selinux/genheaders/genheaders.c
> >@@ -17,13 +17,13 @@ struct security_class_mapping {
> > 
> > const char *progname;
> > 
> >-void usage(void)
> >+static void usage(void)
> > {
> > 	printf("usage: %s flask.h av_permissions.h\n", progname);
> > 	exit(1);
> > }
> > 
> >-char *stoupperx(const char *s)
> >+static char *stoupperx(const char *s)
> > {
> > 	char *s2 = strdup(s);
> > 	char *p;
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> Live like a child, think like the god.
>  
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
