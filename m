Date: Wed, 7 Oct 2009 22:18:21 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Kaigai Kohei <kaigai@ak.jp.nec.com>
Subject: Re: [PATCH v5 1/2] selinux:  dynamic class/perm discovery
In-Reply-To: <1254332270.30591.76.camel@moss-pluto.epoch.ncsc.mil>
Message-ID: <alpine.LRH.2.00.0910072217570.20127@tundra.namei.org>
References: <1254332270.30591.76.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 30 Sep 2009, Stephen Smalley wrote:

> Modify SELinux to dynamically discover class and permission values
> upon policy load, based on the dynamic object class/perm discovery
> logic from libselinux.  A mapping is created between kernel-private
> class and permission indices used outside the security server and the
> policy values used within the security server.


Both applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
