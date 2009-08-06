Date: Thu, 6 Aug 2009 10:19:19 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, jwcart2@tycho.nsa.gov, sds@tycho.nsa.gov,
        spender@grsecurity.net, dwalsh@redhat.com, cl@linux-foundation.org,
        arjan@infradead.org, alan@lxorguk.ukuu.org.uk, kees@outflux.net,
        csellers@tresys.com, penguin-kernel@i-love.sakura.ne.jp,
        serue@us.ibm.com
Subject: Re: [PATCH -v4 1/3] Capabilities: move cap_file_mmap to
 commoncap.c
In-Reply-To: <20090731165358.20992.14757.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.0908061018530.7389@tundra.namei.org>
References: <20090731165358.20992.14757.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 31 Jul 2009, Eric Paris wrote:

> Currently we duplicate the mmap_min_addr test in cap_file_mmap and in
> security_file_mmap if !CONFIG_SECURITY.  This patch moves cap_file_mmap
> into commoncap.c and then calls that function directly from
> security_file_mmap ifndef CONFIG_SECURITY like all of the other capability
> checks are done.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by: Serge Hallyn <serue@us.ibm.com>


All applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

Please test!

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
