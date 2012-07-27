Message-ID: <1343400350.17570.56.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Questions about the MLS to "read down"
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 27 Jul 2012 10:45:50 -0400
In-Reply-To: <CAO-4OdHA5cawkDUOqHWMKP9tSqtEKosGincjcycENUr47Qjt3A@mail.gmail.com>
References: 
	<CAO-4OdHA5cawkDUOqHWMKP9tSqtEKosGincjcycENUr47Qjt3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-26 at 15:49 -0700, Haiqing Jiang wrote:
> Hi, all
> 
> 
> I have the following denials. But from my understanding, the
> reading-down rule is not violated according to the scontext and
> tcontext. Could you help to explain why? Thanks. 
> 
> 
> <5>[15423.456451] type=1400 audit(1342836229.562:2241): avc:  denied
> { read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc
> ino=127269 scontext=u:r:release_app:s0:c42
> tcontext=u:r:shared_app:s0:c16 tclass=lnk_file

As Joe explained, these levels are incomparable and thus violate the MLS
restriction.  BTW, I notice that these denials are on /proc/pid files
rather than app data files, whereas earlier you said you are
encountering problems with app data files.    And this should be denied
by DAC.

adb shell
ps
<pick an app pid>
cat /proc/<pid>/cwd
/system/bin/sh: cat: /proc/1223/cwd: Permission denied

This can just be dontaudit'd.  Looks like we already do that for :dir
and :file in cts.te; just need to add lnk_file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
