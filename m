From: Steve Grubb <sgrubb@redhat.com>
To: Dean Anderson <dean@av8.com>
Subject: Re: Decoder for log messages???
Date: Mon, 5 Nov 2007 18:15:12 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
References: <Pine.LNX.4.44.0711051620330.20094-100000@citation2.av8.net>
In-Reply-To: <Pine.LNX.4.44.0711051620330.20094-100000@citation2.av8.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711051815.13264.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 05 November 2007 04:28:29 pm Dean Anderson wrote:
> > We don't have enough information at the point where we do our permission
> > checks to reconstruct a pathname,
>
> ?? These checks are in open or exec. The full pathname should be
> available.

The audit system should pick up the name if you have at least one audit rule.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
