Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09KKwt2018164
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 15:20:58 -0500
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <selinux@tycho.nsa.gov> from <zohar@linux.vnet.ibm.com>;
 Thu, 9 Jan 2014 13:20:56 -0700
Message-ID: <1389298851.15186.57.camel@dhcp-9-2-203-236.watson.ibm.com>
Subject: Re: [PATCH] SELinux: Fix possible NULL pointer dereference in
 selinux_inode_permission()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 09 Jan 2014 15:20:51 -0500
In-Reply-To: <52CEC9DD.4000901@tycho.nsa.gov>
References: <20140109101932.0508dec7@gandalf.local.home>
 <CACLa4pv+EUGHO+MKj8ckhmi8YKiTNVL9pSM+DDsjg+0jbjOCcA@mail.gmail.com>
 <20140109105114.5c409fef@gandalf.local.home>
 <1389283030.15209.56.camel@localhost> <1389283545.15209.59.camel@localhost>
 <52CEC9DD.4000901@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-security-module@vger.kernel.org, Eric Paris <eparis@redhat.com>,
 James Morris <james.l.morris@oracle.com>, stable <stable@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, selinux@tycho.nsa.gov,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-01-09 at 11:10 -0500, Stephen Smalley wrote: 
> On 01/09/2014 11:05 AM, Eric Paris wrote:
> > [adding lsm and selinux]
> > 
> > Am I just crazy, or was this bug discussed (and obviously not fixed)
> > some time ago?
> > 
> > VFS can still use inodes after security_inode_free_security() was
> > called...
> 
> I didn't know that was the case; originally when we added the hook it
> was not possible.   I have seen a Red Hat bugzilla report about it,
> but no upstream discussion.

For those of us that don't have access to the RH bugzilla, can someone
please summarize the problem?

thanks,

Mimi
