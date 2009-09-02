From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [libsepol] Unchecked input leades to integer underflow
References: <878wh1jpmi.fsf@anzu.internal.golden-gryphon.com>
	<1251722290.16143.27.camel@moss-pluto.epoch.ncsc.mil>
	<1251726998.16143.95.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 01 Sep 2009 19:19:26 -0500
In-Reply-To: <1251726998.16143.95.camel@moss-pluto.epoch.ncsc.mil> (Stephen
	Smalley's message of "Mon, 31 Aug 2009 09:56:38 -0400")
Message-ID: <87skf6nqpd.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        Thanks for the fix; I have uploaded the new version to
 Debian. And yes, while the proximate cause has been detected and
 handled, I am asking the bug reporter for additional information to
 help identify what went wrong to cause the file pointer to be NULL.

        I'll keep y'all posted.

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
