Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7MDIrnR016952
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 09:18:53 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7MDIpx9015996
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 13:18:51 GMT
In-Reply-To: <1187705925.1451.123.camel@moss-spartans.epoch.ncsc.mil>
References: <6FE441CD9F0C0C479F2D88F959B0158818654C@exchange.columbia.tresys.com> <1187380020.909.358.camel@moss-spartans.epoch.ncsc.mil> <D38FAD33-E7B4-4A2A-909E-892800350EFE@nall.com> <1187705925.1451.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FDD03592-C4AE-4066-B866-90B830235880@nall.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
From: Joe Nall <joe@nall.com>
Subject: Re: weird mprotect error
Date: Wed, 22 Aug 2007 08:18:29 -0500
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Aug 21, 2007, at 9:18 AM, Stephen Smalley wrote:

> On Mon, 2007-08-20 at 21:09 -0500, Joe Nall wrote:
>> Any recommendations on how to start an unprivileged non SystemLow
>> daemon? This seems broken.
>
> Maybe I don't understand the actual problem.

We couldn't make a non SystemLow, unprivileged daemon run in  
enforcing mode.

> Is it reproducible with an upstream (or Fedora) kernel?

Tried to reproduce it on F7 yesterday and ran into login issues.

> What's the exact test case?  Trying to run an /etc/init.d script that
> calls that mlstest program using run_init?

chcon system_u:object_r:mlstest_exec_t mlstest
run_init ./mlstest

The test case was derived from a more complicated daemon and init  
script.

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
