Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9DGwbNF007276
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 12:58:37 -0400
Received: from web36602.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k9DGvI2X007967
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 16:57:19 GMT
Message-ID: <20061013165831.49220.qmail@web36602.mail.mud.yahoo.com>
Date: Fri, 13 Oct 2006 09:58:31 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: context_sensitivity_{get|set}
To: Matt Anderson <mra@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <452FBCF8.2060805@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Matt Anderson <mra@hp.com> wrote:


> For my usage I need the entire low level.  There may
> be other users want
> just the sensitivity, but I'd be concerned that
> information would be
> unintentionally downgraded by leaving off
> categories.

This has got to stop. Sensitivity has ALWAYS
refered to the entire sensitivity label,
heirarchical and categories combined. You
never ever deal with them seperately, in
code or in dialog. I know of exactly one
exception to this rule, and the current
project remains innocent of it. I'm not going
to be the serpent in the garden and tell
you what it is, either.

Level is the hierarchical component.
Categories or compartments describe
the non-hierarchical component.
Sensitivity is the combination of
at least those two parts.

Always.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
