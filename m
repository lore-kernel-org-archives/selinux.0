Message-ID: <1343822901.20926.9.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SE Android ZoneInfo Errors
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 01 Aug 2012 08:08:21 -0400
In-Reply-To: <CAFftDdp7C3tR7NHBfYrHRn2-y9fRNJAPHnXurOb3y4jJEUkKBQ@mail.gmail.com>
References: 
	<CAFftDdp7C3tR7NHBfYrHRn2-y9fRNJAPHnXurOb3y4jJEUkKBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-31 at 18:05 -0700, William Roberts wrote:
> Is anyone else getting these when building the newest master for Maguro?
> 
> E/Zygote  (  821): 	at libcore.util.ZoneInfoDB.mapData(ZoneInfoDB.java:109)
> E/Zygote  (  821): 	at libcore.util.ZoneInfoDB.<clinit>(ZoneInfoDB.java:75)
> E/Zygote  (  821): 	... 12 more
> E/Zygote  (  821): Caused by: libcore.io.ErrnoException: open failed:
> ENOENT (No such file or directory)
> 
> It was originally bawking about other files not being there, and I
> pushed them from another device, but the list keeps growing...
> 
> I looked at libcore and everything looks up to date...

I just merged latest AOSP master into seandroid, so you might try again
and see if it still occurs.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
