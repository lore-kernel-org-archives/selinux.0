Subject: Re: [PATCH] checkpolicy: fix use-after-free
From: Stephen Smalley <sds@tycho.nsa.gov>
To: hallyn@serge.ibm.com
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050818165841.GA2788@serge.ibm.com>
References: <20050818165841.GA2788@serge.ibm.com>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 16:41:36 -0400
Message-Id: <1124397696.25854.170.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-18 at 11:58 -0500, hallyn@serge.ibm.com wrote:
> The following fixes a use after free bug found by Coverity in
> module_compiler.c.  The dest_id is freed by get_local_type()
> itself.
> 
> I'm doing this one before the libsepol patches because this
> was the only error found in checkpolicy :)

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
