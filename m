Date: Mon, 30 Sep 2002 11:09:19 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Chris Vance <cvance@tislabs.com>, Frank Mayer <mayerf@tresys.com>,
        SELinux <SELinux@tycho.nsa.gov>
Subject: Re: [patch] label /home directory, create suserdel
In-Reply-To: <200209301658.58246.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209301103210.27156-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 30 Sep 2002, Russell Coker wrote:

> The new suseradd doesn't deal with multiple user roles.  Ideally we would have
> a program that would add an entry to the users file, add a new user-role
> definition to user.te (with appropriate role transitions), and add a default
> type and a cron context as well.

Some of this functionality may be available in the Tresys' setools.
However, IMHO, suseradd shouldn't deal with creating new roles, just with
adding users and possibly assigning them existing roles.  As a side note,
please be aware that the /etc/security/default_context and
/etc/security/cron_context files will be obsolete as of the next public
release and their replacement will no longer require per-user entries.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
