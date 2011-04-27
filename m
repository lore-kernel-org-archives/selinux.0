Date: Thu, 28 Apr 2011 09:49:59 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 2/6] SELinux: rename filename_compute_type argument to
 *type instead of *con
In-Reply-To: <20110426180745.20636.30651.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1104280949220.17048@tundra.namei.org>
References: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com> <20110426180745.20636.30651.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 26 Apr 2011, Eric Paris wrote:

> filename_compute_type() takes as arguments the numeric value of the type of
> the subject and target.  It does not take a context.  Thus the names are
> misleading.  Fix the argument names.
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
