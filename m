Date: Mon, 30 Sep 2002 08:00:23 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Chris Vance <cvance@tislabs.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: [patch] label /home directory, create suserdel
In-Reply-To: <Pine.LNX.4.33.0209291546510.20607-300000@zorg.gw.tislabs.com>
Message-ID: <Pine.GSO.4.33.0209300756230.15004-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 29 Sep 2002, Chris Vance wrote:

> Attached are two patches (also committed to the sourceforge CVS tree) that
> define a new label for the /home directory and allow access as necessary.
> The first patch defines the new label and adds permissions.  The second
> patch add the suserdel program in the utils/spasswd directory.

Just to elaborate, the policy patch also defines a separate domain for
suseradd/suserdel with appropriate permissions and type transitions for
managing user home directories, and the spasswd patch also extends the
utilities to reset the security context on /etc/group and /etc/gshadow,
since these files are also re-created by the RedHat useradd to add a group
for each new user by default.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
