Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8SMpIrT011736
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 18:51:18 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8SMpGPw021335
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 22:51:17 GMT
Date: Wed, 29 Sep 2004 00:02:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Problems with fixfiles and setfiles.
Message-ID: <20040928230226.GB6287@lkcl.net>
References: <4159C55D.4050404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4159C55D.4050404@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 28, 2004 at 04:11:09PM -0400, Daniel J Walsh wrote:
> The fixfiles script is used to report and fix file contexts that are 
> invalid, the problem is that it gets a lot of
> false positives.  Reviewing fixfiles.cron shows that most of the files 
> created by mozilla are reported as invalid.
> It would be nice if we could remove these false positives by some means.
> 
> If we had some mechanism of saying a file could have one of several 
> valid contexts, or be in a context that
> has a certain attribute.
> 
> Ideas?
 
 this was... touched upon in a discussion two-ish weeks ago: the
 concept was that of having more than one context for a file,
 with a convenient (but from what i can gather unnecessary)
 123... 4'th parameter on the file_contexts entries.

 the mechanism would, as i understand it, define "additional" contexts
 with the first one being the "default".

 under such circumstances, mozilla could in fact save a file under a
 specific file context according to what was defined _in_ file_contexts
 (with a different 4th parameter being used as the lookup for the
 alternative context)
 
 ... such that then, yes, fixfiles could then go "oh, it's an
 alternative context for the same file".

 l.
 
-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
