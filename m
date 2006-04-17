Subject: Re: modules.conf "stability" by sorting entries in "make conf"
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1145295756.8014.35.camel@wintermute.xmldesign.de>
References: <1145295756.8014.35.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 14:08:54 -0400
Message-Id: <1145297334.19561.2.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-04-17 at 19:42 +0200, Erich Schubert wrote:
> Hi,
> attached is a tiny patch to refpolicy/support/segenxml.py
> which will sort module files before processing, so when you create a
> "modules.conf" file via "make conf", the entries will be sorted.
> 
> Right now, the ordering depends on your filesystem, which makes diffs
> (and especially merging) between modules.conf files unnecessary hard.

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
