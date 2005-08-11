Subject: Re: [PATCH] fix use-after-free in matchpathcon.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: serue@us.ibm.com
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20050810213226.GA7826@serge.austin.ibm.com>
References: <20050810213226.GA7826@serge.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 10:17:47 -0400
Message-Id: <1123769867.7810.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-10 at 16:32 -0500, serue@us.ibm.com wrote:
> Following is a set of patches against (potential) bugs found by
> Coverity in libselinux.  Hopefully the rest of the selinux-usr
> libraries will follow.  None of the selinux-usr ones looked
> groundbreaking, whereas a quick peek at some later libraries
> looked scarier.

Thanks, all merged as of libselinux 1.25.2.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
