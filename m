Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j03DsKIi016875
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 08:54:21 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j03DqTFS024338
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 13:52:29 GMT
Subject: Re: SE-Linux File server
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: jayendren@hivsa.com
Cc: "'Nick Gray'" <nick-lists@austin.rr.com>,
   "'SELinux ML'" <selinux@tycho.nsa.gov>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAqur+5IHVuUGKlxy5XOOGrsKAAAAQAAAAiUOjQVjb2kSS9Z+gj+Oy2AEAAAAA@hivsa.com>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAqur+5IHVuUGKlxy5XOOGrsKAAAAQAAAAiUOjQVjb2kSS9Z+gj+Oy2AEAAAAA@hivsa.com>
Content-Type: text/plain
Message-Id: <1104760100.16598.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 03 Jan 2005 08:48:20 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-30 at 01:06, Jayendren Anand Maduray wrote:
> Hi!
> I am planning to implement a file server using FC2 with SELinux.
> It will server as a smb server.
> Are they any best practices/guidelines that you guys have?

FC3 is strongly recommended over FC2 for SELinux users.  See the
"Upgrade to Fedora Core 3" note in
http://fedora.redhat.com/docs/selinux-faq-fc2/.  Note that you will then
likely want to switch to strict policy on FC3, not the default targeted
policy.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
