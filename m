Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n06MOc3w028282
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2009 17:24:38 -0500
Received: from etbe.coker.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n06MOZwt007374
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2009 22:24:36 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: martins.listz@gmail.com
Subject: Re: Postfix with domain keys
Date: Wed, 7 Jan 2009 09:24:25 +1100
Cc: selinux@tycho.nsa.gov
References: <1231243582.2946.106.camel@kr0sty.livra.local>
In-Reply-To: <1231243582.2946.106.camel@kr0sty.livra.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901070924.27508.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 06 January 2009 23:06, Martin Spinassi <martins.listz@gmail.com> 
wrote:
> We're trying to add domain keys to a postfix server, but it can't open
> ports used by dkim to sign the mail. Here is some output of audit.log:

What do you mean?  How are you using DKIM signatures?

I am using DKIM on my Postfix server, for the Debian SE Linux policy I have a 
domain dkim_t used for the dkim-filter program (the Milter that is used for 
signing and checking signatures - known outside Debian as dkim-milter).

Ancient versions of Postfix used to require a configuration where the mail was 
forwarded to a different port where a daemon then forwarded it back - it was 
really ugly in every possible way and didn't scale.  Among other things it 
caused a proliferation of Received lines which sometimes triggered mail loop 
detection and exposed details of the configuration to the world when sending 
mail.

http://www.postfix.org/MILTER_README.html

Using a Milter is the best way to do it on a recent version of Postfix.  It 
requires Postfix version 2.3 or newer (which means the vast majority of 
Postfix servers are new enough).

> I've allready added the port to the postfix_master_t domain with:
> # semanage port -a -t postfix_master_t -p tcp 10026

Generally the best thing to do in such situations is to examine the context 
used for a similar port, the command "semanage port -l|grep 25" shows that 
smtp_port_t is used.  While I don't recommend doing what you are doing, using 
the type smtp_port_t is probably going to give a better result than any other 
pre-existing type.

> It's a RHEL 5.2 and kernel 2.6.18-92.1.22.el5.

I have some CentOS 5.2 servers running Postfix with a milter for DKIM (as part 
of the work required to provide the real service).  The milter in question is 
a proprietary system to prevent Phishing email (you can contact me off-list 
if you want to participate in the beta program).

But I'm sure that dkim-milter would also work well on CentOS 5.2 and RHEL 5.2 
with Postfix.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
