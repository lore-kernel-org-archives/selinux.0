Subject: Re: cannot login using strict policy
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <20070425145254.54446.qmail@web86913.mail.ukl.yahoo.com>
References: <20070425145254.54446.qmail@web86913.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 11:20:28 -0400
Message-Id: <1177514428.3428.118.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-25 at 14:52 +0000, JanuGerman wrote:
> I have installed strict policy and then relabelled the files using 'fixfiles relablel' after rebooting with 'enforcing=0 single'. Every thing went well, but when i try to login, i get an error message that 
> localuser:root being added to access control list
> -/bin/bash: /root/.bash_profile: permission denied.
> Any idea?

What is the type on /root/.bash_profile? Any avcs?

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
