Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7I3RlHa009925
	for <selinux@tycho.nsa.gov>; Sun, 17 Aug 2003 23:27:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7I3Rlj6001136
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 03:27:47 GMT
Received: from zaphod.crypt.gen.nz (203-79-124-69.adsl.paradise.net.nz [203.79.124.69])
        by jazzband.ncsc.mil  with ESMTP id h7I3RjNN001133 for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 03:27:46 GMT
Message-ID: <3357.202.27.185.71.1061177252.squirrel@www.crypt.gen.nz>
In-Reply-To: <3F3896BD.5000307@diyab.net>
References: <3F3896BD.5000307@diyab.net>
Date: Mon, 18 Aug 2003 15:27:32 +1200 (NZST)
Subject: Re: SELinux on Slackware 9 with PAM
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: "SELinux Mail List" <selinux@tycho.nsa.gov>
Cc: "Diyab" <diyab@diyab.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just got around to reading this, after carrying it around with me for
almost a week now.

Its very useful document for anyone deploying SELinux on Slackware. The
document pretty much follows the README and describes what changes need to
be made for Slackware.

A few comments:

- you should mention that the Vixie crond in the SE release has been
modified for SELinux and really needs to be installed if you want cron.
Alternatively the user would need to modify Dillon's crond code to support
the SELinux extensions.

- you don't seem to configure the kernel ( make menuconfig, or edit
.config ) before compiling it - which may cause problems if the user has
devices not in the standard config.

- be careful about specifying line numbers when describing changes to
files - the line numbers will probably change in new releases of
Slack/SELinux.

- I recommend converting the document to HTML, even if you just wrap <Hx>
tages around the headers. Search engines give preference to keywords in
HTML files and headers.

All in all a very useful document. Anyone installing on Slackware will
save themselves a lot of time by referring to this.

Kerry

-- 
Kerry Thompson, CCNA CISSP
Information Systems Security Consultant
http://www.crypt.gen.nz  kerry@crypt.gen.nz

Diyab said:
> Hello all,
>
>       I just finished writing up a howto style document that explains
> how to install SELinux on Slackware 9 along with the installation of
> PAM.  Thus far you will be able to boot into enforcing mode with some
> minimal services like ssh but I have not tested much else.  So mainly
> all I have to do now is to try running some services and alter the
> policy as needed.  I would appreciate some feedback if anyone has time
> to look at it, suggestions always welcome.  Also I would be more than
> happy to add policy changes that anyone else who might be using
> slackware has made.
>
> The document is available in plain text format here:
> http://www.diyab.net/selinux/SELinux_on_Slackware9.txt
>
> A PDF version is soon to follow.  Check my selinux page in a couple of
> days for the PDF version.
> http://www.diyab.net/selinux/index.html
>
> Timothy,
>
> --
> I put instant coffee in a microwave and almost went back in time.
> 		-- Steven Wright



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
