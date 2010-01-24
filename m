Date: Mon, 25 Jan 2010 09:23:12 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] selinux:  convert range transition list to a
 hashtab
In-Reply-To: <1262897716.2821.100.camel@moss-pluto.epoch.ncsc.mil>
Message-ID: <alpine.LRH.2.00.1001250922430.25365@tundra.namei.org>
References: <1262897716.2821.100.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 7 Jan 2010, Stephen Smalley wrote:

> Per https://bugzilla.redhat.com/show_bug.cgi?id=548145
> there are sufficient range transition rules in modern (Fedora) policy to
> make mls_compute_sid a significant factor on the shmem file setup path
> due to the length of the range_tr list.  Replace the simple range_tr
> list with a hashtab inside the security server to help mitigate this
> problem.
> 
> Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

Looks ok to me, and will get more testing in next.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
