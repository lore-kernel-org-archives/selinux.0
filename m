Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SMgHrT014826
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 18:42:17 -0400 (EDT)
Received: from smtp807.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6SMfkVb024612
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 22:41:46 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp807.mail.ukl.yahoo.com with SMTP; 28 Jul 2004 22:42:16 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BpwdU-0000sL-7Q
	for selinux@tycho.nsa.gov; Wed, 28 Jul 2004 22:10:56 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BpxIY-00051S-T4
	for selinux@tycho.nsa.gov; Wed, 28 Jul 2004 23:53:22 +0100
Date: Wed, 28 Jul 2004 23:53:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: pear-shaped behaviour after enough make reloads
Message-ID: <20040728225322.GE18711@lkcl.net>
References: <20040728211229.GB18711@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040728211229.GB18711@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 28, 2004 at 10:12:29PM +0100, Luke Kenneth Casson Leighton wrote:

> i thought i should report what might be quite a serious issue.
> 
> the procedure i use for development of policy files is to do
> _stacks_ of edits, _stacks_ of make reloads, stacks of
> audit2allow -d -v -l > /tmp/foo, analyse the results and put
> the appropriate ones into the new policy.
> 
> after enough make reloads, the behaviour of my system starts to get
> a bit wonky.

> after a reboot in such circumstances, i find that my system
> is pretty much unusable: i have to run a ldconfig to fix a
> problem of libraries being not found - things like that.

 this problem reoccurred just now.
 
 for absolutely no reason that i can think of, whilst staring
 at a random config file with vi, cupsys started to be unable
 to access its config files.

 then i tried to do a ldconfig and got selinux permissions denied
 access to write /etc/ld.so.cache~!

 i could not even do a shutdown - permission was banned to access
 /dev/initctl.

 i had to kill off processes manually one by one, umount the partitions
 manually, poweroff, and i chose to boot with enforcing=0 init 1 in
 order to safely run ldconfig and make relabel.

 i find this all a bit odd, i haven't a clue what's causing it.

 l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
