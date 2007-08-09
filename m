Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79GGRkm015810
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 12:16:27 -0400
Received: from web36612.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l79GGQk4023882
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 16:16:26 GMT
Date: Thu, 9 Aug 2007 09:16:26 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        kaigai@ak.jp.nec.com, joe@nall.com, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <1186673969.6916.542.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <109703.22057.qm@web36612.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:


> > If y'all are going to look at this, please consider that secid's are
> > SELinux specific and using them in system interfaces is an impediment
> > to the development of other schemes. One important reason that Smack is
> > using netlabel in favor of secmark is that secid interface.
> 
> The secid notion is the only reason we have a field in the sk_buff at
> all.  The original security blob in the sk_buff was rejected by David
> Miller when the LSM networking hooks were put forward by James; it comes
> back to lifecycle management and overhead.  The secmark (just another
> name for a secid) construct in contrast avoids the lifecycle management
> requirement and due to its small fixed size avoids significant bloat.
> There is considerable doubt that we could even get it expanded to being
> a u64, much less turned into a security blob.

This is the answer I expected. I did have to raise the question.
I will stick with netlabel/cipso, and "ambient" labels rather than
the suggested secid based default scheme, at least for the time being.
Thank you.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
