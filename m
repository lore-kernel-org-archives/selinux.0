Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2KH1E46027405
	for <selinux@tycho.nsa.gov>; Fri, 20 Mar 2009 13:01:14 -0400
Received: from yw-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2KGvNAN026209
	for <selinux@tycho.nsa.gov>; Fri, 20 Mar 2009 16:57:23 GMT
Received: by yw-out-1718.google.com with SMTP id 5so715715ywm.84
        for <selinux@tycho.nsa.gov>; Fri, 20 Mar 2009 10:01:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.0903200035410.1901@havk>
References: <alpine.LNX.2.00.0903200035410.1901@havk>
Date: Fri, 20 Mar 2009 11:01:13 -0600
Message-ID: <80d7e4090903201001i3312cfccn6bd7f47677d89b3a@mail.gmail.com>
Subject: Re: How safe are ncurses apps?
From: Stephen John Smoogen <smooge@gmail.com>
Cc: selinux@tycho.nsa.gov, refpolixy@oss.tresys.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Mar 20, 2009 at 1:38 AM, justinmattock@gmail.com
<justinmattock@gmail.com> wrote:
>
> Out of concern
> How secure is ncurses base apps?
> i.g. running alsamixer generates no avc's,
> as well as alpine.
>

Well it all depends on what they are doing, and what you mean by
secure, and how you want it contained.

Most ncurses vulnerabilities seem to be text overflows that allow for
the malware to run as the user that is exploited. Thus if there was an
ncurses vulnerability AND an email was sent with said vulnerability,
alpine could be used to over-write data as the context of the user.

The fact that there are no avc's does not indicate security of the
application if the application does not do anything that it wasn't
supposed to do. [Attempting to prove a negative?]


-- 
Stephen J Smoogen. -- BSD/GNU/Linux
How far that little candle throws his beams! So shines a good deed
in a naughty world. = Shakespeare. "The Merchant of Venice"

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
