Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AKSvrT001059
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:28:57 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5AKSqP2025451
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:28:52 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 10 Jun 2004 20:28:55 -0000
Date: Thu, 10 Jun 2004 20:26:15 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ed Street <edstreet@street-tek.com>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Message-ID: <20040610202615.GC2861@lkcl.net>
References: <20040609233946.GI5727@lkcl.net> <20040610022221.7796D3A4063@abyss.simplyaquatics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040610022221.7796D3A4063@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 09, 2004 at 10:22:21PM -0400, Ed Street wrote:
> Well why ANY app needs write access to /etc is beyond me.  Also are you
> using run_init /etc/init.d/foo ?
 
 yes, i am, and that's part of the problem.

 if you do an ls --context /var/spool/postfix/etc and compare the files
 listed there to ls --context /etc for example (there are others)
 you will find that the contexts are identical.

 therefore, in order for the chroot jail files to be copyable 
 (and overwritable!) from /etc to /var/spool/postfix/etc,
 and from /lib to /var/spool/postfix/lib, it is necessary to
 give initrd_t (which is what run_init drops you into, yes)
 write permission to etc_t (amongst other things).

 if you do that, you get a policy violation (build error) on a
 "make policy" on one of the checks that bans you from doing
 things like give initrd_t access to writing in etc_t or
 etc_runtime_t.

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
