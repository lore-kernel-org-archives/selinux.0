Message-ID: <437CBE8A.2020900@tresys.com>
Date: Thu, 17 Nov 2005 12:31:54 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Swigify libselinux
References: <437CBA8D.8050103@redhat.com>
In-Reply-To: <437CBA8D.8050103@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

<snip>
> +
> +extern int getseuserbyname(const char *linuxuser, char **seuser, char **level);
> +

Why not include the header so that API changes get reflected when 
changes are made?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
