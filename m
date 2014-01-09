Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09GMsVO001026
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 11:22:55 -0500
Date: Thu, 9 Jan 2014 11:22:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] SELinux: Fix possible NULL pointer dereference in
 selinux_inode_permission()
Message-ID: <20140109112249.30d457d8@gandalf.local.home>
In-Reply-To: <52CEC9DD.4000901@tycho.nsa.gov>
References: <20140109101932.0508dec7@gandalf.local.home>
 <CACLa4pv+EUGHO+MKj8ckhmi8YKiTNVL9pSM+DDsjg+0jbjOCcA@mail.gmail.com>
 <20140109105114.5c409fef@gandalf.local.home>
 <1389283030.15209.56.camel@localhost>
 <1389283545.15209.59.camel@localhost>
 <52CEC9DD.4000901@tycho.nsa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
 linux-security-module@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>, stable <stable@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 09 Jan 2014 11:10:05 -0500
Stephen Smalley <sds@tycho.nsa.gov> wrote:

> I didn't know that was the case; originally when we added the hook it
> was not possible.   I have seen a Red Hat bugzilla report about it,
> but no upstream discussion.

Maybe not enough people use SELinux ;-)

Do you know what the Red Hat BZ # was?

-- Steve
