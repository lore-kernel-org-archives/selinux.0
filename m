From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 3/5] SELinux: remove unused av.decided field
Date: Thu, 12 Feb 2009 15:33:11 -0500
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
References: <20090212195043.25599.80206.stgit@paris.rdu.redhat.com> <20090212195054.25599.88354.stgit@paris.rdu.redhat.com>
In-Reply-To: <20090212195054.25599.88354.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200902121533.11365.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 12 February 2009 02:50:54 pm Eric Paris wrote:
> It appears there was an intention to have the security server only decide
> certain permissions and leave other for later as some sort of a portential
> performance win.  We are currently always deciding all 32 bits of
> permissions and this is a useless couple of branches and wasted space.
> This patch completely drops the av.decided concept.
>
> This in a 17% reduction in the time spent in avc_has_perm_noaudit
> based on oprofile sampling of a tbench benchmark.
>
> Signed-off-by: Eric Paris <eparis@redhat.com>

No comments at all this time ;)

Reviewed-by: Paul Moore <paul.moore@hp.com>

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
