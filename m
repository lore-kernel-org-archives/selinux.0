Date: Thu, 17 Jun 2010 15:02:32 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 1/4] SELinux: seperate range transition rules to a seperate
 function
In-Reply-To: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1006171501270.10721@tundra.namei.org>
References: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 11 Jun 2010, Eric Paris wrote:

> Move the range transition rule to a separate function, range_read(), rather
> than doing it all in policydb_read()
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
