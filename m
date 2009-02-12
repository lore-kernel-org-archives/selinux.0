From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 5/5] SELinux: convert the avc cache hash list to an hlist
Date: Thu, 12 Feb 2009 15:40:58 -0500
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
References: <20090212195043.25599.80206.stgit@paris.rdu.redhat.com> <20090212195104.25599.75942.stgit@paris.rdu.redhat.com>
In-Reply-To: <20090212195104.25599.75942.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200902121540.58555.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 12 February 2009 02:51:04 pm Eric Paris wrote:
> We do not need O(1) access to the tail of the avc cache lists and so we are
> wasting lots of space using struct list_head instead of struct hlist_head.
> This patch converts the avc cache to use hlists in which there is a single
> pointer from the head which saves us about 4k of global memory.
>
> Resulted in about a 1.5% decrease in time spent in avc_has_perm_noaudit
> based on oprofile sampling of tbench.  Although likely within the noise....
>
> Signed-off-by: Eric Paris <eparis@redhat.com>

Reviewed-by: Paul Moore <paul.moore@hp.com>

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
