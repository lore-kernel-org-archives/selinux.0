Date: Mon, 18 Oct 2010 10:15:20 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Patrick McHardy <kaber@trash.net>
cc: Eric Paris <eparis@redhat.com>, netfilter-devel@vger.kernel.org,
        selinux@tycho.nsa.gov, jengelh@medozas.de, paul.moore@hp.com,
        sds@tycho.nsa.gov, pablo@netfilter.org
Subject: Re: [PATCH 1/4] secmark: make secmark object handling generic
In-Reply-To: <4CB870D9.6020703@trash.net>
Message-ID: <alpine.LRH.2.00.1010181015060.9476@tundra.namei.org>
References: <20101013202441.15272.75924.stgit@paris.rdu.redhat.com> <4CB870D9.6020703@trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 15 Oct 2010, Patrick McHardy wrote:

> Am 13.10.2010 22:24, schrieb Eric Paris:
> > Right now secmark has lots of direct selinux calls.  Use all LSM calls and
> > remove all SELinux specific knowledge.  The only SELinux specific knowledge
> > we leave is the mode.  The only point is to make sure that other LSMs at
> > least test this generic code before they assume it works.  (They may also
> > have to make changes if they do not represent labels as strings)
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > Acked-by: Paul Moore <paul.moore@hp.com>
> 
> I think these patches should go through the security tree.
> 
> Acked-by: Patrick McHardy <kaber@trash.net>

All applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
