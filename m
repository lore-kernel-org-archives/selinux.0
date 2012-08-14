Message-ID: <1344954269.5588.47.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SEAndroid policy question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 14 Aug 2012 10:24:29 -0400
In-Reply-To: <CAFftDdqFwJFDjTaBnZ8wfORaVehmSdQw9X2K-Y+baVwgbvnH4w@mail.gmail.com>
References: 
	<CAFftDdqFwJFDjTaBnZ8wfORaVehmSdQw9X2K-Y+baVwgbvnH4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-08-13 at 15:42 -0700, William Roberts wrote:
> I am still trying to fully understand sensitivity vs category with mls
> constrains. I noticed that files are not labeled with a category, just
> a sensitivity in all the example I looked at (s0). Are categories more
> for "data in motion"?
> 
> ie 2 processes want to share data, they both have allow rules to
> access their own files. App1 has a c0 and app2 is c0,c1 then based on
> mls constraints data con be controlled between them?
> 
> Could you label files with categories too? or does that not make sense?

Files can be labeled with categories, and files should be labeled by
default with the same MLS label as the creating process.

If you install a third party app, you should see MLS categories on both
the app process label (in ps -Z) and on the /data/data directory for
that app (in ls -Z /data/data).

We disabled per-app category labeling for the system apps based on the
CTS testing by hqjiang, as they seem to need to be able to directly
share files.  So you won't see categories on their processes or files,
only on the third party apps at the moment.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
