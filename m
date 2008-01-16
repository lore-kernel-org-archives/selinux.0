Date: Thu, 17 Jan 2008 09:13:53 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: David Howells <dhowells@redhat.com>, sds@tycho.nsa.gov,
        casey@schaufler-ca.com, Trond.Myklebust@netapp.com, npiggin@suse.de,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/26] Add a secctx_to_secid() LSM hook to go along with
 the existing
In-Reply-To: <200801160841.46633.paul.moore@hp.com>
Message-ID: <Xine.LNX.4.64.0801170913100.23919@us.intercode.com.au>
References: <20080115234652.22183.24850.stgit@warthog.procyon.org.uk>
 <20080115234735.22183.36356.stgit@warthog.procyon.org.uk>
 <Xine.LNX.4.64.0801161204470.24959@us.intercode.com.au>
 <200801160841.46633.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 16 Jan 2008, Paul Moore wrote:

> On Tuesday 15 January 2008 8:05:27 pm James Morris wrote:
> > On Tue, 15 Jan 2008, David Howells wrote:
> > > secid_to_secctx() LSM hook.  This patch also includes the SELinux
> > > implementation for this hook.
> > >
> > > Signed-off-by: Paul Moore <paul.moore@hp.com>
> > > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> >
> > This is useful in its own right, and I would like to push it upstream for
> > 2.6.24 unless there are any objections.
> 
> Isn't it a bit late in 2.6.24 to add new functionality, especially when there 
> isn't an in-tree user for it in 2.6.24?

Actually, I meant to go into 2.6.24 after the merge window opens.

> 
> You are right, there are several users of this function currently under 
> development but I'm pretty sure all of them are targeting 2.6.25 or greater.  
> With that in mind, I think the prudent thing to is to wait and push this 
> upstream for 2.6.25.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
