Date: Tue, 13 Apr 2004 10:53:38 -0700
From: Tom Mitchell <mitch48@sbcglobal.net>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Now that SELinux supports booleans should we replace tunables with booleans?
Message-ID: <20040413175338.GA713@xtl1.xtl.tenegg.com>
References: <407BF24E.90901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <407BF24E.90901@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Apr 13, 2004 at 09:59:42AM -0400, Daniel J Walsh wrote:

> Ideas?

The fewer decisions the kernel needs to make the better.  i.e. The
more decisions and analysis that can be make in advance of loading
policy the better.


-- 
	T o m  M i t c h e l l 
	/dev/null the ultimate in secure storage.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
