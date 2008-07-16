Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GEkrlc015422
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 10:46:53 -0400
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GEkqXE022672
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 14:46:53 GMT
Received: by fg-out-1718.google.com with SMTP id 16so2465454fgg.40
        for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 07:46:52 -0700 (PDT)
Message-ID: <cadfc0e40807160746v24647414r8035d9930924dcb@mail.gmail.com>
Date: Wed, 16 Jul 2008 09:46:51 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: /etc/selinux/mls/contexts files labeled default_context_t
Cc: "SELinux List" <selinux@tycho.nsa.gov>
In-Reply-To: <1216205274.17602.31.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40807151402k565fbdf6iea18f911f1e0cc00@mail.gmail.com>
	 <1216205274.17602.31.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 16, 2008 at 5:47 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Tue, 2008-07-15 at 16:02 -0500, Xavier Toth wrote:
>> Most of these files are labeled default_context_t which I thought was
>> a no-no, why is this?
>
> No, that's the right type for those files.  You might be thinking of
> default_t.
>
> --
> Stephen Smalley
> National Security Agency
>
>

Indeed, thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
