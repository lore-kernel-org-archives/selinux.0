Message-ID: <1347990606.31966.76.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seandroid and policy version
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        Joman Chu
	 <jcchu@tycho.ncsc.mil>
Date: Tue, 18 Sep 2012 13:50:06 -0400
In-Reply-To: <CAFftDdqjtYd0RGoZ12dcJnyWpD42MPYf_KwkJitwYcaF=+ptgA@mail.gmail.com>
References: <4FFCC3C7.8080602@tresys.com>
	 <1342011045.29461.28.camel@moss-pluto.epoch.ncsc.mil>
	 <4FFDD7C7.4020703@tresys.com>
	 <1342036191.29461.75.camel@moss-pluto.epoch.ncsc.mil>
	 <1347989611.31966.66.camel@moss-pluto.epoch.ncsc.mil>
	 <CAFftDdqjtYd0RGoZ12dcJnyWpD42MPYf_KwkJitwYcaF=+ptgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-09-18 at 10:46 -0700, William Roberts wrote:
> How hard is it to parse the header, is it a simple fixed with field?
> 
> 
> I could go either way on this, I like have the version number in the
> file name myself.

See the beginning of policydb_read() in security/selinux/ss/policydb.c.
Fairly straightforward, especially as we can presume that it is a
SELinux kernel policy.  We would just read and check the magic number,
skip the fixed string identifier, and read the version number.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
