From: "david caplan" <dac@tresys.com>
To: "Stephen Smalley" <sds@tislabs.com>,
        "Russell Coker" <russell@coker.com.au>
Cc: "Chris Vance" <cvance@tislabs.com>, "Frank Mayer" <mayerf@tresys.com>,
        "SELinux" <SELinux@tycho.nsa.gov>
Subject: RE: [patch] label /home directory, create suserdel
Date: Mon, 30 Sep 2002 17:46:52 -0400
Message-ID: <GBEAJBKHFOBIBBJBCGAGKENMCFAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0209301103210.27156-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Our seuser tool (included in our setools package) now has a command line
option.  Actually, command line is now the default.  It is available at the
bottom of our SELinux page, http://www.tresys.com/selinux.html.

For those interested here is the extended usage:

$ seuser -h

Usage: seuser -g
       seuser -L
       seuser delete username [opts]
       seuser [add | change] username [opts] -r role1,role2,... [-d context
| -c context]

The -g form of this command will run a GUI.

The delete command will remove the specified user from the SE Linux policy.

The add/change commands will add/change a user and the user's policy
information.  Change will replace the entire user record, not
just change existing information.  Change/add options are:

     -r        authorized role(s)
     -d        default login context
     -c        default cron context
     context   an abbreviated security context of form "role:type"

Either or both of the -d or -c option must be specified for add/change.

Other options are:

     -L Load the updated policy; otherwise changes are made but not loaded.
               The -L option can be used separately so that you can make
several
               user account changes then only load the policy once after all
changes
               are made.


> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Stephen Smalley
> Sent: Monday, September 30, 2002 11:09 AM
> To: Russell Coker
> Cc: Chris Vance; Frank Mayer; SELinux
> Subject: Re: [patch] label /home directory, create suserdel
>
>
>
> On Mon, 30 Sep 2002, Russell Coker wrote:
>
> > The new suseradd doesn't deal with multiple user roles.
> Ideally we would have
> > a program that would add an entry to the users file, add a new user-role
> > definition to user.te (with appropriate role transitions), and
> add a default
> > type and a cron context as well.
>
> Some of this functionality may be available in the Tresys' setools.
> However, IMHO, suseradd shouldn't deal with creating new roles, just with
> adding users and possibly assigning them existing roles.  As a side note,
> please be aware that the /etc/security/default_context and
> /etc/security/cron_context files will be obsolete as of the next public
> release and their replacement will no longer require per-user entries.
>
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
