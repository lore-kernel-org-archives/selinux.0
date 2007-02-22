From: Steve Grubb <sgrubb@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: I think this is equivalent to what we have now and more efficient.
Date: Thu, 22 Feb 2007 10:15:21 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
References: <45DDAA80.80603@redhat.com>
In-Reply-To: <45DDAA80.80603@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702221015.21700.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 22 February 2007 09:36:48 Daniel J Walsh wrote:
>     } else {
>         struct stat buf;
>         return (stat("/proc/filesystems", &buf));
>     }

This doesn't tell you if a selinuxfs is available.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
