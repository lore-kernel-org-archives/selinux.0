From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Joshua Brindle" <jbrindle@tresys.com>
Subject: Re: file(1)
Date: Sat, 29 Mar 2008 12:49:23 +1100
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, "SE-Linux" <selinux@tycho.nsa.gov>
References: <200803272349.32854.russell@coker.com.au> <200803291219.12623.russell@coker.com.au> <6FE441CD9F0C0C479F2D88F959B0158801CD1E90@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158801CD1E90@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803291249.25936.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 29 March 2008 12:21, "Joshua Brindle" <jbrindle@tresys.com> wrote:
> Which is fine, but it just won't be useful for future modules.

Would it be possible to try and make things work well with file(1) when 
designing future module formats?  Little things like zero terminating strings 
really help.

The magic database has entries for systems that were EOL'd 15+ years ago, so 
we will of course keep adding entries for these formats.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
