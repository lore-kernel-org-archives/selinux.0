Date: Thu, 28 Apr 2011 09:50:46 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 3/6] SELinux: skip filename trans rules if ttype does
 not match parent dir
In-Reply-To: <20110426180751.20636.83434.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1104280950340.17048@tundra.namei.org>
References: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com> <20110426180751.20636.83434.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 26 Apr 2011, Eric Paris wrote:

> Right now we walk to filename trans rule list for every inode that is
> created.  First passes at policy using this facility creates around 5000
> filename trans rules.  Running a list of 5000 entries every time is a bad
> idea.  This patch adds a new ebitmap to policy which has a bit set for each
> ttype that has at least 1 filename trans rule.  Thus when an inode is
> created we can quickly determine if any rules exist for this parent
> directory type and can skip the list if we know there is definitely no
> relevant entry.
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
