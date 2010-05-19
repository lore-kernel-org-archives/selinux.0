Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4JFXt8I023181
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2010 11:34:01 -0400
Received: from mail-px0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4JFXFWI026036
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2010 15:33:21 GMT
Received: by pxi15 with SMTP id 15so4008330pxi.12
        for <selinux@tycho.nsa.gov>; Wed, 19 May 2010 08:33:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinfrhS8r4gnc92Pmt78dQ080wlJEdH8qZjM0ZjK@mail.gmail.com>
References: <AANLkTinfrhS8r4gnc92Pmt78dQ080wlJEdH8qZjM0ZjK@mail.gmail.com>
Date: Wed, 19 May 2010 20:33:52 +0500
Message-ID: <AANLkTimOdxgxn1jBFfWABOvTQbOK9ZT6sMsjFCdZQp2L@mail.gmail.com>
Subject: Re: Howto enable or disable clipboard with selinux?
From: Shaz <shazalive@gmail.com>
To: selinux <selinux@tycho.nsa.gov>, refpolicy@oss1.tresys.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, May 15, 2010 at 10:50 PM, Shaz <shazalive@gmail.com> wrote:
> Dear list,
>
> I want to enable or disable the clipboard with booleans. Is there any
> available policy that can do this? If not please indicate the relevant place
> to start with.

There was a flaw in this question that someone on selinux irc
explained to me. We need to control an application's access to
booleans. But I am still not sure how much and what effort it
requires? Pointer to tutorials or some guidance will be appreciated.

Which version of XACE can do this going as back and earlier as possible?


-- 
Shaz

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
