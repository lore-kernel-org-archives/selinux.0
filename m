Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1AIxIXf013742
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 13:59:18 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1AIvwsR022222
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 18:57:58 GMT
Subject: Re: seref: trivial patch:
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060210155933.GA26183@sergelap.austin.ibm.com>
References: <20060209194236.GF10534@sergelap.austin.ibm.com>
	 <1139582505.13925.84.camel@sgc.columbia.tresys.com>
	 <20060210155933.GA26183@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 10 Feb 2006 14:00:39 -0500
Message-Id: <1139598040.13925.98.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-02-10 at 09:59 -0600, Serge E. Hallyn wrote:
> A question that's not clear in my mind - if a module, like certwatch.te,
> uses the apache_exec_modules() interface, should that call automatically be
> defined away to nothing if apache is not defined, or does that call
> still need to be inside of a 'optional_policy(`apache'' block?  The
> former sounds like preferred behavior to keep policies clean, but that'
> not what is happening right now, judging by the otput under tmp/.

No, we want those rules in an optional_policy().  Its implementation is
an ifdef for monolithic policy/base module, and an optional{} block for
loadable modules.  Optional{} blocks are compiled in and are resolved at
link time; then you don't have to recompile the module to change the
optional policy blocks.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
