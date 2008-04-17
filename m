Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3HK5MEh024801
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 16:05:22 -0400
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3HK5Mc3005577
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 20:05:22 GMT
Received: by an-out-0708.google.com with SMTP id c38so53801ana.75
        for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 13:05:00 -0700 (PDT)
Message-ID: <dd18b0c30804171200n7350bd75n127c9e8ebb230996@mail.gmail.com>
Date: Thu, 17 Apr 2008 19:00:18 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: memory_device_t
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30804171148j7668a73fr6c514f5511966d5d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30804171048n5bb2968dy355aa500452422a4@mail.gmail.com>
	 <1208456672.18883.420.camel@moss-spartans.epoch.ncsc.mil>
	 <1208456730.18883.422.camel@moss-spartans.epoch.ncsc.mil>
	 <dd18b0c30804171148j7668a73fr6c514f5511966d5d@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 17, 2008 at 6:48 PM, Justin Mattock <justinmattock@gmail.com> wrote:
> On Thu, Apr 17, 2008 at 6:25 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>  >
>  >  On Thu, 2008-04-17 at 14:24 -0400, Stephen Smalley wrote:
>  >  > On Thu, 2008-04-17 at 17:48 +0000, Justin Mattock wrote:
>  >  > > Hello; I have a quick question. When using a macbook pro there is a
>  >  > > tool(radeontool)  that I use to lower the gpu power to a low state
>  >  > > causing significant cooling of the system hardware. The problem I run
>  >  > > into is I'm receiving a: libsepol.check_assertion_helper: assertion on
>  >  > > line 9293 violated by allow sysadm_t memory_device_t:chr_file { read
>  >  > > write };
>  >  > > Whenever trying to write the allow rule into the policy. What would be
>  >  > > the best step to allow this tool?
>  >  >
>  >  > Well, assuming that it actually requires that access, you can override
>  >  > the assertion / neverallow rule by using the proper policy interface
>  >  > instead of a direct allow rule.  audit2allow -R will try to match and
>  >  > use interface calls for you, or you can look them up and use the right
>  >  > one manually.  dev_read_raw_memory() and dev_write_raw_memory() appear
>  >  > to be the ones in question.
>
>      With refpolicy where would I put that info from audit2allow -R?
>
> >
>  >  Oh, but I see that you showed the denial as being on sysadm_t.  You
>  >  should really define a separate domain for the tool and only allow it
>  >  for that domain rather than directly allowing it to sysadm_t.
>
>   First I'll try another domain, then look into the other options,
>
>
>
>
>  >
>  >
>  >  >
>  >  > Or you can disable assertion checking by putting expand-check=0
>  >  > in /etc/selinux/semanage.conf.
>  >  >
>  >  --
>  >  Stephen Smalley
>  >  National Security Agency
>  >
>  >
>
>  Thanks for the help, also a few weeks ago giving me the info on echo 0
>  > /proc/sys/kernel/printk_ratelimit
>  made writting the rules more enjoyable, rather than spending hours.
>
>  --
>  Justin P. Mattock
>



O.K. doing what you said worked by putting that tool in a different
domain, having this tool used early in the boot process i.g. putting
the tool in /usr/sbin, then adding a line to rc.local is working, not
producing any denials, but it is working.
Does this seem correct to you?

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
