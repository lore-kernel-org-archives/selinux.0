Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7NEdROb028616
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 10:39:27 -0400 (EDT)
Subject: Re: libselinux category patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <430A33E5.1030100@redhat.com>
References: <430A33E5.1030100@redhat.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 10:27:06 -0400
Message-Id: <1124807226.7874.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-22 at 16:21 -0400, Daniel J Walsh wrote:
> libselinux-rhat.patch is mainly tcs's patch with a couple of changes. 

Do we truly need to allow whitespace in the (translated) MLS field?
That change to context_new originated in the TCS patch, but I'd prefer
to avoid it if possible.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
