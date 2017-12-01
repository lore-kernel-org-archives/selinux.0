Date: Fri, 1 Dec 2017 12:55:18 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
cc: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>,
 netdev@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, LSM <linux-security-module@vger.kernel.org>
In-Reply-To: <1512039044.19682.12.camel@gmail.com>
Message-ID: <alpine.LFD.2.20.1712011253310.366@localhost>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
 <4d73f839-7a86-6edc-b44b-e296bd5947c2@schaufler-ca.com>
 <alpine.LFD.2.20.1711301130330.17322@localhost>
 <ae2e71e4-c366-5a1e-9fd6-4de944f4a158@schaufler-ca.com>
 <1512039044.19682.12.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [BUG] kernel stack corruption during/after Netlabel
 error
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 30 Nov 2017, Eric Dumazet wrote:

> On Wed, 2017-11-29 at 19:16 -0800, Casey Schaufler wrote:
> > On 11/29/2017 4:31 PM, James Morris wrote:
> > > On Wed, 29 Nov 2017, Casey Schaufler wrote:
> > > 
> > > > I see that there is a proposed fix later in the thread, but I
> > > > don't see
> > > > the patch. Could you send it to me, so I can try it on my
> > > > problem?
> > > 
> > > Forwarded off-list.
> > 
> > The patch does fix the problem I was seeing in Smack.
> 
> Can you guys test the following more complete patch ?
> 
> It should cover IPv4 and IPv6, and also the corner cases.


Tested-by: James Morris <james.l.morris@oracle.com>



-- 
James Morris
<james.l.morris@oracle.com>
