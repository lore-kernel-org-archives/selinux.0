Date: Thu, 4 Feb 2010 09:07:38 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Guido Trentalancia <guido@trentalancia.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy
 reload
In-Reply-To: <1265211620.3013.2.camel@tesla.lan>
Message-ID: <alpine.LRH.2.00.1002040907250.25177@tundra.namei.org>
References: <1265211620.3013.2.camel@tesla.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Feb 2010, Guido Trentalancia wrote:

> Author: Guido Trentalancia <guido@trentalancia.com>
> Date:   Mon Feb 02 23:11:07 2010 +0100
> 
>     Allow runtime switching between different policy types (e.g. from a MLS/MCS
>     policy to a non-MLS/non-MCS policy or viceversa).
> 
>     Signed-off-by: Guido Trentalancia <guido@trentalancia.com>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
