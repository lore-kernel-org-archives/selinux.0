Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0AHtkV1028905
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2007 12:55:46 -0500
Received: from web36613.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0AHuZoR017581
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2007 17:56:35 GMT
Date: Wed, 10 Jan 2007 09:56:16 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Tar storage of SELinux context, translated or not
To: James Antill <jantill@redhat.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1168448023.13080.33.camel@code.and.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <98714.13375.qm@web36613.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- James Antill <jantill@redhat.com> wrote:


>  I had originally decided that the SELinux security
> context should be
> stored in translated form, Ie. getfilecon => tar =>
> setfilecon, my
> thinking was that if you want to store something
> over a long period this
> is the better format ... but as I think more about
> it now I'm not 100%
> convinced (for instance, AIUI ipsec etc. uses raw
> format to distribute
> context between machines).
>  With the current changes, this is a great time to
> change it (but I
> really, really, don't want to have an option either
> way) ... if we want
> to. So should I change it to non-translated?

Since it is possible that the two make get out
of sync as policy development progresses it
might make the most sense to keep both and
provide for the user to select one of:
   - use the raw, ignore the translated
   - use the translated, ignore the raw
   - use the either, but only if the current
     system would translate the stored raw
     into the stored translated

The MLS systems that I worked on always saved
the "human readable" labels. The 1990's POSIX
group always assumed that export/import
utilities would use human friendly values.
Personally, I think you should stick with the
translated values, as they are most likely
to remain meaningfull over time.
 

Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
