Message-ID: <20050720022904.28999.qmail@web31609.mail.mud.yahoo.com>
Date: Tue, 19 Jul 2005 19:29:04 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: RE: Latest diffs
To: Frank Mayer <mayerf@tresys.com>, "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Jim Carter'" <jwcart2@epoch.ncsc.mil>,
   "'SELinux'" <SELinux@tycho.nsa.gov>
In-Reply-To: <200507200203.j6K23jvx018651@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Frank Mayer <mayerf@tresys.com> wrote:
 
> In any case, an LSPP evaluation is different.

Yes indeed.

> I presume the reasoning has to
> do with label integrity and label exporting;

Those requirements can be meet fairly
simply, although it can take a bit of effort
to explain that you have meet them. Any
file system format with xattr based labels
should be a slam-dunk. For SELinux you will
no doubt have to include the policy files on
the file system as well, and compare them with
the system "live" policy files to ensure that
they are compatable. But the "same media"
requirement oughtn't be too big a challenge.

> non-issues for a C2/CAPP evaluation.

Truth.


Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
