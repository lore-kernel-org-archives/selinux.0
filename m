Date: Wed, 21 Apr 2010 09:06:09 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: return error codes on policy load failure
In-Reply-To: <1271774878.30027.77.camel@moss-pluto.epoch.ncsc.mil>
Message-ID: <alpine.LRH.2.00.1004210905370.30324@tundra.namei.org>
References: <20100420142942.16035.61381.stgit@paris.rdu.redhat.com> <1271774878.30027.77.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 20 Apr 2010, Stephen Smalley wrote:

> Note that policydb_read() internally has the same problem on some code
> paths, leading to the logic on the bad: path that defaults to EINVAL if
> not otherwise set.

Added to the kernel development todo list:
http://selinuxproject.org/page/Kernel_Development#To_Do_List

(which could use more love :-)


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
