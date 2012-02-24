Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1OICjPT010293
	for <selinux@tycho.nsa.gov>; Fri, 24 Feb 2012 13:12:45 -0500
Received: by eaak14 with SMTP id k14so1402720eaa.12
        for <selinux@tycho.nsa.gov>; Fri, 24 Feb 2012 10:12:43 -0800 (PST)
Date: Fri, 24 Feb 2012 19:11:38 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: libsemanage/libsepol still supported for non-MLS/MCS setups?
Message-ID: <20120224181138.GA12954@siphos.be>
References: <20120223201735.GA5810@siphos.be>
 <CACLa4ptWFe_uEeUQgd2TYmL-W6YMb8msAtSxc-csrKwhUffD1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CACLa4ptWFe_uEeUQgd2TYmL-W6YMb8msAtSxc-csrKwhUffD1g@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Feb 23, 2012 at 03:42:45PM -0500, Eric Paris wrote:
> I got a patch a week ago about this and haven't look at/applied yet.
> Would you like to test?
[...]

This one indeed seems to resolve the segmentation faults. The regression
tests give no other failures anymore.

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
