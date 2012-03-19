Subject: Re: [PATCH] (SCH-i515 US LTE) Added device specific policy and
 file context files.[PUBLIC DOMAIN]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bryan Hinton <bryan@bryanhinton.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1331083722-5732-1-git-send-email-bryan@bryanhinton.com>
References: <1331083722-5732-1-git-send-email-bryan@bryanhinton.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Mar 2012 16:08:51 -0400
Message-ID: <1332187731.23035.72.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-03-06 at 19:28 -0600, Bryan Hinton wrote:
> Change-Id: Iaf0aa012e48dd3084aae6f57c25a022b210308ff
> ---
>  sepolicy.fc |   13 +++++++++++++
>  sepolicy.te |    4 ++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
>  create mode 100644 sepolicy.fc
>  create mode 100644 sepolicy.te

Merged, with some rules integrated into the base policy and some rules
removed based on our discussion.  Thanks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
