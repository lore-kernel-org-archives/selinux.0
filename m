Message-ID: <1343737896.13704.2.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Cloning Android repo's from bitbucket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 31 Jul 2012 08:31:36 -0400
In-Reply-To: <CAFftDdoBpZ9ruMjnBwiA9Cxh0L14xJiXh5LXam3V=n-jHTbYkg@mail.gmail.com>
References: 
	<CAFftDdoBpZ9ruMjnBwiA9Cxh0L14xJiXh5LXam3V=n-jHTbYkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-30 at 16:59 -0700, William Roberts wrote:
> HTTPS checkouts of device-samsung-tuna fail, but the ssh clone worked for me.
> 
> Can we get new local_manifest branches, that specify using the git/ssh
> checkout as the fetch url instead of https?
> 
> something like this:
> 
> master <-- https
> master-ssh <-ssh
> 
> Keep is simple and consistent please so scripting is easy.
> 
> The only downside is you must have a registered bitbucket account and
> ssh keys set up, but thats not a major problem if people use those
> branches!

Done.  master-ssh, seandroid-4.0.4-ssh, seandroid-4.1.1-ssh branches
created.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
