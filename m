Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Reino Wallin <reino@oribium.com>
Subject: Re: Firewall Policy
Date: Wed, 13 Mar 2002 08:06:16 +0100
Cc: Rik van Riel <riel@conectiva.com.br>, SELinux <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203120933540.10942-100000@raven> <1015984108.1595.45.camel@matilda.oribium.com>
In-Reply-To: <1015984108.1595.45.camel@matilda.oribium.com>
MIME-Version: 1.0
Message-Id: <20020313083719.B034970A5@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 13 Mar 2002 02:48, Reino Wallin wrote:
> > > To make the nameserver to work as a slave server, we may consider to
> > > grant write permissions to named_conf_t:dir and named_conf:file:
> >
> > I'd agree with Russell Coker's suggestion of defining a new type for
> > this purpose.
>
> I agree this is more secure. Should I use named_conf_t just for
> /etc/named.conf and then use a new type like dns_masterzone_t for
> /var/named/master and dns_slavezone_t for /var/named/slave ?

Sounds like a reasonable idea.

Also make the default policy:
allow named_t dns_masterzone_t:file r_file_perms;
allow named_t dns_masterzone_t:dir r_dir_perms;
With a comment suggesting rw_file_perms and rw_dir_perms for if you want 
dynamic updates (most people don't want it).

Then for the slave zones, a different domain for the named-xfer program to 
allow only that program to write the slave files would be good.  Then someone 
who cracks named can't change the zone files on disk.

> Thanks. Since there are just a few applications, and a few user accounts
> on a firewall, Russel Coker's suggestion to use nscd might be a good
> solution in this particular case. I will continue to define fine grained
> networking capabilities to the type enforcement files I am writing, and
> hopefully get more experiences.

Also some of the network access shouldn't be allowed.  I've already 
discovered one bug in a Debian library where a network socket was incorrectly 
set to allow it to remain open across exec through my tests of SE security 
policies.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
