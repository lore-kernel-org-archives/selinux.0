Subject: Re: dynamic security class and access vector lookup
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40806121138x3bb0996asda149528809d4598@mail.gmail.com>
References: <cadfc0e40806121138x3bb0996asda149528809d4598@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 12 Jun 2008 14:48:47 -0400
Message-Id: <1213296527.17842.266.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-06-12 at 13:38 -0500, Xavier Toth wrote:
> I wasn't aware until yesterday that there was an API for looking up
> security classes (selinux_set_mapping, the name of which doesn't
> strike me as very intuitive). Can I also lookup the access vectors for
> a class, if so how?

selinux_set_mapping() does that too.  dynamic discovery of classes and
permissions was discussed quite a bit on list.  XSELinux uses it, and so
does SE-Postgres.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
