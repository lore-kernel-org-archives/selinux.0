Date: Thu, 25 Jun 2009 08:30:08 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Thomas Liu <tliu@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, eparis@parisplace.org
Subject: Re: [PATCH -v2] selinux: clean up avc node cache when disabling
 selinux
In-Reply-To: <1245880685.27271.2.camel@Ares>
Message-ID: <alpine.LRH.2.00.0906250829570.30013@tundra.namei.org>
References: <1245880456.26725.5.camel@Ares> <1245880685.27271.2.camel@Ares>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 24 Jun 2009, Thomas Liu wrote:

> Added a call to free the avc_node_cache when inside selinux_disable because
> it should not waste resources allocated during avc_init if SELinux is disabled
> and the cache will never be used.
> 
> Signed-off-by: Thomas Liu <tliu@redhat.com>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
