Message-ID: <1347979342.31966.1.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Upstream changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 18 Sep 2012 10:42:22 -0400
In-Reply-To: <CAFftDdqrZPWj8C3ht1=FGXjh7f2szgamq8qbU1RMwgGh3Lvxkg@mail.gmail.com>
References: 
	<CAFftDdqrZPWj8C3ht1=FGXjh7f2szgamq8qbU1RMwgGh3Lvxkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-09-17 at 20:17 -0700, William Roberts wrote:
> Now that changes are going through Gerrit into AOSP's repos, will
> selinux/bitbucket version of repositories consistently pull aosp
> changes and merge them?

I just updated them.  I'll add them to the set that we pull from aosp
periodically now that we are developing directly on aosp.  Or we could
drop our local ones from the local_manifest.xml files at this point?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
