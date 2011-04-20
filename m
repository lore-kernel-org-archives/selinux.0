Date: Thu, 21 Apr 2011 09:08:15 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 2/2] SELinux: security_read_policy should take a size_t
 not ssize_t
In-Reply-To: <20110420144250.17305.20265.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1104210907420.28763@tundra.namei.org>
References: <20110420144243.17305.13584.stgit@paris.rdu.redhat.com> <20110420144250.17305.20265.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Apr 2011, Eric Paris wrote:

> The len should be an size_t but is a ssize_t.  Easy enough fix to silence
> build warnings.  We have no need for signed-ness.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Reviewed-by: James Morris <jmorris@namei.org>

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
