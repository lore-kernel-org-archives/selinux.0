MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/3] Separate local file contextsinto	file_contexts.local
Date: Tue, 15 Aug 2006 19:42:12 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832B368@exchange.columbia.tresys.com>
In-Reply-To: <1155582383.28766.229.camel@moss-spartans.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> On Mon, 2006-08-14 at 10:38 -0400, Stephen Smalley wrote:
> > On Sat, 2006-08-12 at 09:21 -0400, Joshua Brindle wrote:
> > > Stephen Smalley wrote:
> > > > On Fri, 2006-08-11 at 09:34 -0400, Christopher J. 
> PeBenito wrote:
> 
> Patch below restores the errors to being fatal, with 
> exceptions being granted for an ENOENT for 
> file_contexts.local (optional), seusers (was already 
> non-fatal and optional), and netfilter_contexts (may not 
> exist in all policies, e.g. legacy ones and ones that are 
> using compat_net=1).
> Acceptable to all parties?
> 

I'm happy with this but does it fix the permission problem? I thought
the motivation behind the patch was to be able to install the policy
when the policy didn't allow copying of some files? ENOENT will just
check if it doesn't exist won't it?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
