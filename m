Date: Fri, 27 Aug 2004 11:36:33 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
cc: Greg KH <greg@kroah.com>, <linux-hotplug-devel@lists.sourceforge.net>,
   SELinux <SELinux@tycho.nsa.gov>, <harald@redhat.com>,
   Bill Nottingham <notting@redhat.com>
Subject: Re: Cleaned up udev-selinux patch
In-Reply-To: <412F37D2.7070105@redhat.com>
Message-ID: <Xine.LNX.4.44.0408271136100.7706-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 27 Aug 2004, Daniel J Walsh wrote:

> Further cleanup and using all static inlines versus defines.  Renamed a 
> couple of functions to make them clearer.

I think Luke is right, these functions should be in a .c file.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
