Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AKx9rT001371
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:59:09 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5AKx6aH024146
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:59:06 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 10 Jun 2004 20:59:06 -0000
Date: Thu, 10 Jun 2004 20:56:22 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ed Street <edstreet@street-tek.com>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Message-ID: <20040610205622.GF2861@lkcl.net>
References: <20040609214126.GF5727@lkcl.net> <20040610004455.15C043A4063@abyss.simplyaquatics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040610004455.15C043A4063@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 09, 2004 at 08:44:54PM -0400, Ed Street wrote:
> Hello,
> 
> I know under SID the stock postfix rules works 100% correctly with no
> augmentation.
 
 hi ed,

 okay, so you have a system which works out-the-box, and i don't.

 so we should compare notes to work out what the differences are.

 i have russell's 1.12 selinux policy files (slightly modified
 to get various other packages working, but not, i don't believe,
 in areas that impact on postfix / postfix installation).

 i have a kernel 2.6.6-selinux1 (which is at
 http://hands.com/~lkcl/selinux).

 i have postfix 2.1.1-3.

 i am installing it as a "local mailer only" - no networking.
 (is that important?)

 i also installed exim, and replaced it with exim4.
 then i replaced that with sendmail.
 40 seconds later i replaced that with postfix.
 then three days later i replaced that with exim4.
 then yesterday i replaced it with postfix.

 so i've done quite a lot of install and deinstalling.

 on the first install of postfix, if my memory serves me
 correctly, i did not know at that time about se_apt_get
 or se_dpkg.

 so i _may_ have installed it using apt-get, possibly even
 with "enforcing=0" and since then i have run make relabel
 countless times (which should, in theory, correct any
 policy file mislabelling that would have occurred by
 using apt-get rather than se_apt-get).

 on the second install, and this time i definitely used
 se_apt-get, se_apt-get postfix FAILED due to
 this inability of /etc/init.d/postfix to overwrite anything
 in etc_t or log_t context (examine /etc/init.d/postfix
 and you notice that "start" tries to do ln and cp into
 /var/spool/postfix/etc and .../lib).

 on both the first and second installs, i get this:

 Jun  9 23:24:03 sez kernel: audit(1086819843.982:0): avc:  denied  {
 sys_chroot } for  pid=1979 exe=/usr/lib/postfix/trivial-rewrite
 capability=18 scontext=system_u:system_r:postfix_master_t
 tcontext=system_u:system_r:postfix_master_t tclass=capability

 
 only by creating an /etc/default/postfix with the contents
 SYNC_CHROOT=""

 do i manage to get a working postfix 2.1.1-3.

 what do you have?

 l.


-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility for acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
