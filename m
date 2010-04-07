Date: Thu, 8 Apr 2010 09:18:16 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul.moore@hp.com
Subject: Re: [PATCH] selinux: always call sk_security_struct sksec
In-Reply-To: <20100407190846.7076.36760.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1004080917590.22872@tundra.namei.org>
References: <20100407190846.7076.36760.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 7 Apr 2010, Eric Paris wrote:

> trying to grep everything that messes with a sk_security_struct isn't easy
> since we don't always call it sksec.  Just rename everything sksec.
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
