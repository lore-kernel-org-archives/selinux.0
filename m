Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5GFvFgA001690
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 11:57:15 -0400 (EDT)
Received: from www346.sakura.ne.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5GFmWZm027883
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 15:48:35 GMT
Message-ID: <42B19EE1.80808@kaigai.gr.jp>
Date: Fri, 17 Jun 2005 00:46:41 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ANN: SELinux Reference Policy Release
References: <1118871745.18294.28.camel@sgc.columbia.tresys.com>	 <42B18324.6020502@kaigai.gr.jp> <1118935044.18294.75.camel@sgc.columbia.tresys.com>
In-Reply-To: <1118935044.18294.75.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, Christopher.

> I don't understand the reason for your suggestion.  The XML is mainly
> for documentation purposes.

Hmm, I guessed there are deeply intention on using XML, not only documentation.

> We haven't done much thought about internationalization yet, since its a
> challenge to get high quality documentation in English in the first
> place.  The attribute would probably be better as lang="xx", e.g.,
> lang="jp", so its standardized.  Then in the future tools can easily get
> the right language.

Indeed, internationalized documentation may be early in the day.
But, don't forget to treat other than ASCII characters on this XML engine please.

Thanks, I have hopes in this new policy and approach.
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
