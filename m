Message-ID: <20050808174331.70367.qmail@web34312.mail.mud.yahoo.com>
Date: Mon, 8 Aug 2005 10:43:31 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Category Translation patch for MCS/MLS Policy
To: Daniel J Walsh <Dan-Walsh@comcast.net>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <42F38DA8.4090300@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Daniel J Walsh <Dan-Walsh@comcast.net> wrote:


> Comments?

In the Unix MLS systems we found that
allowing whitespace in label names was
a bad idea. We also found that aliases
(e.g. TS for TopSecret, secret for Secret)
are absolutely necessary. I will not
participate in the case sensitive/insensitive
debate, but y'all should have it over
with. Then there's my favorite issue,
that of whether a user cleared only to
Secret can see the lable names for TopSecret.

You may not chose to address all of these
issues, but you should be ready to
explain why they don't matter as you will
be asked.



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
