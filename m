Message-ID: <4F564B76.8080609@tresys.com>
Date: Tue, 6 Mar 2012 12:37:58 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kovacsics_R=F3bert?= <kovirobi@gmail.com>
CC: <SELinux@tycho.nsa.gov>
Subject: Re: SETools not compiling, refpolicy modules not loading
References: <CABPkNKmytMBPwsY_HV5YLbaBzTThGY1KaRFkD0ujt7h1ReA6yA@mail.gmail.com>
In-Reply-To: <CABPkNKmytMBPwsY_HV5YLbaBzTThGY1KaRFkD0ujt7h1ReA6yA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/02/12 18:00, Kovacsics Róbert wrote:
> It is me again, and after compiling SELinux, I went on to try to
> compile SETools, as I read, stuff like audit2allow needs it because of
> the python, so anyway it does not want to compile, saying that
> "checking for corrected libsepol boolean expand behavior... configure:
> error: this version of libsepol is incompatible with SETools", and I
> have the latest SELinux, downloaded from the website. I did also try
> with the latest SETools downloaded from SVN.

I committed a fix that handles the new parameter in libsepol's role_set_expand() function, which may have a side effect of fixing your problem compiling SETools.  Can you update your checkout and retry?

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
