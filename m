Subject: Re: [PATCH] Add version option to policycoreutils
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: Selinux@tycho.nsa.gov, Steve G <linux_4ever@yahoo.com>
In-Reply-To: <200602101445.23334.glommer@br.ibm.com>
References: <200602101445.23334.glommer@br.ibm.com>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 10:37:35 -0500
Message-Id: <1139845055.14253.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-02-10 at 14:45 -0200, Glauber de Oliveira Costa wrote:
> Along with it's manpages changes, this patch coalesces all the changes 
> suggested by people in the list. More programs in the policycoreutils suite 
> may follow soon

Merged as of policycoreutils 1.29.23.

$ newrole -V
newrole: policycoreutils version 1.29.23

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
