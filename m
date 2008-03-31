Date: Mon, 31 Mar 2008 12:25:53 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@redhat.com>, selinux <selinux@tycho.nsa.gov>,
        Paul Moore <paul.moore@hp.com>
Subject: Re: [PATCH-v4] SELinux: introduce permissive types
In-Reply-To: <1206711773.3302.448.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0803311224080.11733@us.intercode.com.au>
References: <1205260003.5297.109.camel@localhost.localdomain>
 <1206711773.3302.448.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 28 Mar 2008, Stephen Smalley wrote:

> 
> On Tue, 2008-03-11 at 14:26 -0400, Eric Paris wrote:
> > Introduce the concept of a permissive type.  A new ebitmap is introduced
> > to the policy database which indicates if a given type has the
> > permissive bit set or not.  This bit is tested for the scontext of any
> > denial.  The bit is meaningless on types which only appear as the target
> > of a decision and never the source.  A domain running with a permissive
> > type will be allowed to perform any action similarly to when the system
> > is globally set permissive.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
