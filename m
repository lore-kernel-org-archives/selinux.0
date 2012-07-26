Message-ID: <1343333073.5186.25.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Support for sebool in seapp_contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <w.roberts@sta.samsung.com>
Cc: William Roberts <bill.c.roberts@gmail.com>,
        "selinux@tycho.nsa.gov"
	 <selinux@tycho.nsa.gov>
Date: Thu, 26 Jul 2012 16:04:33 -0400
In-Reply-To: <E24EB765E1998A40A0C06DE52672C4820176F6C8A5F5@staex7mb1.telecom.sna.samsung.com>
References: <1343330131-11754-1-git-send-email-w.roberts@sta.samsung.com>
	 <1343330962.5186.21.camel@moss-pluto.epoch.ncsc.mil>
	 <E24EB765E1998A40A0C06DE52672C4820176F6C8A5F5@staex7mb1.telecom.sna.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-26 at 14:58 -0500, William Roberts wrote:
> I've been thinking of checking the enforcing level. If it is enforcing then it should error, if it is permissive then it should warn and let the app start in the wrong context.
> 
> When brining the system up on new platforms this is often a problem. I will make this change and resubmit.

Do you mean in general (i.e. changing the err block to check
security_getenforce), or just for the case where a boolean isn't
defined?

I have mixed feelings about checking and using security_getenforce() for
anything other than permission denials, as it can hide problems during
testing.  Also, in Android, it is a bit harder to switch the system back
to permissive mode than on a conventional Linux system.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
