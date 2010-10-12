Subject: Re: [PATCH 5/5] secmark: export secctx, drop secmark in procfs
From: Eric Paris <eparis@redhat.com>
To: Paul Moore <paul.moore@hp.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        netfilter@vger.kernel.org, jmorris@namei.org, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov, jengelh@medozas.de,
        linux-security-module@vger.kernel.org, mr.dash.four@googlemail.com,
        pablo@netfilter.org
In-Reply-To: <1286925596.5133.102.camel@sifl>
References: <20101012154008.26943.44399.stgit@paris.rdu.redhat.com>
	 <20101012154035.26943.35175.stgit@paris.rdu.redhat.com>
	 <1286925596.5133.102.camel@sifl>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Oct 2010 19:27:43 -0400
Message-ID: <1286926063.2614.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-10-12 at 19:19 -0400, Paul Moore wrote:
> On Tue, 2010-10-12 at 11:40 -0400, Eric Paris wrote:
> > The current secmark code exports a secmark= field which just indicates if
> > there is special labeling on a packet or not.  We drop this field as it
> > isn't particularly useful and instead export a new field secctx= which is
> > the actual human readable text label.
> 
> Looks reasonable to me, just some small nits/questions below ...

Will switch to u32 in -v2.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
