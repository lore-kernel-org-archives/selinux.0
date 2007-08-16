Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7G86bYD005694
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 04:06:37 -0400
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7G86Oqd021106
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 08:06:25 GMT
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 16 Aug 2007 10:05:23 +0200
From: selinux770@tortenboxer.de
In-Reply-To: <1187202831.20485.66.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <20070816080523.135750@gmx.net>
MIME-Version: 1.0
References: <20070810101003.128080@gmx.net>	
 <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>	
 <20070810121259.128050@gmx.net>	
 <1186748504.7233.34.camel@moss-spartans.epoch.ncsc.mil>	
 <20070810130703.128070@gmx.net>	
 <1186751971.7233.70.camel@moss-spartans.epoch.ncsc.mil>	
 <20070810141236.128070@gmx.net>  <20070811180730.308640@gmx.net>	
 <1187009718.26008.19.camel@moss-spartans.epoch.ncsc.mil>	
 <20070815154407.250820@gmx.net>
 <1187202831.20485.66.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: wrong magic number (using old sources)
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I suspect that what we are doing isn't safe/portable.
> 
> The corresponding kernel code was converted a while back to avoid
> unaligned access problems, so possibly a similar transformation should
> happen here.
> 
> See:
> http://marc.info/?l=selinux&m=110252376515271&w=2
> 
> As a simple test of whether this is related, you might try the following
> patch for libsepol (and then rebuild checkpolicy against the updated
> libsepol) and see if it gets you past the magic number check.  If so,
> then the next step would be to apply the same change to the entire
> policydb_read code.

That's it. After applying the changes in source code i get past the magic number check. Now, my policyversion number is wrong but i would suggest, that this error is related to the problem you described. I included also a printf for buf2[] to check the values after conversion:
# make
( cd domains/program/ ; for n in *.te ; do echo "define(\`$n')"; done ) > tmp/program_used_flags.te.tmp
( cd domains/misc/ ; for n in *.te ; do echo "define(\`$n')"; done ) >> tmp/program_used_flags.te.tmp
mv tmp/program_used_flags.te.tmp tmp/program_used_flags.te
Building policy.conf ...
[...] > policy.conf.tmp
Building file contexts files...
/usr/bin/checkpolicy  -o policy.20 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 21) to policy.20
Validating file contexts files ...
/usr/sbin/setfiles -q -c policy.20 file_contexts/file_contexts
 buf2[0]: f97cff8c
 buf2[1]: 8
 buf2[2]: bea60574
 buf2[3]: bea60560
 buf2[4]: 4004a304
 buf2[5]: 400469a4
 buf2[6]: 0
 buf2[7]: 400a26f0
libsepol.policydb_read: policydb version 352321536 does not match my version range 15-21
libsepol.sepol_set_policydb_from_file: can't read binary policy: Success
Error reading policy policy.20: Success
make: *** [policy.20] Error 1

I think it is only necessary to declare unint32_t buf2[] of size 2 and not 8, isn't it?
-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
