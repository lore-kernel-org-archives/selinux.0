Date: Mon, 21 Jul 2008 12:19:23 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: Eric Paris <eparis@parisplace.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
Subject: About unifying the coding style
Message-ID: <Pine.LNX.4.64L.0807211208370.17053@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

I'm planning to do more trivial fixes to the SELinux kernel subsystem to
make the coding style look as unified as possible. Before continuing,
however, I would like to ask for an opinion, because I do not want to
waste my time.

There currently exist mixed styles such as:

  while (cur != NULL)

vs

  while (cur)

and of course the related "if"- and "for"-variants.

My questions:

1) Is there a general agreement that only one style should be used?

2) If answer to the question 1 is "yes", which one is the preferred style?

Thanks for the information.

Best regards,
vmk
--
************************************************************************
               Tietotekniikkaosasto / Helsingin yliopisto
                 IT Department / University of Helsinki
************************************************************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
