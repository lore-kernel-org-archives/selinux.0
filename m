Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j045pfIi022442
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 00:51:42 -0500 (EST)
Received: from mail02.infosat.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j045pgA9020012
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 05:51:44 GMT
Received: from [196.38.110.14] (HELO mail01.infosat.net)
  by mail02.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with ESMTP id 176097685 for selinux@tycho.nsa.gov; Tue, 04 Jan 2005 07:51:28 +0200
Received: from [66.18.72.157] (HELO hivsa.com)
  by mail01.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with SMTP id 579540353 for selinux@tycho.nsa.gov; Tue, 04 Jan 2005 07:51:27 +0200
Reply-To: <jayendren@hivsa.com>
From: "Jayendren Anand Maduray" <jayendren@hivsa.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: "'Nick Gray'" <nick-lists@austin.rr.com>,
   "'SELinux ML'" <selinux@tycho.nsa.gov>
Subject: RE: SE-Linux File server
Date: Tue, 4 Jan 2005 07:50:31 +0200
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAqur+5IHVuUGKlxy5XOOGrsKAAAAQAAAA+j5CLm/o9kG/SUs2KF3F6QEAAAAA@hivsa.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1104760100.16598.36.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Happy new year!

Thanks, I just downloaded fc3, however the upgrade process seems to be a bit
iffy, so I performed a clean install.
I will try out the strict policy, and thanks a million for your response.

God bless.

-----Original Message-----
From: Stephen Smalley [mailto:sds@epoch.ncsc.mil] 
Sent: 03 January 2005 03:48 PM
To: jayendren@hivsa.com
Cc: 'Nick Gray'; 'SELinux ML'
Subject: Re: SE-Linux File server

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
