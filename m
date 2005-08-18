Subject: Re: [PATCH] libsepol resource leak
From: Stephen Smalley <sds@tycho.nsa.gov>
To: hallyn@serge.ibm.com
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050818182043.GA7622@serge.ibm.com>
References: <20050818182043.GA7622@serge.ibm.com>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 16:41:20 -0400
Message-Id: <1124397680.25854.168.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-18 at 13:20 -0500, hallyn@serge.ibm.com wrote:
> (I am sending out four patches to libsepol.  Another 6 or so which I
> investigated were not actual bugs.  This leaves me with a little over
> half to still look at, hopefully tomorrow.  After that I'll hop to
> libsemanage or the kernel code).

Thanks, merged.  Did you look at policycoreutils?


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
