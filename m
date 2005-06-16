Subject: Re: Content macros v 2 (create implies read in policy)
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: SELinux <SELinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1118864318.25735.43.camel@celtics.boston.redhat.com>
References: <1118744201.3416.13.camel@localhost.localdomain>
	 <1118770918.7853.5.camel@celtics.boston.redhat.com>
	 <1118855232.25735.10.camel@celtics.boston.redhat.com>
	 <1118864318.25735.43.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 20:17:31 -0400
Message-Id: <1118881051.9851.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 2) Stop trying to change the assumption that create implies
> read, and at the same time create further separation of
> content, beyond trusted and untrusted (as in...your saved mail
> is not the same thing as saved webpages, and mozilla
> has no business reading your mail). We might want to do
> that in the distant future anyway, regardless of this problem.
> Alter the content macros to deal with this improved level of
> granularity. 

On second thought I choose this option.

It's obvious why no write_file_perms exists - it's assumed
that we always want overwrite protection as well, so it
makes no sense to allow create_file_perms from multiple
apps on a data type that's supposed to be isolated.

It would be better to put some effort into different
content types, and the way they should interact instead,
so mozilla can't either read or overwrite your mail.

This is also the least intrusive option.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
