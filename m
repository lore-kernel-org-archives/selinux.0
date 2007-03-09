Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l29H74ps029585
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 12:07:04 -0500
Received: from web36602.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l29H73mf014111
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 17:07:04 GMT
Date: Fri, 9 Mar 2007 09:06:47 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: mmap_file_perms needs ioctl also
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1173444689.3241.82.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <760182.67627.qm@web36602.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

 
> ioctl permission is effectively useless as it
> doesn't distinguish
> read-flow vs. write-flow vs. control-op, so it ends
> up being allowed
> pervasively whenever you allow read or write.  We
> really need to just
> replace it (ala the attempts by Lorenzo in the
> past), but doing so
> compatibly won't be easy.

That is a significant understatement. Ioctl is
used, misused, and abused so many different ways
in so many places that doing a granular enforcement
may be beyond the current state of the art and is
certainly a maintenance burden that exceeds the
scope of the existing SELinux implementation.
An investigation into the networking drivers alone
ought to send the rational programmer running in
blind terror. Then there are the graphics
implementations.

I suggest that an approach that would add more
value to the kernel overall and make someone a
minor kernel diety would be to replace the ioctl
mechanism completely. I also think that it would
be less work than trying to do a proper job of
granualizing the existing smoldering pile of
technology.

We did look into the granular ioctl security
policy issue in Unix in the 20th centuty. If
you restrict your system to a very limited set
of devices it still stretches an evaluation
budget beyond the breaking point. It's very
hard to justify the value of the granularity
in terms of the cost.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
