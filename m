Subject: Re: qmail policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Petre Rodan <kaiowas@gentoo.org>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <20060404165027.GA6245@peter.sunspire.org>
References: <20060404165027.GA6245@peter.sunspire.org>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 11:38:46 -0400
Message-Id: <1144251527.2490.1.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-04-04 at 19:50 +0300, Petre Rodan wrote:
> attached you'll find the qmail policy and a small patch needed to
> integrate it into serefpol.

Merged, with some reordering.  I renamed some interface names, and
removed qmail_var_run_t, which was unused.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
