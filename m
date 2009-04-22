MIME-Version: 1.0
In-Reply-To: <49EE529A.3030908@tycho.nsa.gov>
References: <faa16b610904141142v1d1e92ddxd78d5e1a0fbb0be7@mail.gmail.com>
	 <49E5CFD8.6060903@redhat.com>
	 <1239800627.27560.34.camel@localhost.localdomain>
	 <49E7D1BF.2010405@tycho.nsa.gov>
	 <1239973084.15304.17.camel@localhost.localdomain>
	 <49EE2D59.3080403@manicmethod.com>
	 <1240346499.1678.33.camel@localhost.localdomain>
	 <49EE529A.3030908@tycho.nsa.gov>
Date: Wed, 22 Apr 2009 11:19:02 -0400
Message-ID: <faa16b610904220819m111f79adx8fbd3d39e2ffff91@mail.gmail.com>
Subject: Re: libselinux behavior in permissive mode wrt invalid domains
From: Colin Walters <walters@verbum.org>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Apr 21, 2009 at 7:11 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
>
> FWIW, the following patch to D-Bus should help:
>
>
> bfo21072 - Log SELinux denials better by checking errno for the cause
>
>    Note that this does not fully address the bug report since
>    EINVAL can still be returned in permissive mode.  However the log
>    messages will now reflect the proper cause of the denial.

Applied, thank you!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
