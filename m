Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1MC41dW022042
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 07:04:01 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1MBxOMK009530
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 11:59:24 GMT
Date: Tue, 22 Feb 2005 12:11:28 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: jayendren@mweb.co.za
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: fc3 - password change problem - syslog and portmapper
Message-ID: <20050222121127.GH14038@lkcl.net>
References: <200502220809.40631.jayendren@hivsa.com> <200502221149.59288.jayendren@hivsa.com> <20050222102113.GE14038@lkcl.net> <200502221244.44315.jayendren@hivsa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200502221244.44315.jayendren@hivsa.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 22, 2005 at 12:44:44PM +0200, Jayendren Anand Maduray wrote:
> On Tuesday 22 February 2005 12:21, you wrote:
> ic, well i did not compile it, and it does not work with the previous kernel - 
> 2.6.9

 are you saying that out-of-the-box, you installed FC3, selected
 on the anaconda install program the option to enable selinux,
 and that you selected to "enable" rather than "warn" i think
 that's the option...

 ... and having done that, it _didn't_ work?

 because if so, that is very very odd, and you should resolve to
 fix _that_ rather than going to other lengths such as installing
 a 2.6.10 kernel or installing policy from source.


> do u suggest that i remove it, and compile it from scratch?

 no, i'm suggesting that you resolve the initial problem with
 your install (by reinstalling if necessary - do you have vmware
 or a spare machine?)

 and if necessary, raising a bug on redhat's bug tracking site.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
