Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09KOP4s018416
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 15:24:25 -0500
Received: by mail-lb0-f174.google.com with SMTP id p9so841164lbv.19
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 12:24:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1389298851.15186.57.camel@dhcp-9-2-203-236.watson.ibm.com>
References: <20140109101932.0508dec7@gandalf.local.home>
 <CACLa4pv+EUGHO+MKj8ckhmi8YKiTNVL9pSM+DDsjg+0jbjOCcA@mail.gmail.com>
 <20140109105114.5c409fef@gandalf.local.home>
 <1389283030.15209.56.camel@localhost>
 <1389283545.15209.59.camel@localhost>
 <52CEC9DD.4000901@tycho.nsa.gov>
 <1389298851.15186.57.camel@dhcp-9-2-203-236.watson.ibm.com>
Date: Thu, 9 Jan 2014 15:24:22 -0500
Message-ID: <CACLa4ptPZaCbopGaoNe60qDhVOyu+-NNxYhYuvhiwdb9Oy=cDg@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Fix possible NULL pointer dereference in
 selinux_inode_permission()
From: Eric Paris <eparis@parisplace.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Eric Paris <eparis@redhat.com>, James Morris <james.l.morris@oracle.com>,
 stable <stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE-Linux <selinux@tycho.nsa.gov>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jan 9, 2014 at 3:20 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> For those of us that don't have access to the RH bugzilla, can someone
> please summarize the problem?

The upstream discussion (nothing really useful in the bug other than a
link to it) is here.

http://oss.sgi.com/archives/xfs/2013-11/msg00709.html
