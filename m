Message-ID: <1347640545.11029.63.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [RFC] Add initial clipboard access control implementation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 14 Sep 2012 12:35:45 -0400
In-Reply-To: <1347636256-4457-1-git-send-email-jbrindle@tresys.com>
References: <1347636256-4457-1-git-send-email-jbrindle@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-09-14 at 11:24 -0400, Joshua Brindle wrote:
> This is an RFC for clipboard access controls in Android. I still need to do non-SELinux system guards and check for permission when onPrimaryClipChanged() sends notifications to apps listening for clipboard updates. 
> 
> Change-Id: Ib0b6aeca59511ce71832aee1afd4150d1514a63c
> ---
>  .../java/com/android/server/ClipboardService.java  |   25 ++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Do you have a functioning policy for these controls (i.e. one that
allows normal operation but prevents something bad from happening)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
