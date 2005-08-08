Subject: RE: Attributes in new binary format
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
   selinux-dev@tresys.com
In-Reply-To: <200508081641.j78GfSss016318@gotham.columbia.tresys.com>
References: <200508081641.j78GfSss016318@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 13:48:32 -0400
Message-Id: <1123523312.13654.317.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-08 at 12:41 -0400, Frank Mayer wrote:
> It all comes down to trade-offs. In our experience there are times you need
> to or are forced to use the binary format for analysis. We can with some
> effort do the expansion in lipabol and put the binary format into the
> current format without attributes. However, we always wished the binary
> format had attributes. Now it does (almost). 
> 
> If it required extensive kernel resources to maintain the symbols in the
> binary file format, we wouldn't suggest it. But it seems like the effort is
> fairly small (skip over entries on read) and the gain, IMO, is great. Hence
> the suggestion. Frank

I'm not convinced there is a real gain (useful traceback from analysis
still requires higher level formats than the kernel format, even if we
include the attribute symbols in the kernel format), and in any event,
the kernel doesn't need the information.  The more natural step would be
to emit an auxiliary file with the additional information like the
kernel's System.map file and install that file for use by userspace
tools than to put it into the kernel's format.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
