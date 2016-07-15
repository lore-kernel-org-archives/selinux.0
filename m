From: Steve Grubb <sgrubb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: william.c.roberts@intel.com, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
 linux-audit@redhat.com
Subject: Re: [PATCH] selinux: print leading 0x on ioctlcmd audits
Date: Fri, 15 Jul 2016 14:54:23 -0400
Message-ID: <1613578.6STCXkp1CU@x2>
In-Reply-To: <CAHC9VhReO7tLcB=K6KbGpH_inzMCLVLHmYWibNFGVku27Y=kFw@mail.gmail.com>
References: <1468524562-30981-1-git-send-email-william.c.roberts@intel.com>
 <CAHC9VhReO7tLcB=K6KbGpH_inzMCLVLHmYWibNFGVku27Y=kFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Thursday, July 14, 2016 6:17:32 PM EDT Paul Moore wrote:
> Re: [PATCH] selinux: print leading 0x on ioctlcmd audits
> From:	Paul Moore <paul@paul-moore.com>
> To:	william.c.roberts@intel.com
> CC:	selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, Stephen Smalley
> <sds@tycho.nsa.gov>, Me, linux-audit@redhat.com Date:	Yesterday 6:17 PM
> 
> On Thu, Jul 14, 2016 at 3:29 PM,  <william.c.roberts@intel.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> > 
> > ioctlcmd is currently printing hex numbers, but their is no leading
> > 0x. Thus things like ioctlcmd=1234 are misleading, as the base is
> > not evident.
> > 
> > Correct this by adding 0x as a prefix, so ioctlcmd=1234 becomes
> > ioctlcmd=0x1234.
> > 
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> > security/lsm_audit.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> NOTE: adding Steve Grubb and the audit mailing list to the CC line
> 
> Like it or not, I believe the general standard/convention when it
> comes to things like this is to leave off the "0x" prefix; the idea
> being that is saves precious space in the audit logs and the value is
> only ever going to be in hex anyway.

We normally like the 0x prefix on anything that is hex so that stroul can figure 
it out itself. And since AVC's should in theory be rare or occassional, log 
space is not a concern.

That said, what is this ioctlcmd field name? Is this the ioctl number? As in 
syscall arg a1? If so, it should be hooked up to the interpretation for that.

Also, we have a field dictionary with some basic info about each field used in 
audit events:

http://people.redhat.com/sgrubb/audit/field-dictionary.txt

This is important so that people don't make up new ones that do the same 
thing. The ioctlcmd field name should be recorded. Are there more that need 
documenting?

-Steve
