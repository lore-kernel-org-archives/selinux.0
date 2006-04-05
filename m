Subject: Re: rsync resetting contexts in /var/www
From: Erich Schubert <erich@debian.org>
To: "J. Simonetti" <jsimonetti@denit.net>,
        "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
In-Reply-To: <1144259773.25790.102.camel@moss-spartans.epoch.ncsc.mil>
References: <1144234218.7521.70.camel@jeroen.office.denit.net>
	 <1144259773.25790.102.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 05 Apr 2006 23:36:57 +0200
Message-Id: <1144273018.19128.68.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> issue or not.  In the absence of -X, rsync should just be creating the
> new files with the default behavior, i.e. they should just inherit from
> the parent directory.

rsync writes data to temp files first, then renames them to their final
name IIRC. So even if you replace files with files from a remote machine
they'll probably get the default contexts again, just by not replacing
the existing ones, but actually being "moved in place" of the old files.
That is a sane behaviour, since network connections might be unstable
and you'll have intact files all the time that way. You could maybe
patch rsync to restore the old files label onto the new file, but I'm
not sure if that is the right way to do it.
I'm not a selinux "behaviour" expert, so what I just wrote might be
incorrect.

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
                Friends are those who reach out for                 //\
                  your hand but touch your heart.                   V_/_
      Alles verändert sich, sobald man sich selber verändert.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
