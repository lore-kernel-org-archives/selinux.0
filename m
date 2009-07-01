Subject: Re: [Fwd: [Patch] libsemanage: remember and retrieve dontaudit
 settings]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4A4B656D.1030004@redhat.com>
References: <4A4B656D.1030004@redhat.com>
Content-Type: text/plain
Date: Wed, 01 Jul 2009 10:06:56 -0400
Message-Id: <1246457216.13464.162.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-01 at 09:32 -0400, Christopher Pardy wrote:
> Creates a empty file disable_dontaudit in the polciy directory
> (/etc/selinux/<policytype>). Checks for the existance of this file to
> set the sepol disable don't audit upon handle creation. Also provides
> the function "int semanage_get_disable_dontaudit()" which returns the
> don't audit property of the current policy.
> 
> Signed-off-by: Christopher Pardy <cpardy@redhat.com>

Your patch is not correctly generated.  Please read
http://userweb.kernel.org/~akpm/stuff/tpp.txt

In your description, please explain the rationale for the patch, not
just what it does - we can discover the latter from reading the code,
but not the former.

Why do we want this functionality?  Why is it better than the existing
semodule -DB to disable dontaudit rules and semodule -B to re-enable
them?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
