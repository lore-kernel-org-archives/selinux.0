MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 0/7] quiet gcc warnings
Date: Wed, 9 Jan 2008 13:47:08 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880153F4BE@exchange.columbia.tresys.com>
In-Reply-To: <20080103184331.485176161@tresys.com>
References: <20080103184331.485176161@tresys.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: <method@manicmethod.com>, <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

tmiller@tresys.com wrote:
> These patches fix a number of gcc warnings in the selinux userland
> build process.  They allow everything but libsemanage to build with
> -Werror.  The only thing in the way of libsemanage using -Werror is
> the flex-generated scanner.  We could just drop a few of the -W flags
> for libsemanage (like -Wundef) to make it pass.

Merged into the stable and policyrep branches.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
