Message-ID: <1340802693.32737.14.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Patch for mmac denials
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 27 Jun 2012 09:11:33 -0400
In-Reply-To: <CAFftDdqzEUq8Om_KdeCUF1+LW_+2d5y_NkC+dw-cFNc36v85TA@mail.gmail.com>
References: 
	<CAFftDdpyqOBEq8cw9S2R2J2y1WKR976j_Md5o7-cFChauDTCQw@mail.gmail.com>
	 <CAFftDdqzEUq8Om_KdeCUF1+LW_+2d5y_NkC+dw-cFNc36v85TA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-06-25 at 12:42 -0700, William Roberts wrote:
> Oops I wanted rw not just w.
> 
> 
> media app should have rw access to sdcard dir and files.

Thanks, merged.  Yes, we need to work through exactly which permissions
are required by each kind of app domain now that we have split up the
system apps.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
