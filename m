Date: Fri, 12 Apr 2002 15:17:05 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: Howard Holm <hdholm@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
        Tom <tom@lemuria.org>, <SELinux@tycho.nsa.gov>
Subject: RE: db conflict ?
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152433D@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0204121514350.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Westerman, Mark wrote:

> Could you think about placing the policy sources
> into the /usr/local/selinux Directory
>
> For new version of selinux the install could look and
> see if there is a /usr/local/selinux/policy and setfiles
> if the directories are present the install will populate then
> with the example policy. If the directories are present just
> overwrite the /usr/local/selinux/share/doc/example files.

This is fine with me.  It merely involves adding a new target to the
policy and setfiles Makefiles to install the sources for the
configurations and then adjusting the README and quickinstall target to
include that step.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
