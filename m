Date: Tue, 10 Nov 2009 09:34:31 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: report the module name to
 security_module_request
In-Reply-To: <7e0fb38c0911091416v15250425nc7e98fcc0004871e@mail.gmail.com>
Message-ID: <alpine.LRH.2.00.0911100934200.10675@tundra.namei.org>
References: <20091103163532.28449.1998.stgit@paris.rdu.redhat.com>  <alpine.LRH.2.00.0911040821370.29216@tundra.namei.org> <7e0fb38c0911091416v15250425nc7e98fcc0004871e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Nov 2009, Eric Paris wrote:

> >> Signed-off-by: Eric Paris <eparis@redhat.com>
> >
> > Needs to be reviewed on the LSM list.. (cc'd)
> 
> Probably no comment since SELinux is the only LSM to implement this
> hook.  Are we good now?


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
