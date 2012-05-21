Subject: Re: local_mainfest.xml
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, seandroid@tycho.nsa.gov
In-Reply-To: <CAFftDdp7eW0swem7kMD589eQm6LT4pN5yf4-at9wMv1T9wY9rQ@mail.gmail.com>
References: 
	 <CAFftDdp7eW0swem7kMD589eQm6LT4pN5yf4-at9wMv1T9wY9rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 May 2012 13:53:48 -0400
Message-ID: <1337622828.28413.106.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
