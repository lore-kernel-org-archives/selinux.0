Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8BCGUSY003280
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 08:16:30 -0400
Received: from QMTA13.westchester.pa.mail.comcast.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8BCHoPj002830
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 12:17:50 GMT
Subject: Re: how to use require and gen_require properly
From: Chris PeBenito <pebenito@gentoo.org>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1252663263.2491.38.camel@vogon.seekline.net>
References: <1252663263.2491.38.camel@vogon.seekline.net>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 08:16:28 -0400
Message-Id: <1252671388.2937.4.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-09-11 at 12:01 +0200, Stefan Schulze Frielinghaus wrote:
> I'm writing a new policy for a special purpose and don't expect to
> submit it for refpolicy because it is just too domain specific and not
> useful for public domain. Therefore I cannot write a new interface which
> could be included in the default policy.
> 
> Here is my actual problem. I want to use filetrans because my daemon
> creates /dev/twa0 automatically. Therefore I have to write something
> like this:
> 
> filetrans_pattern(my_daemon_t, device_t, fixed_disk_device_t, chr_file)
> 
> Should I include the following require statement at the top of my te
> file:
> 
> require {
> 	type device_t, fixed_disk_device_t;
> }
> 
> or should I use this one:
> 
> gen_require(`
> 	type _device_t, fixed_disk_device_t;
> ')

Either one is fine.

> What is the actual difference between require and gen_require? Is it
> allowed to write such statements at the top of the policy or in general
> is this good practice or not? What was the actual intention of having
> two require statements? I guess the gen_require was especially for
> interfaces. But which one should be used if no interface is used?

gen_require() is just a require{} block.  The only difference is that it
disappears in the global scope of the base module or the global scope of
the monolithic policy since require{} blocks are not allowed in those
places.  If you are using a loadable module, using either require{} or
gen_require() is fine.

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
