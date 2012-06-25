From: <ken.masumitsu@accenture.com>
To: <sds@tycho.nsa.gov>
CC: <SELinux@tycho.nsa.gov>
Subject: Re: Denials of changing wallpaper on Galaxy Nexus
Date: Mon, 25 Jun 2012 02:50:25 +0000
Message-ID: <ECD1E95F29248A4AA3FFC99C6947D66C0A4917F5@048-CH1MPN1-082.048d.mgd.msft.net>
References: <4FE43B1B.1030602@accenture.com>
  <1340368300.14703.35.camel@moss-pluto.epoch.ncsc.mil>
 <1340370788.14703.38.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1340370788.14703.38.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Thanks for your comments.
I could change wallpaper by modifying file.te you suggested.

However, I have one question.
How do you find/investigate the deny comes from MSL?

Because, though I interpreted the log as
     The object (wallpaper file) had no category and sensitivity of the
object and the subject were same.
     The access was allowed by MLS.
the guess was incorrect.

---------------------------------------------------------------------------------------

<5>[ 508.922760] type=1400 audit(1340350990.015:190): avc: denied {
write } for pid=565 comm=42696E646572205468726561642023
path="/data/data/com.android.settings/files/wallpaper" dev=mmcblk0p12
ino=578429 scontext=u:r:trusted_app:s0:c17
tcontext=u:object_r:wallpaper_file:s0 tclass=file
  ---------------------------------------------------------------------------------------

best regards,
--
Ken Masumitsu

________________________________
Subject to local law, communications with Accenture and its affiliates including telephone calls and emails (including content), may be monitored by our systems for the purposes of security and the assessment of internal compliance with Accenture policy.
______________________________________________________________________________________

www.accenture.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
