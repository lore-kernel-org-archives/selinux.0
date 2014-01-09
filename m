Message-ID: <52CEC9DD.4000901@tycho.nsa.gov>
Date: Thu, 09 Jan 2014 11:10:05 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] SELinux: Fix possible NULL pointer dereference in
 selinux_inode_permission()
References: <20140109101932.0508dec7@gandalf.local.home>	
 <CACLa4pv+EUGHO+MKj8ckhmi8YKiTNVL9pSM+DDsjg+0jbjOCcA@mail.gmail.com>	
 <20140109105114.5c409fef@gandalf.local.home>	
 <1389283030.15209.56.camel@localhost> <1389283545.15209.59.camel@localhost>
In-Reply-To: <1389283545.15209.59.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Cc: LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>,
 linux-security-module@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/09/2014 11:05 AM, Eric Paris wrote:
> [adding lsm and selinux]
> 
> Am I just crazy, or was this bug discussed (and obviously not fixed)
> some time ago?
> 
> VFS can still use inodes after security_inode_free_security() was
> called...

I didn't know that was the case; originally when we added the hook it
was not possible.   I have seen a Red Hat bugzilla report about it,
but no upstream discussion.
