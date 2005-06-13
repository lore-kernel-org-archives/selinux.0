Message-ID: <20050613220328.31770.qmail@web31602.mail.mud.yahoo.com>
Date: Mon, 13 Jun 2005 15:03:28 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Question about integration of IPsec with SELinux?
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050613213951.GB17617@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Luke Kenneth Casson Leighton <lkcl@lkcl.net>
wrote:


>  wilma@DOI1 has **nothing** to do with wilma@DOI2.

This is the sort of thing that seperates the
developers from the admins. Of course wilma@DOI1
isn't wilma@DOI2. Nonetheless, reams of
documentation and countless warnings
notwithstanding, the human that creates the mapping
between DOI1 and DOI2 will 99 44/100% of the time
map wilma directly to wilma. It's bad enough for
usernames. I see no reason to expect it to be
any better for policy constructs.

Username mapping errors are bad, but one or the
other of the individuals involved usually detects
the problem quickly enough. I don't know that I'd
expect the same to be true of policy elements.



Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Yahoo! Mail Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
