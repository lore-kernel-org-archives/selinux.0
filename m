Message-ID: <527D532A.8080209@tycho.nsa.gov>
Date: Fri, 08 Nov 2013 16:10:02 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dan Walsh <dwalsh@redhat.com>, eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 08/08] Add message to tell user to install sandbox policy
 package.
References: <1383916655-9354-1-git-send-email-dwalsh@redhat.com> <1383916655-9354-9-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1383916655-9354-9-git-send-email-dwalsh@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/08/2013 08:17 AM, Dan Walsh wrote:
> Sandbox policy is huge do to macro expansion.  We do not install this by default
> but sandbox command can fail without it installed.  This patch prints a message to the
> user to install the package.
> 
> Signed-off-by: Dan Walsh <dwalsh@redhat.com>

Thanks, applied to #next.  Did not receive patch 06/08.
patch 01/08 looked like a bug fix that should get pushed as an update, yes?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
