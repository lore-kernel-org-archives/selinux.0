Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6KD3RrT019758
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 09:03:27 -0400 (EDT)
Received: from prometheus.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6KD30Uj020670
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 13:03:00 GMT
Received: from prometheus.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6KD3NcK000593
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 09:03:23 -0400
Received: (from jwcart2@localhost)
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i6KD3NMv000591
	for selinux@tycho.nsa.gov; Tue, 20 Jul 2004 09:03:23 -0400
Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6KCqLrT019662
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 08:52:21 -0400 (EDT)
Received: from snowstorm.hosts.ndo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6KCqJYW021258
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 12:52:20 GMT
Date: Tue, 20 Jul 2004 14:00:40 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Troubles with etc/passwd being relabeled to shadow_t upon useradd/usermod
Message-ID: <20040720130040.GD3858@lkcl.net>
References: <20040720093704.GD21906@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040720093704.GD21906@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

eric, hi,

i got round the problem by installing the modified versions of
passwd, which you can get from selinux.lemuria.org/walters, 
see http://selinux.lemuria.org/

now, i understand that there's a better solution, but i am a bit
confused as to what it is.

also, because i installed the latest version of some package
[cups i think it was, bizarrely enough] it depends upon the
_very_ latest passwd something .0 .85 or so.

so what i had to do was to download the patches to the passwd
package (available both off the www.nsa.gov web site and also
off of the site referenced above, apply them to the latest source,
run dpkg-buildpackage and then install those.

in order to make my system useable, i had to install the pam
package there, and coreutils, and logrotate, and login, and
cron, and passwd.

DO NOT install the libselinux1, checkpolicy, policycoreutils,
selinux-policy packages off of selinux.lemuria.org/walters,
they are for Woody, they are out-of-date, they are unlikely
to be maintained (iirc) but i _would_ if i were you have a crack
at installing everything else (cu, sh, prps, fu, pam, mount, psm,
shu, txtu, bsdu, coreu).

SOME of these packages are not necessary: they have been superceded
by using pam_selinux.so instead (so you _will_ at least need to
install the pam packages off of .../walters).

it's all slightly pear-shaped and trial-and-error.


WARNING: OTHER PEOPLE MAY ADVISE YOU TO DO DIFFERENTLY in order
to get a working debian se/linux system: i have the advantage
of quite a bit of time and a 100% focus for approximately
four weeks in order to understand the issues to a vague enough
point to "Get Something Working (tm)".


by the way, if you have _any_ influence with the various debian
maintainer about, _please_ make some waves because this situation
is just getting stupid.

NOT ONE of the CRITICALLY REQUIRED patches to debian packages
has yet made it into the ftp site.  a temporary measure has been
proposed whilst sarge is in freeze to produce packages named
se-XXXX which are optional until libselinux1 can be made
"Required" status rather than optional.

the only person who has agreed to produce a [temporary] se-XXXX
package is steve greene, who maintains cron.

the dpkg debian maintainer is alternating between responses varying
along the lines of "that's a stupid idea as already discussed before
hundreds of times before and it is beneath me to refute it in detail"
and not responding at all to quite simple and polite requests to
engage in discussing alternatives.

l.

On Tue, Jul 20, 2004 at 11:37:04AM +0200, Erich Schubert wrote:
> Hello,
> i'm using SELinux from Russels Debian packages.
> Whenever i (or an dpkg postinst script) modifies the etc/passwd,
> or etc/group files they are transferred to the
>   "root:object_r:shadow_t" type, thus being unable to be read
> even by root.
> What is causing this, and how can i prevent this?
> (doing a "make relabel" is the only way i found to solve this)
> 
> Greetings,
> Erich Schubert
> -- 
>     erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C    (o_
>    There was never a good war or a bad peace. - Benjamin Franklin   //\
>                F?r jedes Problem gibt es eine L?sung,               V_/_
>                   die einfach, klar und falsch ist.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
