Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, Chris Vance <cvance@tislabs.com>
Subject: Re: [patch] label /home directory, create suserdel
Date: Mon, 30 Sep 2002 16:58:58 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0209300756230.15004-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0209300756230.15004-100000@raven>
MIME-Version: 1.0
Message-Id: <200209301658.58246.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Sep 2002 14:00, Stephen Smalley wrote:
> On Sun, 29 Sep 2002, Chris Vance wrote:
> > Attached are two patches (also committed to the sourceforge CVS tree)
> > that define a new label for the /home directory and allow access as
> > necessary. The first patch defines the new label and adds permissions. 
> > The second patch add the suserdel program in the utils/spasswd directory.
>
> Just to elaborate, the policy patch also defines a separate domain for
> suseradd/suserdel with appropriate permissions and type transitions for
> managing user home directories, and the spasswd patch also extends the
> utilities to reset the security context on /etc/group and /etc/gshadow,
> since these files are also re-created by the RedHat useradd to add a group
> for each new user by default.

The Debian useradd also likes to add groups, but it's something I forgot about 
because I turn that feature off.  I don't like the "one group per user" 
thing.

The new suseradd doesn't deal with multiple user roles.  Ideally we would have 
a program that would add an entry to the users file, add a new user-role 
definition to user.te (with appropriate role transitions), and add a default 
type and a cron context as well.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
