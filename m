Date: Sun, 24 Aug 2003 21:32:21 +0100
From: Dale Amon <amon@vnl.com>
To: Colin Walters <walters@verbum.org>
Cc: Russell Coker <russell@coker.com.au>, Dale Amon <amon@vnl.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: 2.6.0-test3
Message-ID: <20030824203221.GA22620@vnl.com>
References: <20030822201709.GE12548@vnl.com> <200308231116.19099.russell@coker.com.au> <1061747236.7660.206.camel@columbia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1061747236.7660.206.camel@columbia>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 24, 2003 at 01:47:16PM -0400, Colin Walters wrote:
> I think the issue here is that my selinux-policy-default packages have a
> lower version than your selinux-policy-default packages.  I have only
> been testing my 2.6 packages with my selinux-policy-default package.

I wonder if there is a temporary work around. I could do a force-conflicts
if I was sure which package has the files which should over ride the 
other.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
