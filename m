Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l43D6LnF019452
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 09:06:21 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l43D6LQe027692
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 13:06:21 GMT
Subject: Re: rename_dir_perms missing
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Dave Quigley <dquigley+selinux@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <f888952b0705021249o40ef05cn1ac2524d9582e3c9@mail.gmail.com>
References: <f888952b0705021249o40ef05cn1ac2524d9582e3c9@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 09:05:57 -0400
Message-Id: <1178197557.445.50.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-02 at 15:49 -0400, Dave Quigley wrote:
> Hello,
>     I was looking through the reference policy and I noticed that
> there is a problem with rename_dirs_pattern. It uses a define called
> rename_dir_perms that does not exist anywhere. The interface is $1 is
> the type that wants permissions $2 is the container type and $3 is the
> directory type. rename_dir_perms is used on the $3 target and is
> missing completely. The reason this didn't show up is that
> rename_dirs_pattern is never actually used anywhere. Which permissions
> are needed for this to work?

My guess would be { getattr rename }.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
