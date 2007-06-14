Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5EK2tx2029431
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 16:02:55 -0400
Received: from web36609.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5EK2rs2016638
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 20:02:53 GMT
Date: Thu, 14 Jun 2007 13:02:53 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
To: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>
Cc: Chad Sellers <csellers@tresys.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <1181843226.17547.669.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <374359.62085.qm@web36609.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:


> Actually, the funny thing there is that selinux=0 would have the same
> effect if you had stripped the suid bits.  Those applications would
> _only_ work with selinux enabled and enforcing.

Stephen's Evil Plan for World Domination revealed! I knew it!

I hope I'm kidding.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
