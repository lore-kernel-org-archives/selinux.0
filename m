Date: Wed, 16 Oct 2002 11:37:42 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: <SELinux@tycho.nsa.gov>
Subject: RE: initrd kernel panic
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524435@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0210161134240.24422-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 16 Oct 2002, Westerman, Mark wrote:

> Does the initrd need to be labeled ?

No, but you'll need to add some permissions to the policy related to the
initrd startup.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
