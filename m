Subject: Re: policycoreutils in SID
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30807101200u12c70303oae012931a6aa903@mail.gmail.com>
References: <dd18b0c30807101200u12c70303oae012931a6aa903@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Jul 2008 15:29:00 -0400
Message-Id: <1215718140.31554.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-07-10 at 19:00 +0000, Justin Mattock wrote:
> Hello; I updated my system with debian sid a few days ago, and notice
> audit2allow -d was giving me this:
>  File "/usr/bin/audit2allow", line 23
>     import python-sepolgen.audit as audit
>                  ^
> SyntaxError: invalid syntax
> 
> the bug report is here:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=486120
> is there a workaround for this, or a new package?

That's a question for Debian maintainers, not us.  Upstream audit2allow
doesn't have that python- prefix at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
