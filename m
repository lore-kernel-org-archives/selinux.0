Subject: Re: [Fwd: [Patch] libsemanage: remember and retrieve dontaudit
 settings]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4A4B862A.5030608@redhat.com>
References: <4A4B656D.1030004@redhat.com>
	 <1246457216.13464.162.camel@moss-pluto.epoch.ncsc.mil>
	 <1246457786.13464.165.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4B862A.5030608@redhat.com>
Content-Type: text/plain
Date: Wed, 01 Jul 2009 13:01:21 -0400
Message-Id: <1246467681.13464.189.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-01 at 11:52 -0400, Christopher Pardy wrote:
> This patch allows for the disable_dontaudit setting to be maintained 
> between calls to compile policy. Currently if policy is recompiled 
> dontaudit rules are automatically turned on unless they are specifically 
> disabled. Additionally this patch provides the ability to check weather 
> dontaudit rules are turned on.
> 
> Signed-off-by: Christopher Pardy <cpardy@redhat.com>

Better description, thanks.  s/weather/whether/

Patches should be inlined though so that we can reply and comment on
them inline.

Your patch was reversed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
