Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0CErUXf009833
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 09:53:30 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0CEqN5L002824
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 14:52:24 GMT
Subject: Re: [PATCH] sereference: enable local login
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060111220713.GA30908@sergelap.austin.ibm.com>
References: <20060111213646.GA30428@sergelap.austin.ibm.com>
	 <20060111220713.GA30908@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 09:54:22 -0500
Message-Id: <1137077663.29815.187.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-11 at 16:07 -0600, Serge E. Hallyn wrote:
> Quoting Serge E. Hallyn (serue@us.ibm.com):
> > Following is a patch which allows me to log in locally on a gentoo
> > system with the reference policy.
> 
> Well ok, I lied, I do seem to also have to play games with a
> custom homedir_template, but I assume that's something that
> will be eventually fixed independent of me?   :)

If you're referring to genhomedircon not being able to determine the
ROLE, then yes it will be fixed.  Otherwise, you'll have to be more
specific.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
