Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m39Kbkox012122
	for <selinux@tycho.nsa.gov>; Wed, 9 Apr 2008 16:37:46 -0400
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m39Kbj2t013244
	for <selinux@tycho.nsa.gov>; Wed, 9 Apr 2008 20:37:46 GMT
Received: by fg-out-1718.google.com with SMTP id 16so2245731fgg.40
        for <selinux@tycho.nsa.gov>; Wed, 09 Apr 2008 13:37:37 -0700 (PDT)
Message-ID: <cadfc0e40804091330t6ff1aadbned7d5fbc1479fdf5@mail.gmail.com>
Date: Wed, 9 Apr 2008 15:30:58 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: avc_* functions not in libselinux-python
Cc: "SE Linux" <selinux@tycho.nsa.gov>, "Eamon Walsh" <ewalsh@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>
In-Reply-To: <1207762256.21223.489.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40804081502j335cbc4au8d32d4d5fd956c8c@mail.gmail.com>
	 <1207762256.21223.489.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For now I don't think that's a problem as I was looking at using
avc_has_perm and the context to sid conversion function.

On Wed, Apr 9, 2008 at 12:30 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>  On Tue, 2008-04-08 at 17:02 -0500, Xavier Toth wrote:
>  > Can these functions get swig'd and their wrappers built into _selinux.so?
>
>  Patches accepted.
>
>  One possible issue here is function pointer callbacks, which is a more
>  general problem than just the avc interfaces in libselinux.  But if you
>  are ok with the default callbacks, I suppose there is no problem there.
>
>  --
>  Stephen Smalley
>  National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
