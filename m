From: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
        William Roberts
	<bill.c.roberts@gmail.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "seandroid@tycho.nsa.gov"
	<seandroid@tycho.nsa.gov>
Subject: RE: local_mainfest.xml
Date: Mon, 21 May 2012 18:17:07 +0000
Message-ID: <33006C99F5A5194A9B7A7715DFA3E3836504B4AA@ALA-MBB.corp.ad.wrs.com>
References: <CAFftDdp7eW0swem7kMD589eQm6LT4pN5yf4-at9wMv1T9wY9rQ@mail.gmail.com>,<1337622828.28413.106.camel@moss-pluto>
In-Reply-To: <1337622828.28413.106.camel@moss-pluto>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sounds like a good organization to me.

You might want to name the branches similar to what AOSP uses, but mayme with "se" or "se_" prepended.  E.g. se_android-4.0.3_r1 instead of seandroid-4.0.3

In the past, there were times I would have liked the history, but I don't need it now.

________________________________________
From: owner-selinux@tycho.nsa.gov [owner-selinux@tycho.nsa.gov] on behalf of Stephen Smalley [sds@tycho.nsa.gov]
Sent: Monday, May 21, 2012 10:53 AM
To: William Roberts
Cc: selinux@tycho.nsa.gov; seandroid@tycho.nsa.gov
Subject: Re: local_mainfest.xml

On Mon, 2012-05-21 at 10:22 -0700, William Roberts wrote:
> Is the local_manifest file under git revision control somewhere that
> we could track from?

Not presently.  If it would be helpful, we could set one up, but we
should make sure we work out how it should be organized up front.  At
present, we provide 6 versions of the local_manifest.xml file.  There
are three baselines (master, 4.0.3, 4.0.4) and two fetch URLs (one
git-based and one http-based).  The repo could contain two files
(local_manifest.xml and local_manifest_http.xml) with three branches
(master, seandroid-4.0.3, seandroid-4.0.4), thereby mirroring the
structure of the other git projects.  Is that what you would want?  Did
you need/want any of the older versions of the files included in the
history (if so, which ones?) or just start from the current ones?

--
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
