Subject: Re: memory_device_t
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1208456672.18883.420.camel@moss-spartans.epoch.ncsc.mil>
References: <dd18b0c30804171048n5bb2968dy355aa500452422a4@mail.gmail.com>
	 <1208456672.18883.420.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 17 Apr 2008 14:25:30 -0400
Message-Id: <1208456730.18883.422.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-04-17 at 14:24 -0400, Stephen Smalley wrote:
> On Thu, 2008-04-17 at 17:48 +0000, Justin Mattock wrote:
> > Hello; I have a quick question. When using a macbook pro there is a
> > tool(radeontool)  that I use to lower the gpu power to a low state
> > causing significant cooling of the system hardware. The problem I run
> > into is I'm receiving a: libsepol.check_assertion_helper: assertion on
> > line 9293 violated by allow sysadm_t memory_device_t:chr_file { read
> > write };
> > Whenever trying to write the allow rule into the policy. What would be
> > the best step to allow this tool?
> 
> Well, assuming that it actually requires that access, you can override
> the assertion / neverallow rule by using the proper policy interface
> instead of a direct allow rule.  audit2allow -R will try to match and
> use interface calls for you, or you can look them up and use the right
> one manually.  dev_read_raw_memory() and dev_write_raw_memory() appear
> to be the ones in question.

Oh, but I see that you showed the denial as being on sysadm_t.  You
should really define a separate domain for the tool and only allow it
for that domain rather than directly allowing it to sysadm_t.

> 
> Or you can disable assertion checking by putting expand-check=0
> in /etc/selinux/semanage.conf.
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
