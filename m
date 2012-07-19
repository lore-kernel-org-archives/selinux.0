Message-ID: <1342704171.31048.15.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Initial support for translatable SEAndroid strings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Date: Thu, 19 Jul 2012 09:22:51 -0400
In-Reply-To: <1342646978-8919-2-git-send-email-w.roberts@sta.samsung.com>
References: <1342646978-8919-1-git-send-email-w.roberts@sta.samsung.com>
	 <1342646978-8919-2-git-send-email-w.roberts@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-18 at 14:29 -0700, William Roberts wrote:
> ---
>  res/values/strings.xml                           |    5 +++++
>  src/com/android/settings/DeviceInfoSettings.java |   14 +++++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 

> +        // Remove selinux information if property is not present
> +        removePreferenceIfPropertyMissing(getPreferenceScreen(), "selinux_status", PROPERTY_SELINUX_STATUS);
> +

Any particular reason for not using KEY_SELINUX_STATUS rather than the
inlined "selinux_status" string above?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
